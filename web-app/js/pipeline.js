var pipeline = (function(m, Backbone, _, dust, jsPlumb, Spinner, jsonstream) {
    'use strict';

    // models

    var _grailsModel = {
        readAction : 'show',
        createAction : 'create',
        updateAction : 'update',
        deleteAction : 'remove',

        // http://stackoverflow.com/questions/8731729/backbone-js-model-different-url-for-create-and-update

        methodToURL : {
            'read' : function() {
                return this.url + '/' + this.readAction
            },
            'create' : function() {
                return this.url + '/' + this.createAction
            },
            'update' : function() {
                return this.url + '/' + this.updateAction
            },
            'delete' : function() {
                return this.url + '/' + this.deleteAction
            },
        },

        sync : function(method, model, options) {
            options = options || {};
            // options.url = model.methodToURL[method.toLowerCase()];
            options.url = model.methodToURL[method.toLowerCase()].apply(model);
            return Backbone.sync(method, model, options);
        },

    };
    m.GrailsCollection = Backbone.Collection.extend(_grailsModel);
    m.GrailsModel = Backbone.Model.extend(_grailsModel);

    /* Models.
     * =============================================================================================
     */

    m.Dependency = m.GrailsModel.extend({
        /* A Dependency model corresponds to a haplorec.util.dependency.Dependency. That is, it has a 
         * dependsOn property, however the elements of dependsOn are TargetName's instead of 
         * other Dependency model's (DependencyGraph helps provide access to actual dependencies).
         */

        /* Override hashkey when storing a dependency model in a map (i.e. javascript object).
         */
        toString : function() {
            return this.get('target');
        }

    });
    m.DependencyFile = Backbone.Model.extend({
        filename : null,
        dependency : null,
    });

    m.Dependencies = m.GrailsCollection.extend({
        model : m.Dependency,
        url : 'dependencies',
    });

    m.DependencyGraph = m.GrailsModel.extend({
        /* A DependencyGraph model is a collection of dependencies.
         * It expects the following attributes:
         * {
         *     dependencies: {
         *         dependency1: {
         *             dependsOn: ['dependency2', 'dependency3', ...],
         *         },
         *         dependency2: {
         *         ...
         *         },
         *     },
         *     level: {
         *         dependency1: 0, 
         *         dependency2: 1, 
         *         ...
         *     },
         *     rowLevel: {
         *         dependency1: 0, 
         *         dependency2: 0, 
         *         ...
         *     },
         * }
         *
         * dependencies:
         * A mapping from target name to attributes for that dependency, which at the very least 
         * includes dependency information in dependsOn.  Dependencies may also include information 
         * required by whichever m.Views.DependencyGraph* view renders this model (see 
         * m.Views.DependencyGraphForm and m.Views.DependencyGraphShow).
         *
         * level:
         * A mapping from target name to its "level" in the dependency graph (refer to 
         * haplorec.util.dependency.Dependency.levels).
         *
         * rowLevel:
         * A mapping from target name to its "rowLevel" in the dependency graph, which corresponds 
         * to the row in which it should be placed on a grid relative to all other targets with the 
         * same "level" as it (refer to haplorec.util.dependency.Dependency.rowLvls).
         */
        url : 'dependencyGraph',

        /* Fields initialized during initialize.
         */

        /* Integer -> { TargetName }
         * A mapping from a level in the graph to targets at that level.
         */
        _levelToTargets : null,
        /* TargetName -> { Target }
         * A mapping from a target name to targets it depends on.
         */
        _dependsOn : null,
        /* TargetName -> Target
         * A mapping from target name to a target object (javascript only allows strings as keys in 
         * maps, hence why this is needed).
         */
        _dmap: null,
        /* TargetName -> { TargetName }
         * A mapping from target name to its dependants.
         */
        _dependants: null,
        /* The number of levels in the graph.
         */
        numLevels: null,

        initialize : function(attrs, options) {
            this.listenTo(this, 'change:level', this.initialize);

            this.set('dependencies', new m.Dependencies(this.get('dependencies')));

            var dmap = {};
            this.get('dependencies').forEach(function(d) {
                dmap[d] = d;
            });
            var dependsOn = {};
            this.get('dependencies').forEach(function(d) {
                dependsOn[d] = _.map(d.get('dependsOn'), function(dName) {
                    return dmap[dName];
                });
            });
            this._dmap = dmap;
            this._dependsOn = dependsOn;

            var dependants = {};
            this.get('dependencies').forEach(function(d) {
                dependants[d] = [];
            });
            var g = this;
            this.get('dependencies').forEach(function(t) {
                _.each(g.dependsOn(t), function(d) {
                    dependants[d].push(t);
                });
            });
            this._dependants = dependants;

            var levelToTargets = {};
            _.chain(this.get('level')).values().uniq().each(function(l) {
                levelToTargets[l] = [];
            });
            _.chain(this.get('level')).pairs().each(function(p) {
                var dependency = p[0];
                var l = p[1];
                levelToTargets[l].push(dependency);
            });
            this._levelToTargets = levelToTargets;

            var numLevels = _.chain(this.get('level')).values().max().value() + 1;
            this.set('numLevels', numLevels);

        },

        /* (Target|TargetName) -> Integer
         */
        level : function(t) {
            return this.get('level')[t];
        },

        /* (Target|TargetName) -> { Target }
         */
        dependsOn : function(t) {
            return this._dependsOn[t];
        },

        /* (Target|TargetName) -> { TargetName }
         */
        dependants : function(t) {
            return this._dependants[t];
        },

        /* Iterate over the dependencies in the order of dependencies at level 0 (in the order of 
         * their rowLevel), then at level 1, ..., etc.  In other words, iterate and bread-first 
         * search order (plus rowLevel) ordering.
         *
         * f takes the level of the current dependency, and the dependency object.
         */
        BFS : function(f) {
            var rmap=this.get('rowLevel');
            for ( var l = 0; l < this.get('numLevels'); l++) {
                var targets = this._levelToTargets[l];
                
                //Sort targets by their rowLevel
                var tarSort = Array(targets.length);
                for (var n=0; n < tarSort.length; n++){
                    tarSort[rmap[targets[n]]]=targets[n]
                }
                
                for ( var j = 0; j < tarSort.length; j += 1) {
                    f(l, this._dmap[tarSort[j]]);
                }
            }
        },

        /* Iterate over the dependencies the same way as BFS, except visit the levels of the 
         * dependency graph in reverse.
         *
         * f takes the level of the current dependency, and the dependency object.
         */
        reverseBFS : function(f) {
            var rmap=this.get('rowLevel');
            for ( var l = this.get('numLevels') - 1; l >= 0; l--) {
                var targets = this._levelToTargets[l];
                
                //Sort targets by their rowLevel
                var tarSort = Array(targets.length);
                for (var n=0; n < tarSort.length; n++){
                    tarSort[rmap[targets[n]]]=targets[n]
                }
                
                for ( var j = 0; j < tarSort.length; j += 1) {
                    f(l, this._dmap[tarSort[j]]);
                }
            }
        },

    });

    /* Views.
     * =============================================================================================
     */

    m.Views = {};

    m.Views.Dust = Backbone.View.extend({
        /* A view backed by a dustjs template; it's render function uses dustjs to render this.template,
         * which is a template path (defined in ApplicationResources.groovy).
         */
        render : function() {
            var that = this;
            dust.render(this.template, this.model.attributes, function(err, output) {
                if (err) {
                    throw err;
                }
                that.$el.html(output);
                if (that._init != undefined) {
                    that._init();
                }
            });
            return this;
        },

        /* Subclasses can optionally define this.
         *
         * If this._init is defined, it will be called (with no arguments) after rendering the 
         * template and adding it to the DOM.  So, this is where you can perform any post-javascript 
         * manipulation to set up your view.
         */
        _init : undefined,
    });

    m.Views.sampleinputfile = m.Views.Dust.extend({
        /* Render a template for displaying a sample input file for the pipeline.
         * The model it accepts has the following attributes:
         * {
         *     header: ['FIELD1', 'FIELD2', ...],
         *     rows: [
         *         [1, 2, ...],
         *         [4, 5, ...],
         *     ]
         * }
         */
        template : "pipeline/sampleinputfile",
    });

    m.Views.matrix = m.Views.Dust.extend({
        /* Render a template for displaying a gene-haplotype matrix.
         * The model is the JSON-ified version of haplorec.util.data.GeneHaplotypeMatrix.each (see 
         * JobPatientNovelHaplotype.geneHaplotypeMatrixJSON).
         *
         * Hence, the model it accepts has the following attributes (the JSON:
         * {
         *     geneName: "DPYD",
         *     snpIds: [
         *         "rs147545709",
         *         "rs1801158",
         *         "rs1801159",
         *         "rs1801160",
         *         "rs1801265",
         *         "rs1801266",
         *         "rs1801268",
         *         "rs3918290",
         *         "rs55886062",
         *         "rs72549303",
         *         "rs72549306",
         *         "rs72549309",
         *         "rs78060119",
         *         "rs80081766"
         *     ],
         *     haplotypes: [
         *         {
         *             haplotypeName: "*1",
         *             alleles: [ "C", "C", "T", "C", "A", "G", "C", "C", "A", "G", "C", "A", "C", "C" ]
         *         },
         *         {
         *             haplotypeName: "*10",
         *             alleles: [ "C", "C", "T", "C", "A", "G", "A", "C", "A", "G", "C", "A", "C", "C" ]
         *         },
         *         ...
         *     ],
         *     novelHaplotypes: [
         *         {
         *             sampleId: "NA11321-1",
         *             physicalChromosome: "A",
         *             hetCombo: 1,
         *             hetCombos: 1,
         *             alleles: [ "G", "G", null, "G", "T", "C", "G", "G", "A", "C", "C", "ATGA", "C", "C" ]
         *         },
         *         {
         *             sampleId: "NA11321-1",
         *             physicalChromosome: "B",
         *             hetCombo: 1,
         *             hetCombos: 1,
         *             alleles: [ "G", "G", null, "G", "T", "C", "G", "G", "A", "C", "C", "ATGA", "C", "C" ]
         *         },
         *         ...
         *     ]
         * }
         */
        template : "pipeline/matrix",
        _init : function() {
            var that = this;
            
            /* Since two tables are used to create the matrix, we must match up highlighting the rows 
             * and scrolling so the matrix acts like one table.
             */

            /* Highlighting:
             * If the mouse is on a row on one side of the matrix, add active class to highlight and 
             * use the row's index to highlight the row with the same index on the other side of the 
             * matrix.
             */
            this.$(".leftTable tr.rows").hover(
                    function(){
                        $(this).addClass('active');
                        $('.rightTable tr:eq(' + $('.leftTable tr').index($(this)) + ')').addClass('active');
                    },
                    function(){
                        $(this).removeClass('active');
                        $('.rightTable tr:eq(' + $('.leftTable tr').index($(this)) + ')').removeClass('active');
                    }
                );
            this.$(".rightTable tr.rows").hover(
                    function(){
                        $(this).addClass('active');
                        $('.leftTable tr:eq(' + $('.rightTable tr').index($(this)) + ')').addClass('active');
                    },
                    function(){
                        $(this).removeClass('active');
                        $('.leftTable tr:eq(' + $('.rightTable tr').index($(this)) + ')').removeClass('active');
                    }
                );
            
            /* Scrolling:
             * Matching up scrolling of alleles left and right with snp and up and down with 
             * haplotypes. Also, matching up scrolling of haplotypes left and right with 
             * haplotypeTitle.
             *
             * NOTE: you cannot scroll up and down on haplotypes unless you are scrolling on alleles 
             * the same with left and right on snp.
             */
            this.$('.alleles').scroll(function () {
                that.$(".haplotypes").scrollTop(that.$(".alleles").scrollTop());
            });
            this.$('.alleles').scroll(function () {
                that.$(".snp").scrollLeft(that.$(".alleles").scrollLeft());
            });
            this.$('.haplotypes').scroll(function () {
                that.$(".haplotypeTitle").scrollLeft(that.$(".haplotypes").scrollLeft());
            });
            
            /* Cell size:
             * Find if the tbody cell or the thead cell is larger and set both to the max for each 
             * coloumn.
             */
            function cell_size(classname){
                var max_header= that.$('th.'+classname).map(function(){ return $(this).width();});
                var max_body= that.$('td.'+classname).map(function(){ return $(this).width();});
                var max_width = new Array(max_header.length);
                for(var i=0;i< max_header.length;i++){
                    max_width[i]=Math.max(max_header[i],max_body[i]);
                }
                that.$("td."+classname).map(function(){
                    var column = $(this).index()
                    $(this).css("min-width",max_width[column])
                    });
                that.$("th."+classname).map(function(){
                    var column = $(this).index()
                    $(this).css("min-width",max_width[column])
                    });
            }
            cell_size("rightside");
            cell_size("leftside");
        },
    });
    
    //SPHINX matrixList start
    m.Views.matrixList = m.Views.Dust.extend({
        /* Render a list of gene-haplotype matrices by rendering one at a time with a drop-down for 
         * switching between them.
         *
         * The model is a list of matrix models.
         */
        template: "pipeline/novelHaplotypeReport",
        _init: function(){
            var matrices = this.model.get('matrices');
            var geneNameList = this.model.get('geneNameList');

            var that = this;
            var renderNextGene = function (matrixIndex, geneName) {
                var matrixView = new pipeline.Views.matrix({
                    model: new Backbone.Model(matrices[matrixIndex]),
                    el: that.$('.'+geneName),
                });
                matrixView.render();
            }
            for (var i=0; i < matrices.length; i++){
                renderNextGene(i,geneNameList[i]);    
            }
            function changeGene(){
                that.$(".matrixView").hide();
                var currentGene = that.$("select").val(); 
                that.$("."+currentGene).show();
            }
            changeGene();
            this.$("select").change(changeGene);
        },
    });
    //SPHINX matrixList end

    m.Views.DependencyFile = m.Views.Dust.extend({
        /* Render a file input dialog for a dependency in the graph.  Immediately ask the user for a 
         * for a file upon rendering.  If the user doesn't select a file, remove the file dialog.
         *
         * The model accepts the following attributes:
         * {
         *     dependency : new m.Views.Dependency(...),
         *     filename : "target1",
         * }
         *
         * filename:
         * The <input name="..."> attribute to use when submitting the form.
         */
        template : "pipeline/dependencyFile",
        className : "dependency-file",
        tagName : "div",
        _enabled : true,
        events : {
            'click .dependency-file-delete' : 'remove',
        },
        initialize : function() {
            this.listenTo(this.model, 'change', this.render);
        },
        _init : function() {
            this._input();
            this.hide();
            var that = this;
            this.$('.dependency-file-input').change(function() {
                if ($(this).val()) {
                    that.show();
                } else {
                    /* They didn't select a file. Remove this view.
                     */
                    that.remove();
                }
            });
        },
        enable : function() {
            this._enabled = true;
            this._input();
        },
        disable : function() {
            this._enabled = false;
            this._input();
        },
        hide : function() {
            this._old_display = this.$el.css('display');
            this.$el.css('display', 'none');
        },
        show : function() {
            this.$el.css('display', this._old_display);
        },
        /* Update <input disabled="..."> to reflect this._enabled.
         */
        _input : function() {
            this.$('.dependency-file-input').attr('disabled', !this._enabled);
        },
        /* Tigger the file selection dialog.
         */
        askForFile : function() {
            this.$('.dependency-file-input').click();
        },
    });
    m.Views.DependencyFile.header = [ 'Data', 'File', '' ];
    m.Views.DependencyFile.headerClassName = "dependency-file-header";

    m.Views.Dependency = m.Views.Dust.extend({
        /* Render a view for a dependency node in the graph.
         * The model is a m.Dependency.
         */
        template : "pipeline/dependency",
        className : "dependency",
        tagName : "span",
        initialize : function() {
            this.listenTo(this.model, 'change', this.render);
        },
    });

    m.Views.DependencyGraph = Backbone.View.extend({
        /* This provides the base visual functionality for a dependency graph view (i.e. arranging 
         * nodes in a grid, connecting them, highlighting them on roll-over). 
         *
         * It does not specify behaviour for what happens when nodes are clicked; subclasses 
         * implement this (see m.Views.DependencyGraphShow and m.Views.DependencyGraphForm).
         *
         * The model is a m.DependencyGraph.
         */

        /* We'll use an existing <div id="dependency-graph"></div> to render ourself in.
         */
        el : '#dependency-graph',
        className : 'dependency-graph-inner',
        height : null,
        dependencyFilesContainerClassName : 'dependency-files-container',
        /* Which view class to use for rendering dependencies; subclasses may override this.
         */
        DependencyView : m.Views.Dependency,

        /* TargetName -> { DependencyView }
         */
        dViews : undefined,

        highlight : function(node) {
            if (this.highlightedNode == null) {
                this.highlightedNode = node;
            }
            this.highlightedNode.$el.addClass('dependency-show').removeClass('dependency-file-upload-hover');
            node.$el.removeClass('dependency-show').addClass('dependency-file-upload-hover');
            this.highlightedNode = node;
        },

        highlightedNode : null,

        initialize : function() {
            /* Modify this.$el, which currently is <div id="dependency-graph"></div>, like so:
             *
             * // this.outerEl
             * <div id="dependency-graph" class="dependency-graph-outer">
             *     // this.$el
             *     <div class="dependency-graph-inner">
             *         // rendered DependencyView's
             *         <div id="targetName1">...</div>
             *         <div id="targetName2">...</div>
             *     </div>
             * </div>
             */
            var outerEl = this.$el;
            var inner = $(document.createElement('div')).addClass(this.className);
            if (this.options.height != null) {
                if (typeof this.options.height == "number") {
                    inner.height(this.options.height);
                } else {
                    inner.css('height', this.options.height);
                }
            }
            outerEl.addClass('dependency-graph-outer');
            outerEl.append(inner);
            this.$el = inner;
            this.outerEl = outerEl;

            this.listenTo(this.model, 'change', this.render);
            this.listenTo(this.model, 'destroy', this.remove);
            this.model.get('dependencies').on('change', this.render, this);

            this.dViews = {};
            var that = this;
            this.model.get('dependencies').each(function(d) {
                var view = new that.DependencyView({
                    model : d
                });
                that.dViews[d] = view;
            });

            _.each(this.dependencyViews(), function(v) {
                v.render();
                v.$el.attr('id', v.model.get('target'));
                that.$el.append(v.$el);
            });
            /* Setup the dependency graph using jsPlumb.
             */
            this._arrange();
            this._addConnections();

        },

        /* TargetName -> DependencyView
         */
        dependencyView : function(targetName) {
            return this.dViews[targetName];
        },

        /* { DependencyView }
         */
        dependencyViews : function() {
            return _.values(this.dViews);
        },

        /* Arrange the DependencyView's in the graph into a grid, where for each dependency d:
         *
         * row = rowLevel[d] (rowLevel from m.DependencyGraph)
         * column = level[d] (level from m.DependencyGraph)
         *
         * Also, make sure the dependencies are centered (vertically and horizontally) about there 
         * position in the grid.
         *
         * We're using absolute positioning, so sadly the graph is not responsive to window resizes.
         */
        _arrange : function() {
            var W = this.$el.width();
            var H = this.$el.height();

            var that = this;
            var eachCell = function(f) {
                /* Iterates over the dependencies in row and column order.
                 * i.e.
                 * (0, 0), (0, 1), (1, 0), (1, 1), ...
                 *
                 * f takes the row, column, dependency model, and dependency view.
                 */
                var n = that.model.get('numLevels');
                /* reverseBFS already iterates over dependencies by rowLevel, so row is just how 
                 * many dependencies we've seen so far at the same level. 
                 */
                var row = 0;
                var lastLevel = that.model.get('numLevels') - 1;
                that.model.reverseBFS(function(l, d) {
                    if (l != lastLevel) {
                        /* We're starting to iterate over dependencies at the next level.
                         */
                        row = 0;
                    }
                    /* The column is just the level, but inverted.
                     * i.e. 
                     * level 0 -> column $(number of levels) - 1
                     * level 1 -> column $(number of levels) - 2
                     * ...
                     * level $(number of levels) - 1 -> column 0
                     */
                    var column = (n - 1) - l;
                    var view = that.dViews[d];
                    f(row, column, d, view);
                    lastLevel = l;
                    row += 1;
                });
            }

            /* Int -> Int
             * Sum of the widths of nodes at the ith row.
             */
            var sumWidth = {};
            /* Int -> Int
             * Max width node in the ith column.
             */
            var maxWidth = {};
            /* Int -> Int
             * Number of nodes in the ith column.
             */
            var numCol = {};

            /* Int -> Int
             * Sum of the heights of nodes at the ith column.
             */
            var sumHeight = {};
            /* Int -> Int
             * Max height node in the ith row.
             */
            var maxHeight = {};
            /* Int -> Int
             * Number of nodes in the ith row.
             */
            var numRow = {};

            eachCell(function(row, column, d, view) {
                /* Calculates sumWidth, maxWidth, numCol, sumHeight, maxHeight, numRow.
                 */
                var calcDim = function(sumDim, maxDim, numDim, viewDim, cellDim) {
                    maxDim[cellDim] = (maxDim[cellDim] > viewDim) ? maxDim[cellDim] : viewDim;
                    numDim[cellDim] = (numDim[cellDim] || 0) + 1;
                }
                sumWidth[row] = (sumWidth[row] || 0) + view.$el.outerWidth();
                sumHeight[column] = (sumHeight[column] || 0) + view.$el.outerHeight();
                calcDim(sumWidth, maxWidth, numCol, view.$el.outerWidth(), column);
                calcDim(sumHeight, maxHeight, numRow, view.$el.outerHeight(), row);
            });

            eachCell(function(row, column, d, view) {
                /* Use the sums/maxes computed above to calculate each node's pixel position, 
                 * centered about its grid position (both vertically and horizontally).
                 *
                 * In particular, for a dependency d at coordinate (i, j), 
                 * with a total of m rows and n columns:
                 *
                 * W = width of canvas
                 *
                 * Horizontal space between columns:
                 * horiz = 
                 *     ( W - sum { max width of nodes in column 0..n-1 } ) / 
                 *     ( { number of nodes in row i } - 1 )
                 *
                 * x = sum { max width of nodes in column 0..j-1 } + 
                 *     j*horiz +
                 *     ( { max width at column i } - width(d) ) / 2         // centered about column
                 *
                 * Same idea for y (swap width with height, and column with row).
                 *
                 * NOTE: for the best explanation, see the picture in the "Positioning of the 
                 * targets" section of the "Dependency Graph" documentation.
                 */
                var sum = function(xs) {
                    /* Sum a list of numbers.
                     */
                    return _.reduce(xs, function(acc, e) {
                        return acc + e
                    }, 0)
                };
                var values = function(obj, start, end) {
                    /* Return obj[start..end-1].
                     */
                    var xs = [];
                    for (var i = start; i < end; i++) {
                        xs.push(obj[i]);
                    }
                    return xs;
                }
                var horiz = (W - sum(_.values(maxWidth))) / (_.chain(numRow).values().max().value() - 1);
                var vert = (H - sum(_.values(maxHeight))) / (_.chain(numCol).values().max().value() - 1);
                var x = (sum(values(maxWidth, 0, column))) + column*horiz + (maxWidth[column] - view.$el.outerWidth())/2;
                var y = (sum(values(maxHeight, 0, row))) + row*vert + (maxHeight[row] - view.$el.outerHeight())/2;
                view.$el.css('left', x);
                view.$el.css('top', y);
            });

        },

        render : function() {
            /* Rendering is done during initialize.
             */
        },

        /* Use jsPlumb to connect nodes in the graph.
         *
         * Each dependency relationship (e.g. B depends on A) has it's own line in the graph, and 
         * each line uses its own pair of endpoints.
         *
         * Given that B depends on A:
         *     If A occurs on a different level than B: 
         *         we draw a connector from the rightside of A to the leftside of B.
         *     Otherwise, A occurs on the same level as B: 
         *         we draw a connector from the bottom of A to the top of B.
         *
         * The endpoints on the left/right/top/bottom of a node are non-overlapping and centered.
         *
         * NOTE: _arrange should have been called before calling this.
         */
        _addConnections : function() {

            /* I'm puzzled why I need to add this all of a sudden (otherwise the render mode is 
             * undefined)...
             */
            jsPlumb.setRenderMode(jsPlumb.SVG);

            var g = this.model;

            /* Endpoint identifiers (used by jsPlumb). 
             * Given that B depends on A, A is the src and B is the dst.
             */
            var srcUUID = function(d, t) {
                return d.get('target') + '_' + t.get('target') + '_' + 'src';
            };
            var dstUUID = function(d, t) {
                return d.get('target') + '_' + t.get('target') + '_' + 'dst';
            };

            var endpointStyle = {
                /* I can't seem to get arrow heads to show up....
                 * http://stackoverflow.com/questions/14984820/connector-style-not-being-applied-to-jsplumb-connector-when-created-dynamically
                 */
                endpoint : [ "Dot", {
                    radius : 4
                } ],
                endpointStyle : {
                    fillStyle : "#00BFFF"
                },
                setDragAllowedWhenFull : true,
                paintStyle : {
                    strokeStyle : "#00BFFF",
                    lineWidth : 2
                },
                connector : [ "Straight" ],
                connectorStyle : {
                    lineWidth : 2,
                    strokeStyle : "#00BFFF"
                },
                overlays : [ [ "Arrow", {
                    width : 10,
                    length : 10,
                    foldback : 1,
                    location : 1,
                    id : "arrow"
                } ] ]
            };

            /* Add endpoints.
             */
            g.reverseBFS(function(l, t) {

                var addEndpoint = function(uuid, pointLocation, endpoints, style) {
                    /* Create jsPlumb endpoints for the current node t.  Given endpoint nodes we 
                     * want to connect t to (either dependencies or dependants of t), calculates the 
                     * number of those endpoints in the same/different level as t, and passes this 
                     * information to pointLocation so it can decide which side to place the 
                     * endpoint (and how to centre it).
                     */

                    /* Number of endpoints on the same / different level for the current node t.
                     */
                    var D = _.countBy(endpoints, function(d) {
                        return g.level(d) == g.level(t) ? 'same' : 'different';
                    });
                    var s = D.same || 0;
                    var n = D.different || 0;
                    /* The i-th same/different node.
                     */
                    var s_i = 0;
                    var n_i = 0;
                    _.each(endpoints, function(e, i) {
                        var sameLevel = g.level(e) == g.level(t);
                        var p = pointLocation(sameLevel, s, n, (sameLevel ? s_i : n_i) + 1);
                        if (sameLevel) {
                            s_i += 1;
                        } else {
                            n_i += 1;
                        }
                        /* Assume the dependency view uses its model's target name as its html id.
                         */
                        jsPlumb.addEndpoint(t.get('target'), style, {
                            anchor : p,
                            uuid : uuid(e)
                        });
                    });
                };

                if (l != 0) {
                    /* This is not a node with zero dependants.
                     * Add src (right/bottom) endpoints to t for its dependants.
                     */
                    addEndpoint(function(d) {
                        return srcUUID(t, d)
                    }, function(sameLevel, s, n, i) {
                        return sameLevel ? 
                            // center endpoint on bottom of node
                            [ i * (1 / (s + 1)), 1, -1, 0 ] : 
                            // center endpoint on right of node
                            [ 1, i * (1 / (n + 1)), -1, 0 ];
                    }, g.dependants(t), $.extend({}, endpointStyle, {
                        isSource : true
                    }));
                }

                if (l != g.get('numLevels') - 1) {
                    /* This is not a leaf (rightmost) node in the dependency graph, so it has dependencies.
                     * Add dst (left/top) endpoints to t for its dependencies.
                     */
                    addEndpoint(function(d) {
                        return dstUUID(d, t)
                    }, function(sameLevel, s, n, i) {
                        return sameLevel ? 
                            // center endpoint on top of node
                            [ i * (1 / (s + 1)), 0, -1, 0 ] : 
                            // center endpoint on left of node
                            [ 0, i * (1 / (n + 1)), -1, 0 ];
                    }, g.dependsOn(t), $.extend({}, endpointStyle, {
                        isTarget : true
                    }));
                }

            });

            /* Add connections.
             */
            g.BFS(function(l, t) {
                _.each(g.dependsOn(t), function(d) {
                    jsPlumb.connect({
                        uuids : [ srcUUID(d, t), dstUUID(d, t) ],
                        editable : true
                    });
                });
            });
        },

    });

    // TOOD: refactor onclick file additions into this class
    m.Views.DependencyGraphForm = m.Views.DependencyGraph.extend({
        DependencyView : m.Views.Dependency.extend({
            _init : function() {
                if (!this.model.get('fileUpload')) {
                    this.$el.addClass('dependency-no-file-upload');
                } else {
                    this.$el.addClass('dependency-file-upload');
                }
            },
        }),

        initialize : function(options) {
            this.constructor.__super__.initialize.apply(this, [options]);

            this.dependencySampleInputContainer = $(document.createElement('div'));
            this.outerEl.append(this.dependencySampleInputContainer);

            this.dependencyFilesContainer = $(document.createElement('div')).addClass(this.dependencyFilesContainerClassName);
            this.outerEl.append(this.dependencyFilesContainer);

            this.dependencyFilesHeader = $(document.createElement('div')).addClass(m.Views.DependencyFile.headerClassName);
            var that = this;
            _.each(m.Views.DependencyFile.header, function(h) {
                var span = $(document.createElement('span'));
                span.html(h);
                that.dependencyFilesHeader.append(span);
            });
            this.dependencyFilesContainer.append(this.dependencyFilesHeader);
            _.each(this.dependencyViews(), function(v) { 

                // fileUpload indicates whether this is an dependency that accepts input
                if (v.model.get('fileUpload')) {
                    // when a dependency is clicked on,
                    // ask for a file
                    var i = 0;
                    v.$el.click(function() {
                        var dFileView = new m.Views.DependencyFile({
                            model : new m.DependencyFile({
                                dependency : v.model,
                                filename : v.model.get('target') + i,
                            }),
                        });
                        i += 1;
                        that.dependencyFilesContainer.append(dFileView.render().$el);
                        dFileView.askForFile();
                    });

                    // when a dependency is rolled over,
                    // show a sample input file
                    v.$el.mouseover(function() {
                        that.highlight(v);
                        if (typeof v.model.get('rows') != "undefined" && typeof v.model.get('header') != "undefined") {
                            var saminp = new m.Views.sampleinputfile({
                                model : new Backbone.Model({
                                    rows : v.model.attributes.rows,
                                    header : v.model.attributes.header,
                                }),
                            });
                            that.dependencySampleInputContainer.html("<h4>Sample Input File:</h4>");
                            that.dependencySampleInputContainer.append(saminp.render().$el);
                        } else {
                            // if we don't have a dependency file, just clear the container
                            that.dependencySampleInputContainer.empty();
                        }
                    });
                }

            });
        },

    });
    // TOOD: refactor onclick file additions into this class
    m.Views.DependencyGraphShow = m.Views.DependencyGraph.extend({
        DependencyView : m.Views.Dependency.extend({
            template : "pipeline/dependencyShow",
            _init : function() {
                this.$el.addClass('dependency-show');
            },
        }),

        router : null,

        fetchAsync : function(index) {
            return true;
        },

        initialize : function(options) {
            this.constructor.__super__.initialize.apply(this, [ options ]);

            this.router = new m.Routers.DependencyGraphShowRouter({
                view : this
            });

            this.listContainer = $(document.createElement('div'));
            this.outerEl.append(this.listContainer);

            // when a dependency is clicked on, load its server-side list view
            var that = this;
            _.each(this.dependencyViews(), function(v) {
                v.$el.click(function() {
                    // that.highlight(v);
                    // that.visit(
                    // v.model.get('listUrl'),
                    // {
                    // jobId: v.model.get('jobId'),
                    // }
                    // );
                    that.select(v);
                    var target = that.highlightedNode.model.get('target');
                    that.router.navigate(target);
                });
            });

        },

        select : function(dependencyView) {
            this.highlight(dependencyView);
            this.visit(dependencyView.model.get('listUrl'), {
                jobId : dependencyView.model.get('jobId'),
            });
        },

        // load a url in a div below the graph
        visit : function(url, params) {
            var request = $.get(url, params);
            var that = this;
            request.done(function(data) {
                that.listContainer.html(data);
                that._hackLinks(that.listContainer);
            });
        },

        _hackLinks : function(el) {
            /*
             * Hack links in el to fetch asynchronously and load inside el
             * instead of linking to a new page.
             */
            var that = this;
            el.find('a').filter(that.fetchAsync).each(function(i, a) {
                var $a = $(a);
                $a.click(function(event) {
                    event.preventDefault();
                    var link = $a.attr('href');
                    var target = that.highlightedNode.model.get('target');
                    // that.router.targetAt(that.highlightedNode.model.get('target'),
                    // link);
                    that.visit(link);
                    // record this link in our history
                    that.router.navigate(target + '/link' + link);
                });
            });

        },
    });

    // routers
    m.Routers = {};

    m.Routers.DependencyGraphShowRouter = Backbone.Router.extend({

        initialize : function(options) {
            this.view = options.view;
        },

        routes : {
            ":target" : "target",
            ":target/link/*link" : "targetAt",
        },

        targetAt : function(target, link) {
            var dView = this.view.dependencyView(target)
            if (typeof dView !== 'undefined') {
                this.view.highlight(dView);
                this.view.visit('/' + link);
            }
        },

        target : function(target) {
            var dView = this.view.dependencyView(target)
            if (typeof dView !== 'undefined') {
                this.view.select(dView);
            }
        },

    });

    return m;
})(pipeline || {}, Backbone, _, dust, jsPlumb, Spinner, jsonstream);

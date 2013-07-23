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

	m.Dependency = m.GrailsModel.extend({
		// Override hashkey when storing a dependency model in a map (i.e.
		// javascript object).
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

	m.DependencyGraph = m.GrailsModel
			.extend({
				url : 'dependencyGraph',

				_levelToTargets : null,
				_dependsOn : null,

				initialize : function(attrs, options) {
					this.listenTo(this, 'change:level', this.initialize);

					this.set('dependencies', new m.Dependencies(this
							.get('dependencies')));

					var dmap = {};
					this.get('dependencies').forEach(function(d) {
						dmap[d] = d;
					});
					var dependsOn = {};
					this.get('dependencies').forEach(
							function(d) {
								dependsOn[d] = _.map(d.get('dependsOn'),
										function(dName) {
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
					_.chain(this.get('level')).values().uniq().each(
							function(l) {
								levelToTargets[l] = [];
							});
					_.chain(this.get('level')).pairs().each(function(p) {
						var dependency = p[0];
						var l = p[1];
						levelToTargets[l].push(dependency);
					});
					// this.set('_levelToTargets', levelToTargets);
					this._levelToTargets = levelToTargets;

					var numLevels = _.chain(this.get('level')).values().max()
							.value() + 1;
					this.set('numLevels', numLevels);

				},

				level : function(t) {
					return this.get('level')[t];
				},

				dependsOn : function(t) {
					return this._dependsOn[t];
				},

				dependants : function(t) {
					return this._dependants[t];
				},

				// iterate over the dependencies in reverse breadth-first-search
				// fashion
				reverseBFS : function(f) {
					for ( var l = this.get('numLevels') - 1; l >= 0; l--) {
						var targets = this._levelToTargets[l];
						for ( var j = 0; j < targets.length; j += 1) {
							f(l, this._dmap[targets[j]]);
						}
					}
				},

				// iterate over the dependencies in reverse breadth-first-search
				// fashion
				BFS : function(f) {
					for ( var l = 0; l < this.get('numLevels'); l++) {
						var targets = this._levelToTargets[l];
						for ( var j = 0; j < targets.length; j += 1) {
							f(l, this._dmap[targets[j]]);
						}
					}
				},
			});

	// views
	m.Views = {};

	// a view backed by a dustjs template; it's render function uses dustjs
	// to render this.template
	m.Views.Dust = Backbone.View.extend({
		render : function() {
			var that = this;
			dust.render(this.template, this.model.attributes, function(err,
					output) {
				if (err) {
					throw err;
				}
				that.$el.html(output);
				if (that._init != undefined) {
					that._init();
				}
			});
			return this;
		}
	});
	m.Views.sampleinputfile = m.Views.Dust.extend({
		template : "pipeline/sampleinputfile",
	});

	m.Views.matrix = m.Views.Dust.extend({
		template : "pipeline/matrix",
		_init : function() {
            var that = this;
            
            //highlighting
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
        	
        	//scrolling
            this.$('.haplotypes').scroll(function () {
                that.$(".alleles").scrollTop(that.$(".haplotypes").scrollTop());
            });
            this.$('.alleles').scroll(function () {
                that.$(".haplotypes").scrollTop(that.$(".alleles").scrollTop());
            });
            this.$('.snp').scroll(function () {
                that.$(".alleles").scrollLeft(that.$(".snp").scrollLeft());
            });
            this.$('.alleles').scroll(function () {
                that.$(".snp").scrollLeft(that.$(".alleles").scrollLeft());
            });
            this.$('.haplotypes').scroll(function () {
                that.$(".haplotypeTitle").scrollLeft(that.$(".haplotypes").scrollLeft());
            });
            //cell size
            function cell_size(classname){
            	var max_header= Math.max.apply(Math, that.$('th.'+classname).map(function(){ return $(this).width(); }).get());
            	var max_body= Math.max.apply(Math, that.$('td.'+classname).map(function(){ return $(this).width(); }).get());
            	var max_cell= Math.max(max_header, max_body);
        		that.$("td."+classname).css("min-width",max_cell);
        		that.$("th."+classname).css("min-width",max_cell);
        	}
            cell_size("rightside");
        	cell_size("leftside");
		},
	});
	
	m.Views.matrixList = m.Views.Dust.extend({
		template: "pipeline/novelHaplotypeReport",
		_init: function(){
			var currentGene;
			var matrices = this.model.get('matrices');
			var geneNameList = this.model.get('geneNameList');

            var that = this;
            var renderNextGene = function (matrixIndex, cName) {
                currentGene = new pipeline.Views.matrix({
                    model: new Backbone.Model(matrices[matrixIndex]),
                    el: that.$('.'+cName),
                });
                currentGene.render();
            }
			
            for (var i=0; i < matrices.length; i++){
            	renderNextGene(i,geneNameList[i]);	
            }
            
            this.$(".matrixView").hide();
            var w = $("select").val(); 
            this.$("."+w).show();
            
            this.$("select").change(function(){
            	$(".matrixView").hide();
                var w = $("select").val(); 
                $("."+w).show();
            });
            //renderNextGene(0);
			
			/*this.$("select").change(function(){
                var currentGeneName = $(this).val();
                var matrixIndex = geneNameList.indexOf(currentGeneName);
                renderNextGene(matrixIndex);
            });*/
        },
	});

	m.Views.DependencyFile = m.Views.Dust.extend({
		template : "pipeline/dependencyFile",
		className : "dependency-file",
		tagName : "div",
		_enabled : true,
		events : {
			'click .dependency-file-delete' : 'remove',
		// 'click .dependency-file-input' : 'askForFile',
		},
		initialize : function() {
			this.listenTo(this.model, 'change', this.render);
			// if (this.model) {
			// this.render();
			// }
		},
		_init : function() {
			this._input();
			this.hide();
			var that = this;
			this.$('.dependency-file-input').change(function() {
				if ($(this).val()) {
					that.show();
				} else {
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
		_input : function() {
			this.$('.dependency-file-input').attr('disabled', !this._enabled);
		},
		askForFile : function() {
			this.$('.dependency-file-input').click();
		},
	});
	m.Views.DependencyFile.header = [ 'Data', 'File', '' ];
	m.Views.DependencyFile.headerClassName = "dependency-file-header";

	m.Views.Dependency = m.Views.Dust.extend({
		template : "pipeline/dependency",
		className : "dependency",
		tagName : "span",
		initialize : function() {
			this.listenTo(this.model, 'change', this.render);
		},
	});

	m.Views.DependencyGraph = Backbone.View
			.extend({
				el : '#dependency-graph',
				className : 'dependency-graph-inner',
				height : null,
				dependencyFilesContainerClassName : 'dependency-files-container',
				DependencyView : m.Views.Dependency,

				events : {},

				// The DOM events specific to an item.
				// events: {
				// 'click .toggle': 'toggleCompleted',
				// 'dblclick label': 'edit',
				// 'click .destroy': 'clear',
				// 'keypress .edit': 'updateOnEnter',
				// 'blur .edit': 'close'
				// },

				highlight : function(node) {
					if (this.highlightedNode == null) {
						this.highlightedNode = node;
					}
					this.highlightedNode.$el.addClass('dependency-show')
							.removeClass('dependency-file-upload-hover');
					node.$el.removeClass('dependency-show').addClass(
							'dependency-file-upload-hover');
					this.highlightedNode = node;
				},

				highlightedNode : null,

				initialize : function() {
					var outerEl = this.$el;
					var inner = $(document.createElement('div')).addClass(
							this.className);
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
					this.model.get('dependencies').on('change', this.render,
							this);

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
					// setup the dependency graph using jsPlumb
					this._arrange();
					this._addConnections();

				},

				dependencyView : function(targetName) {
					return this.dViews[targetName];
				},

				dependencyViews : function() {
					return _.values(this.dViews);
				},

				_arrange : function() {
					// I think these are always integers representing pixels
					var W = this.$el.width();
					var H = this.$el.height();

					var that = this;
					var eachCell = function(f) {
						var n = that.model.get('numLevels');
						var row = 0;
						var lastLevel = that.model.get('numLevels') - 1;
						that.model.reverseBFS(function(l, d) {
							if (l != lastLevel) {
								row = 0;
							}
							var column = (n - 1) - l;
							var view = that.dViews[d];
							f(row, column, d, view);
							lastLevel = l;
							row += 1;
						});
					}

					/*
					 * sumWidth Int -> Int: sum of the widths of nodes at the
					 * ith row maxWidth Int -> Int: max width node in the ith
					 * column numCol Int -> Int: number of nodes in the ith
					 * column
					 */
					var sumWidth = {};
					var maxWidth = {};
					var numCol = {};
					/*
					 * sumHeight Int -> Int: sum of the heights of nodes at the
					 * ith column maxHeight Int -> Int: max height node in the
					 * ith row numRow Int -> Int: number of nodes in the ith row
					 */
					var sumHeight = {};
					var maxHeight = {};
					var numRow = {};
					eachCell(function(row, column, d, view) {
						var calcDim = function(sumDim, maxDim, numDim, viewDim,
								cellDim) {
							maxDim[cellDim] = (maxDim[cellDim] > viewDim) ? maxDim[cellDim]
									: viewDim;
							numDim[cellDim] = (numDim[cellDim] || 0) + 1;
						}
						sumWidth[row] = (sumWidth[row] || 0)
								+ view.$el.outerWidth();
						sumHeight[column] = (sumHeight[column] || 0)
								+ view.$el.outerHeight();
						calcDim(sumWidth, maxWidth, numCol, view.$el
								.outerWidth(), column);
						calcDim(sumHeight, maxHeight, numRow, view.$el
								.outerHeight(), row);
					});

					eachCell(function(row, column, d, view) {
						var sum = function(xs) {
							return _.reduce(xs, function(acc, e) {
								return acc + e
							}, 0)
						};
						var values = function(obj, start, end) {
							var xs = [];
							for ( var i = start; i < end; i++) {
								xs.push(obj[i]);
							}
							return xs;
						}
						var horiz = (W - sum(_.values(maxWidth)))
								/ (_.chain(numRow).values().max().value() - 1);
						var vert = (H - sum(_.values(maxHeight)))
								/ (_.chain(numCol).values().max().value() - 1);
						var x = (sum(values(maxWidth, 0, column))) + column
								* horiz
								+ (maxWidth[column] - view.$el.outerWidth())
								/ 2;
						var y = (sum(values(maxHeight, 0, row))) + row * vert
								+ (maxHeight[row] - view.$el.outerHeight()) / 2;
						view.$el.css('left', x);
						view.$el.css('top', y);
					});

				},

				render : function() {
					// dViews get rendered during _init
				},

				_addConnections : function(d) {
					// I'm puzzled why I need to add this all of a sudden (o/w
					// the render mode is undefined)...
					jsPlumb.setRenderMode(jsPlumb.SVG);
					var g = this.model;

					var srcUUID = function(d, t) {
						return d.get('target') + '_' + t.get('target') + '_'
								+ 'src';
					};
					var dstUUID = function(d, t) {
						return d.get('target') + '_' + t.get('target') + '_'
								+ 'dst';
					};

					/*
					 * Add endpoints.
					 */
					// the definition of target endpoints (will appear when the
					// user drags a connection)
					var endpointStyle = {
						// I can't seem to get arrow heads to show up.... sigh
						// http://stackoverflow.com/questions/14984820/connector-style-not-being-applied-to-jsplumb-connector-when-created-dynamically
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
					g.reverseBFS(function(l, t) {
						var addEndpoint = function(uuid, pointLocation,
								endpoints, style) {
							// # of endpoints on the same / different level
							var D = _.countBy(endpoints, function(d) {
								return g.level(d) == g.level(t) ? 'same'
										: 'different'
							});
							var s = D.same || 0;
							var n = D.different || 0;
							var s_i = 0;
							var n_i = 0;
							_.each(endpoints, function(e, i) {
								var sameLevel = g.level(e) == g.level(t);
								var p = pointLocation(sameLevel, s, n,
										(sameLevel ? s_i : n_i) + 1);
								if (sameLevel) {
									s_i += 1;
								} else {
									n_i += 1;
								}
								jsPlumb.addEndpoint(t.get('target'), style, {
									anchor : p,
									uuid : uuid(e)
								});
							});
						};
						if (l != g.get('numLevels') - 1) {
							// add leftside (dst) endpoints to t
							addEndpoint(function(d) {
								return dstUUID(d, t)
							}, function(sameLevel, s, n, i) {
								return sameLevel ? [ i * (1 / (s + 1)), 0, -1,
										0 ] : [ 0, i * (1 / (n + 1)), -1, 0 ];
							}, g.dependsOn(t), $.extend({}, endpointStyle, {
								isTarget : true
							}));
						}
						if (l != 0) {
							// add rightside (src) endpoints to t
							addEndpoint(function(d) {
								return srcUUID(t, d)
							}, function(sameLevel, s, n, i) {
								return sameLevel ? [ i * (1 / (s + 1)), 1, -1,
										0 ] : [ 1, i * (1 / (n + 1)), -1, 0 ];
							}, g.dependants(t), $.extend({}, endpointStyle, {
								isSource : true
							}));
						}
					});

					/*
					 * Add connections.
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
	m.Views.DependencyGraphForm = m.Views.DependencyGraph
			.extend({
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
					this.constructor.__super__.initialize.apply(this,
							[ options ]);

					this.dependencySampleInputContainer = $(document
							.createElement('div'));
					this.outerEl.append(this.dependencySampleInputContainer);

					this.dependencyFilesContainer = $(
							document.createElement('div')).addClass(
							this.dependencyFilesContainerClassName);
					this.outerEl.append(this.dependencyFilesContainer);

					this.dependencyFilesHeader = $(
							document.createElement('div')).addClass(
							m.Views.DependencyFile.headerClassName);
					var that = this;
					_.each(m.Views.DependencyFile.header, function(h) {
						var span = $(document.createElement('span'));
						span.html(h);
						that.dependencyFilesHeader.append(span);
					});
					this.dependencyFilesContainer
							.append(this.dependencyFilesHeader);

					_
							.each(
									this.dependencyViews(),
									function(v) {

										// fileUpload indicates whether this is
										// an dependency that accepts input
										if (v.model.get('fileUpload')) {
											// when a dependency is clicked on,
											// ask for a file
											var i = 0;
											v.$el
													.click(function() {
														var dFileView = new m.Views.DependencyFile(
																{
																	model : new m.DependencyFile(
																			{
																				dependency : v.model,
																				filename : v.model
																						.get('target')
																						+ i,
																			}),
																});
														i += 1;
														that.dependencyFilesContainer
																.append(dFileView
																		.render().$el);
														dFileView.askForFile();
													});

											// when a dependency is rolled over,
											// show a sample input file
											v.$el
													.mouseover(function() {
														that.highlight(v);
														if (typeof v.model
																.get('rows') != "undefined"
																&& typeof v.model
																		.get('header') != "undefined") {
															var saminp = new m.Views.sampleinputfile(
																	{
																		model : new Backbone.Model(
																				{
																					rows : v.model.attributes.rows,
																					header : v.model.attributes.header,
																				}),
																	});
															that.dependencySampleInputContainer
																	.html("<h4>Sample Input File:</h4>");
															that.dependencySampleInputContainer
																	.append(saminp
																			.render().$el);
														} else {
															// if we don't have
															// a dependency
															// file, just clear
															// the container
															that.dependencySampleInputContainer
																	.empty();
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

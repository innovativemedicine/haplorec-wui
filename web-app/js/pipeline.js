var pipeline = (function (m, Backbone, _, dust, jsPlumb) {
	'use strict';

    // models

    m.Dependency = Backbone.Model.extend({
        toString: function () {
            return this.get('target');
        }
    });

    m.Dependencies = Backbone.Collection.extend({
        model: m.Dependency,
        url: 'dependencies',
    });

    m.DependencyGraph = Backbone.Model.extend({
        url: 'dependencyGraph',

        _levelToTargets: null,
        _dependsOn: null,
        _init: function() {

            this.set('dependencies', new m.Dependencies(this.get('dependencies')));

            var dmap = {};
            this.get('dependencies').forEach(function (d) {
                dmap[d] = d;
            });
            var dependsOn = {};
            this.get('dependencies').forEach(function (d) {
                dependsOn[d] = _.map(d.get('dependsOn'), function (dName) { return dmap[dName]; });
            });
            this._dmap = dmap;
            this._dependsOn = dependsOn;


            var dependants = {};
            this.get('dependencies').forEach(function (d) {
                dependants[d] = [];
            });
            this.get('dependencies').forEach(function (t) {
                _.each(g.dependsOn(t), function (d) {
                    dependants[d].push(t);
                });
            });
            this._dependants = dependants;

            var levelToTargets = {};
            _.chain(this.get('level')).values()
                                      .uniq()
                                      .each(function (l) {
                                          levelToTargets[l] = [];
                                      });
            _.chain(this.get('level')).pairs().each(function (p) {
                var dependency = p[0]; 
                var l = p[1]; 
                levelToTargets[l].push(dependency);
            });
            // this.set('_levelToTargets', levelToTargets);
            this._levelToTargets = levelToTargets;

            var numLevels = _.chain(this.get('level')).values()
                                                      .max()
                                                      .value() + 1;
            this.set('numLevels', numLevels);

        },

        initialize: function(attrs, options) { 
            this.listenTo(this, 'change:level', this._init);
        },

        dependsOn: function(t) {
            return this._dependsOn[t];
        },

        dependants: function(t) {
            return this._dependants[t];
        },

        // iterate over the dependencies in reverse breadth-first-search fashion
        reverseBFS: function(f) {
            for (var l = this.get('numLevels') - 1; l >= 0; l--) {
                var targets = this._levelToTargets[l];
                for (var j = 0; j < targets.length; j += 1) {
                    f(l, this._dmap[ targets[j] ]);
                }
            }
        },

        // iterate over the dependencies in reverse breadth-first-search fashion
        BFS: function(f) {
            for (var l = 0; l < this.get('numLevels'); l++) {
                var targets = this._levelToTargets[l];
                for (var j = 0; j < targets.length; j += 1) {
                    f(l, this._dmap[ targets[j] ]);
                }
            }
        },
    });

    // views
   	// The DOM element for a todo item...
 
    // a view backed by a dustjs template; it's render function uses dustjs 
    // to render this.template
	m.DustView = Backbone.View.extend({
        render: function () {
            var that = this;
            dust.render(this.template, this.model.attributes, function (err, output) {
                if (err) {
                    throw err;
                }
                that.$el.html(output);
            });
            return this;
        }
	}); 

    m.DependencyView = m.DustView.extend({
        template: "pipeline/dependency",
        className: "dependency",
        tagName: "span",
    });

	m.DependencyGraphView = Backbone.View.extend({
        // template: "pipeline/dependencyGraph",
        el: '#dependency-graph',
        className: 'dependency-graph-inner',
        leftMargin: 10,
        topMargin: 10,

		// The DOM events specific to an item.
		// events: {
		// 	'click .toggle': 'toggleCompleted',
		// 	'dblclick label': 'edit',
		// 	'click .destroy': 'clear',
		// 	'keypress .edit': 'updateOnEnter',
		// 	'blur .edit': 'close'
		// },

		// The TodoView listens for changes to its model, re-rendering. Since there's
		// a one-to-one correspondence between a **Todo** and a **TodoView** in this
		// app, we set a direct reference on the model for convenience.
		initialize: function () {
            // this.$el.addClass(this.className);
            var outer = this.$el;
            var inner = $(document.createElement('div')).addClass(this.className);
            outer.addClass('dependency-graph-outer');
            outer.append(inner);
            this.$el = inner;
            // this.$el = $(this.el)
			this.listenTo(this.model, 'change', this._init);
			// this.listenTo(this.model, 'change', this.render);
			this.listenTo(this.model, 'destroy', this.remove);
			// this.listenTo(this.model, 'visible', this.toggleVisible);
		},

        _init: function() {
            this.model.get('dependencies').on('change', this.render, this);

            // setup the dependency graph using jsPlumb
            this.dViews = {};
            var that = this;
            this.model.get('dependencies').each(function (d) {
                var view = new pipeline.DependencyView({model: d});
                view.$el.attr('id', d.get('target'));
                that.dViews[d] = view;
            }); 
            console.log(this.dViews);
            _.chain(this.dViews).values().each(function (v) {
                that.$el.append(v.$el);
            });
            this._arrange();
            this._addConnections();
            this.render();
        },

            // var dimension = function (dim) {
            //     var m = dim.match(/(^\d+)(.*)/);
            //     var magnitude = m[1];
            //     var units = m[2];
            //     return [magnitude, units];
            // }

        _arrange: function() {
            // I think these are always integers representing pixels
            var W = this.$el.width();
            var H = this.$el.height();
            var n = this.model.get('numLevels');
            // max targets per level
            var m = _.chain(this.model._levelToTargets).values()
                                                       .map(function (A) { return A.length })
                                                       .max()
                                                       .value();
            var row = 0;
            var lastLevel = this.model.get('numLevels') - 1;
            var that = this;
            this.model.reverseBFS(function (l, d) {
                if (l != lastLevel) {
                    row = 0;
                }
                var column = (n - 1) - l;
                var view = that.dViews[d];
                // make sure w and h get calculated (from fitting contents)
                view.render();
                var w = view.$el.width();
                var h = view.$el.height();
                view.$el.css('top', ( row + 1 ) * H/(m + 1) - h/2);
                view.$el.css('left', ( column + 1 ) * W/(n + 1) - w/2);
                lastLevel = l;
                row += 1;
            });
        },

        render: function() {
            _.chain(this.dViews).values().each(function (v) {
                console.log(v);
                v.render();
                // this.$el.append(v.render());
            });
        }, 
        //TODO:
        _addConnections: function(d) {
            var g = this.model;

            var srcUUID = function(d, t) {
                // return t.get('target') + 'Src';
                return d.get('target') + '_' + t.get('target') + '_' + 'src';
            };
            var dstUUID = function(d, t) {
                return d.get('target') + '_' + t.get('target') + '_' + 'dst';
            };

            /* Add endpoints.
             */
            // the definition of target endpoints (will appear when the user drags a connection) 
            var connectorPaintStyle = {
				lineWidth:3,
				strokeStyle:"#225588",
				joinstyle:"round",
				outlineColor:"#EAEDEF",
				outlineWidth:3
			};
			var connectorHoverStyle = {
				lineWidth:4,
				strokeStyle:"#2e2aF8"
			};
			var endpointStyle = {
				endpoint:"Dot",
                maxConnections: -1,
				paintStyle:{ fillStyle:"#225588",radius:4 },
				// connector:[ "Flowchart", { stub:[40, 60], gap:10 } ],								                
				// connector:[ "Flowchart", { midpoint: 0.2 } ],								                
				connector:[ "Bezier", { curviness: 0.1 } ],								                
				// connector:[ "StateMachine", {} ],								                
				connectorStyle:connectorPaintStyle,
				hoverPaintStyle:connectorHoverStyle,
				connectorHoverStyle:connectorHoverStyle,
                dragOptions:{},
                overlays:[
                	[ "Label", { 
	                	// location:[0.5, -0.5], 
	                	location:[0.1, -0.1], 
	                	cssClass:"endpointSourceLabel" 
                    } ],
                    [ "Arrow", {
                        location:0.5
                    } ],
                ]
			};
            g.reverseBFS(function (l, t) {
                var addEndpoint = function (uuid, anchor, style) {
                    jsPlumb.addEndpoint(t.get('target'), style, { anchor:anchor, uuid:uuid(t) })
                };
                if (l != g.get('numLevels') - 1) {
                    // add leftside (dst) endpoints to t
                    var i = 1;
                    _.each(g.dependsOn(t), function(d) {
                        addEndpoint(function(t) { return dstUUID(d, t) }, [0, i*(1/( g.dependsOn(t).length+1 )), -1, 0], $.extend({}, endpointStyle, {isTarget: true}));
                        i += 1;
                    });
                }
                if (l != 0) {
                    // add rightside (src) endpoints to t
                    var i = 1;
                    _.each(g.dependants(t), function(d) {
                        addEndpoint(function(t) { return srcUUID(t, d) }, [1, i*(1/( g.dependants(t).length+1 )), -1, 0], $.extend({}, endpointStyle, {isSource: true}));
                        i += 1;
                    });
                }
            });

            /* Add connections.
             */
            g.BFS(function (l, t) {
                _.each(g.dependsOn(t), function (d) {
                    jsPlumb.connect({uuids:[srcUUID(d, t), dstUUID(d, t)], editable:true});
                });
            });
        },
	});

    m.assert = function(condition, description) {
        if (!condition) {
            throw Error(description);
        }
    };

    return m;
})(pipeline || {}, Backbone, _, dust, jsPlumb);

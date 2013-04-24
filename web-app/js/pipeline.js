var pipeline = (function (m, Backbone, _) {
	'use strict';

    m.Dependency = Backbone.Model.extend({

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

            var dependsOn = {};
            this.get('dependencies').forEach(function (d) {
                dependsOn[d.target] = d.dependsOn;
            });
            this.set('_dependsOn', dependsOn);

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
            this.set('_levelToTargets', levelToTargets);

        },

        initialize: function(attrs, options) { 
            this.listenTo(this, 'change:level', this._init);
        },
    });

    return m;
})(pipeline || {}, Backbone, _);

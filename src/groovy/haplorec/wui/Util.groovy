package haplorec.wui

import grails.converters.JSON;
import haplorec.util.haplotype.Dependency;

class Util {

	static def toJSON(Dependency d) {
		def props = d.properties.findAll { k, v -> !(['class', 'finished', 'rule', 'metaClass'] as Set).contains(k) }
		props.dependsOn = props.dependsOn.collect { it.target }
		return props as JSON
	}
	
}

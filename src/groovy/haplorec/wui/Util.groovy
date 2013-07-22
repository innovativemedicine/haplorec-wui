package haplorec.wui

import grails.converters.JSON;
import haplorec.util.pipeline.Dependency;
import javax.sql.DataSource
import groovy.sql.Sql

class Util {

	static def makeRenderable(Dependency d) {
		def props = d.properties.findAll { k, v -> !(['class', 'finished', 'rule', 'metaClass'] as Set).contains(k) }
		props.dependsOn = props.dependsOn.collect { it.target }
		return props
	}
	
    def private static withSql(DataSource d, Closure f) {
        Sql sql = new Sql(d)
        try {
            f(sql)
        } finally {
            sql.close()
        }
    }

}

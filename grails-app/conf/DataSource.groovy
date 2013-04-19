dataSource {
    pooled = true
	driverClassName = "com.mysql.jdbc.Driver"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
development_dataSource_url = "jdbc:mysql://localhost:3306/haplorec"
development_dataSource_username = "root"
development_dataSource_password = ""
environments {
    development {
        dataSource {
            dbCreate = '' // one of 'create', 'create-drop', 'update', 'validate', ''
            url = development_dataSource_url
			username = development_dataSource_username
			password = development_dataSource_password 
        }
    }
    test {
        dataSource {
            dbCreate = ''
            url = development_dataSource_url
			username = development_dataSource_username
            password = development_dataSource_password
        }
    }
    production {
        dataSource {
            dbCreate = ''
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
            url = "jdbc:mysql://localhost:3306/haplorec"
            username = "root"
            password = "1000anag3r"
        }
    }
}

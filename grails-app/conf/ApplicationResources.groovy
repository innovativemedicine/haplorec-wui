modules = {

    application {
        resource url:'js/application.js'
    }

    jsPlumb {
        dependsOn 'jquery'
        resource url:'js/extern/jquery.jsPlumb-1.3.16-all.js'
    }

    spinjs {
        dependsOn 'jquery'
        resource url:'js/extern/spin.min.js'
    }

    bootstrapMod {
        dependsOn 'bootstrap'
        resource url:'css/bootstrap-mod.css'
    }

    pipeline {
        dependsOn 'jsPlumb, jquery, backbone, dustjs, spinjs'
        resource url:'/js/pipeline.js'
        resource url:'/css/pipeline.css'
        resource url: '/js/templates/pipeline/dependency.dust', attrs: [rel: "javascript/dust", type: 'js'], bundle: 'bundle_pipeline'
        resource url: '/js/templates/pipeline/dependencyShow.dust', attrs: [rel: "javascript/dust", type: 'js'], bundle: 'bundle_pipeline'
        resource url: '/js/templates/pipeline/dependencyFile.dust', attrs: [rel: "javascript/dust", type: 'js'], bundle: 'bundle_pipeline'
		resource url: '/js/templates/pipeline/sampleinputfile.dust', attrs: [rel: "javascript/dust", type: 'js'], bundle: 'bundle_pipeline'
    }

}

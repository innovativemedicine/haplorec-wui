modules = {

    application {
        resource url:'js/application.js'
    }

    jsPlumb {
        dependsOn 'jquery'
        resource url:'js/extern/jquery.jsPlumb-1.3.16-all.js'
    }

    pipeline {
        dependsOn 'jsPlumb, jquery, backbone, dustjs'
        resource url:'/js/pipeline.js'
        resource url:'/css/pipeline.css'
        resource url: '/js/templates/pipeline/dependency.dust', attrs: [rel: "javascript/dust", type: 'js'], bundle: 'bundle_pipeline'
    }

}

modules = {

    application {
        resource url:'js/application.js'
    }

    jsPlumb {
        dependsOn 'jquery'
        resource url:'js/extern/jquery.jsPlumb-1.3.16-all.js'
    }

    pipeline {
        dependsOn 'jsPlumb, jquery, backbone'
        resource url:'/js/pipeline.js'
    }

}

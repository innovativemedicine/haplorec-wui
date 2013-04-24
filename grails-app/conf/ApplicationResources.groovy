modules = {

    application {
        resource url:'js/application.js'
    }

    jsPlumb {
        dependsOn 'jquery'
        resource url:'js/jquery.jsPlumb-1.3.16-all.js'
    }

}

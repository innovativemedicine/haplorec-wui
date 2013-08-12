Tools
*****

Here are some tools that were used in the project.

Dust
====

Dustjs is a javascript templating engine.
The dust templates can be found under haplorec-wui/web-app/js/templates/pipeline

novelHaplotypeReport.dust template:

.. literalinclude:: ../web-app/js/templates/pipeline/novelHaplotypeReport.dust
    :language: html

Add the template to 

.. toctree::
    ApplicationResources

.. code-block:: groovy

    resource url: '/js/templates/pipeline/novelHaplotypeReport.dust', attrs: [rel: "javascript/dust", type: 'js'], bundle: 'bundle_pipeline' 

Now the template can be used in Views

Backbone
========

Backbone.js is a Javascript framework used to create models and views.

Creating the view in pipeline.js. The matrixList view has novelHaplotype.dust as a template and a _init method that includes the javascript that is used when 
the view is rendered.

.. literalinclude:: ../web-app/js/pipeline.js
    :language: javascript
    :start-after: SPHINX matrixList start
    :end-before: SPHINX matrixList end

Rendering the view in jobPatientNovelHaplotype _list.gsp with matrixJSON as the view's model.

.. literalinclude:: ../grails-app/views/jobPatientNovelHaplotype/_list.gsp
    :language: javascript
    :start-after: SPHINX start
    :end-before: SPHINX end


jsPlumb
=======

Used for connecting the targets in the dependency Graph 
    - http://jsplumbtoolkit.com/doc/home.html
    - http://jsplumbtoolkit.com/jquery/flowchartConnectorsDemo.html

It is used in the _addConnections method in the Dependency Graph view in pipeline.js


Relevant Code
=============

.. toctree::

    pipelineJs



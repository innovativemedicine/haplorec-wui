Front-end of Creating a Target
******************************

Before you start
================

This assumes you have done all the backend changes needed to be done to add a new target to the dependency Graph.

    - Added a table to the database
    - Made changes to Pipeline.groovy for populating the target's new table

Front-end    
=========

To allow the user to interact with the target complete the following:

1. Create a corresponding domain class in grails-app/domain/haplorec/wui/
2. Use the grails command prompt to run "grails generate-all haplorec.wui.<your-domain>" (http://grails.org/doc/latest/ref/Command%20Line/generate-all.html) to generate default controllers and views.
3. Modify the default controller:

    - add @Mixin(JobPatientControllerMixin) above the controller class definition
    - replace the default list action with 2 new actions:

        .. code-block:: groovy

            def list(Integer max, Long jobId) { 
                jobPatientList(YourDomainClass, max, jobId, withModel: this.&addMatrixJSON) 
            }

        .. code-block:: groovy	

            def listTemplate(Integer max, Long jobId) { 
                jobPatientListTemplate(YourDomainClass, max, jobId, withModel: this.&addMatrixJSON) 
            }

4. Modify the default views:

    - move the default yourDomainClass/list.gsp to yourDomainClass/_list.gsp (a template is used so the outer layout main.gsp, which has the navigation bar, does not get rendered)
    - create a new yourDomainClass/list.gsp whose contents are:
        * <g:render template="list"/>
5. Modify _list.gsp (originally list.gsp):
    - add params="[jobId:jobId]" to the end of each g:sortableColumn tag

Sample Code for Variant target
===============================

.. toctree::
    src-link/JobPatientVariant
    src-link/JobPatientVariantController
    src-link/Variant_list
    src-link/Variantlist

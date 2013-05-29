<%@ page import="haplorec.wui.Job" %>

<r:require modules="pipeline, backbone, jquery"/>
<r:script>
var sampleVariant;
var samplegeno;
var samplepheno;
$(document).ready(function(){

	var sampleVariant = new pipeline.Views.sampleinputfile({
	    model: new Backbone.Model(${sampleVariantJSON}),
	    el: $('#sample-variant'), 
	});
	sampleVariant.render();
	var samplegeno = new pipeline.Views.sampleinputfile({
	    model: new Backbone.Model(${samplegenoJSON}),
	    el: $('#sample-outgeno'), 
	});
	samplegeno.render();
	var samplepheno = new pipeline.Views.sampleinputfile({
	    model: new Backbone.Model(${samplephenoJSON}),
	    el: $('#sample-outpheno'), 
	});
	samplepheno.render();
	
});


</r:script>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style>
        </style>
	</head>
	<body>

	<p>Haplorec is a patient variant to drug recommendation pipeline. Here is how to get started:</p>
    
    <div class="main">
    <h2>1. Create a new Job</h2>
    Upload a patient variant file:<div id="sample-variant"></div>
    </div>

    <div class="main">
    <h2>2. Download a report</h2>
    Genotype drug recommendations:<div id ="sample-outgeno"></div>
    </div>

    <div class="main">
    Phenotype drug recommendations:<div id="sample-outpheno"></div>
    </div>

    </body>
</html>

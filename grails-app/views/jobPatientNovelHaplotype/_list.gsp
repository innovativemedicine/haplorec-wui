
<%@ page import="haplorec.wui.JobPatientNovelHaplotype" %>

<r:require modules="pipeline, backbone, jquery, jsonstream"/>
<r:script>
var ghmView;
$(document).ready(function(){
	var matrixList = ${matrixJSON}
	ghmView = new pipeline.Views.matrix({
	             model: new Backbone.Model(matrixList[0]),
	             el: $('#test-matrix'), 
	         });
	ghmView.render();
	var geneNameList = matrixList.map(function(geneMatrix){return "<option class='gene'>"+geneMatrix.geneName+"</option>";})
	var geneNameString = geneNameList.join("");
	
	$(".geneSelector").html(geneNameString);
	
	$(".geneSelector").change(function(){
		var n = geneNameList.indexOf("<option class='gene'>"+$('.geneSelector').val()+"</option>");
	    ghmView = new pipeline.Views.matrix({
	             model: new Backbone.Model(matrixList[n]),
	             el: $('#test-matrix'), 
	         });
	     ghmView.render();
     });
});
</r:script>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:layoutResources/>
	</head>

	<body>
        <%--
		<a href="#list-jobPatientNovelHaplotype" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
        --%>

		<div id="list-jobPatientNovelHaplotype" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <g:if test="${jobId != null}">
            <g:link class="drug-report btn btn-primary" controller="pipelineJob" action="novelHaplotypeReport" id="${jobId}">${entityName} Report</g:link>
            </g:if>

		</div>
		<select class="geneSelector">
		</select>
		<div id="test-matrix"></div>
        <r:layoutResources/>
	</body>
</html>

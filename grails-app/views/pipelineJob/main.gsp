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
	</head>
	<body>
	<br></br>
	<p>Haplorec is a patient variant to drug recommendation pipeline. Here is how to get started:</p>
	<br></br>
	<h2>1. Create a new Job</h2>
	<Blockquote><p>Upload a patient variant file:</p><div id="sample-variant"></div></Blockquote>
    <br></br>        
	<h2>2. Download a report</h2>
	<Blockquote><p>Genotype drug recommendations:</p><div id ="sample-outgeno"></div></Blockquote>
	<br></br>
	<Blockquote><p>Phenotype drup recommendations:</p><div id="sample-outpheno"></div></Blockquote>
	<br></br>
            <%--
			<ol class="property-list job">
			
				<li class="fieldcontain">
					<span id="jobName-label" class="property-label"><g:message code="job.jobName.label" default="Job Name" /></span>
					
						
					
				</li>
			

				<g:if test="${jobInstance?.jobPatientChromosomeVariants}">
				<li class="fieldcontain">
					<span id="jobPatientChromosomeVariants-label" class="property-label"><g:message code="job.jobPatientChromosomeVariants.label" default="Job Patient Chromosome Variants" /></span>
					
						<g:each in="${jobInstance.jobPatientChromosomeVariants}" var="j">
						<span class="property-value" aria-labelledby="jobPatientChromosomeVariants-label"><g:link controller="jobPatientChromosomeVariant" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientDrugRecommendations}">
				<li class="fieldcontain">
					<span id="jobPatientDrugRecommendations-label" class="property-label"><g:message code="job.jobPatientDrugRecommendations.label" default="Job Patient Drug Recommendations" /></span>
					
						<g:each in="${jobInstance.jobPatientDrugRecommendations}" var="j">
						<span class="property-value" aria-labelledby="jobPatientDrugRecommendations-label"><g:link controller="jobPatientDrugRecommendation" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientGeneHaplotypes}">
				<li class="fieldcontain">
					<span id="jobPatientGeneHaplotypes-label" class="property-label"><g:message code="job.jobPatientGeneHaplotypes.label" default="Job Patient Gene Haplotypes" /></span>
					
						<g:each in="${jobInstance.jobPatientGeneHaplotypes}" var="j">
						<span class="property-value" aria-labelledby="jobPatientGeneHaplotypes-label"><g:link controller="jobPatientGeneHaplotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientGenePhenotypes}">
				<li class="fieldcontain">
					<span id="jobPatientGenePhenotypes-label" class="property-label"><g:message code="job.jobPatientGenePhenotypes.label" default="Job Patient Gene Phenotypes" /></span>
					
						<g:each in="${jobInstance.jobPatientGenePhenotypes}" var="j">
						<span class="property-value" aria-labelledby="jobPatientGenePhenotypes-label"><g:link controller="jobPatientGenePhenotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientGenotypes}">
				<li class="fieldcontain">
					<span id="jobPatientGenotypes-label" class="property-label"><g:message code="job.jobPatientGenotypes.label" default="Job Patient Genotypes" /></span>
					
						<g:each in="${jobInstance.jobPatientGenotypes}" var="j">
						<span class="property-value" aria-labelledby="jobPatientGenotypes-label"><g:link controller="jobPatientGenotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientVariants}">
				<li class="fieldcontain">
					<span id="jobPatientVariants-label" class="property-label"><g:message code="job.jobPatientVariants.label" default="Job Patient Variants" /></span>
					
						<g:each in="${jobInstance.jobPatientVariants}" var="j">
						<span class="property-value" aria-labelledby="jobPatientVariants-label"><g:link controller="jobPatientVariant" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
            --%>
		</div>
	</body>
</html>

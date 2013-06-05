<%@ page import="haplorec.wui.Job" %>

<r:require modules="pipeline, backbone, jquery"/>
<r:script>
var g, gView;
$(document).ready(function(){
    g = new pipeline.DependencyGraph(${dependencyGraphJSON});
    gView = new pipeline.Views.DependencyGraphShow({
        model: g, 
        height: $(window).height()/3,
        spinnerContainer: $('.spinner-container'),
    });
    gView.fetchAsync = function(index) {
        return ! $(this).hasClass('drug-report');
    };
    gView.render();
    Backbone.history.start();
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
		<div id="show-job" class="content scaffold-show" role="main">
			<h1>
				<g:if test="${jobInstance?.jobName}">
                <span class="property-value" aria-labelledby="jobName-label"><g:fieldValue bean="${jobInstance}" field="jobName"/></span>
                </g:if>
                <g:else>
                <g:message code="default.show.label" args="[entityName]" />
                </g:else>
            </h1>

			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobInstance?.id}" />
					<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'custom.button.delete.label', default: 'Delete', args: [entityName])}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <div id="dependency-graph"></div>

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

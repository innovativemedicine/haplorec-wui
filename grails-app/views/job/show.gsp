
<%@ page import="haplorec.wui.Job" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-job" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-job" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list job">
			
				<g:if test="${jobInstance?.jobName}">
				<li class="fieldcontain">
					<span id="jobName-label" class="property-label"><g:message code="job.jobName.label" default="Job Name" /></span>
					
						<span class="property-value" aria-labelledby="jobName-label"><g:fieldValue bean="${jobInstance}" field="jobName"/></span>
					
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
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobInstance?.id}" />
					<g:link class="edit" action="edit" id="${jobInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

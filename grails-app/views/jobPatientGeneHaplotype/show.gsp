
<%@ page import="haplorec.wui.JobPatientGeneHaplotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-jobPatientGeneHaplotype" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-jobPatientGeneHaplotype" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jobPatientGeneHaplotype">
			
				<g:if test="${jobPatientGeneHaplotypeInstance?.patientId}">
				<li class="fieldcontain">
					<span id="patientId-label" class="property-label"><g:message code="jobPatientGeneHaplotype.patientId.label" default="Patient Id" /></span>
					
						<span class="property-value" aria-labelledby="patientId-label"><g:fieldValue bean="${jobPatientGeneHaplotypeInstance}" field="patientId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientGeneHaplotypeInstance?.geneName}">
				<li class="fieldcontain">
					<span id="geneName-label" class="property-label"><g:message code="jobPatientGeneHaplotype.geneName.label" default="Gene Name" /></span>
					
						<span class="property-value" aria-labelledby="geneName-label"><g:fieldValue bean="${jobPatientGeneHaplotypeInstance}" field="geneName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientGeneHaplotypeInstance?.haplotypeName}">
				<li class="fieldcontain">
					<span id="haplotypeName-label" class="property-label"><g:message code="jobPatientGeneHaplotype.haplotypeName.label" default="Haplotype Name" /></span>
					
						<span class="property-value" aria-labelledby="haplotypeName-label"><g:fieldValue bean="${jobPatientGeneHaplotypeInstance}" field="haplotypeName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientGeneHaplotypeInstance?.job}">
				<li class="fieldcontain">
					<span id="job-label" class="property-label"><g:message code="jobPatientGeneHaplotype.job.label" default="Job" /></span>
					
						<span class="property-value" aria-labelledby="job-label"><g:link controller="job" action="show" id="${jobPatientGeneHaplotypeInstance?.job?.id}">${jobPatientGeneHaplotypeInstance?.job?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobPatientGeneHaplotypeInstance?.id}" />
					<g:link class="edit" action="edit" id="${jobPatientGeneHaplotypeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

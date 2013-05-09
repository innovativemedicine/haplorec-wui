
<%@ page import="haplorec.wui.JobPatientPhenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-jobPatientPhenotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-jobPatientPhenotypeDrugRecommendation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jobPatientPhenotypeDrugRecommendation">
			
				<g:if test="${jobPatientPhenotypeDrugRecommendationInstance?.patientId}">
				<li class="fieldcontain">
					<span id="patientId-label" class="property-label"><g:message code="jobPatientPhenotypeDrugRecommendation.patientId.label" default="Patient Id" /></span>
					
						<span class="property-value" aria-labelledby="patientId-label"><g:fieldValue bean="${jobPatientPhenotypeDrugRecommendationInstance}" field="patientId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation}">
				<li class="fieldcontain">
					<span id="drugRecommendation-label" class="property-label"><g:message code="jobPatientPhenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></span>
					
						<span class="property-value" aria-labelledby="drugRecommendation-label"><g:link controller="drugRecommendation" action="show" id="${jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation?.id}">${jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientPhenotypeDrugRecommendationInstance?.job}">
				<li class="fieldcontain">
					<span id="job-label" class="property-label"><g:message code="jobPatientPhenotypeDrugRecommendation.job.label" default="Job" /></span>
					
						<span class="property-value" aria-labelledby="job-label"><g:link controller="job" action="show" id="${jobPatientPhenotypeDrugRecommendationInstance?.job?.id}">${jobPatientPhenotypeDrugRecommendationInstance?.job?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobPatientPhenotypeDrugRecommendationInstance?.id}" />
					<g:link class="edit" action="edit" id="${jobPatientPhenotypeDrugRecommendationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

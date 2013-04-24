
<%@ page import="haplorec.wui.JobPatientVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientVariant.label', default: 'JobPatientVariant')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-jobPatientVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-jobPatientVariant" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jobPatientVariant">
			
				<g:if test="${jobPatientVariantInstance?.patientId}">
				<li class="fieldcontain">
					<span id="patientId-label" class="property-label"><g:message code="jobPatientVariant.patientId.label" default="Patient Id" /></span>
					
						<span class="property-value" aria-labelledby="patientId-label"><g:fieldValue bean="${jobPatientVariantInstance}" field="patientId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientVariantInstance?.physicalChromosome}">
				<li class="fieldcontain">
					<span id="physicalChromosome-label" class="property-label"><g:message code="jobPatientVariant.physicalChromosome.label" default="Physical Chromosome" /></span>
					
						<span class="property-value" aria-labelledby="physicalChromosome-label"><g:fieldValue bean="${jobPatientVariantInstance}" field="physicalChromosome"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientVariantInstance?.snpId}">
				<li class="fieldcontain">
					<span id="snpId-label" class="property-label"><g:message code="jobPatientVariant.snpId.label" default="Snp Id" /></span>
					
						<span class="property-value" aria-labelledby="snpId-label"><g:fieldValue bean="${jobPatientVariantInstance}" field="snpId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientVariantInstance?.allele}">
				<li class="fieldcontain">
					<span id="allele-label" class="property-label"><g:message code="jobPatientVariant.allele.label" default="Allele" /></span>
					
						<span class="property-value" aria-labelledby="allele-label"><g:fieldValue bean="${jobPatientVariantInstance}" field="allele"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientVariantInstance?.zygosity}">
				<li class="fieldcontain">
					<span id="zygosity-label" class="property-label"><g:message code="jobPatientVariant.zygosity.label" default="Zygosity" /></span>
					
						<span class="property-value" aria-labelledby="zygosity-label"><g:fieldValue bean="${jobPatientVariantInstance}" field="zygosity"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientVariantInstance?.job}">
				<li class="fieldcontain">
					<span id="job-label" class="property-label"><g:message code="jobPatientVariant.job.label" default="Job" /></span>
					
						<span class="property-value" aria-labelledby="job-label"><g:link controller="job" action="show" id="${jobPatientVariantInstance?.job?.id}">${jobPatientVariantInstance?.job?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobPatientVariantInstance?.id}" />
					<g:link class="edit" action="edit" id="${jobPatientVariantInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

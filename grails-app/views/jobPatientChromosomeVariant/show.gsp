
<%@ page import="haplorec.wui.JobPatientChromosomeVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-jobPatientChromosomeVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-jobPatientChromosomeVariant" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jobPatientChromosomeVariant">
			
				<g:if test="${jobPatientChromosomeVariantInstance?.patientId}">
				<li class="fieldcontain">
					<span id="patientId-label" class="property-label"><g:message code="jobPatientChromosomeVariant.patientId.label" default="Patient Id" /></span>
					
						<span class="property-value" aria-labelledby="patientId-label"><g:fieldValue bean="${jobPatientChromosomeVariantInstance}" field="patientId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientChromosomeVariantInstance?.physicalChromosome}">
				<li class="fieldcontain">
					<span id="physicalChromosome-label" class="property-label"><g:message code="jobPatientChromosomeVariant.physicalChromosome.label" default="Physical Chromosome" /></span>
					
						<span class="property-value" aria-labelledby="physicalChromosome-label"><g:fieldValue bean="${jobPatientChromosomeVariantInstance}" field="physicalChromosome"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientChromosomeVariantInstance?.snpId}">
				<li class="fieldcontain">
					<span id="snpId-label" class="property-label"><g:message code="jobPatientChromosomeVariant.snpId.label" default="Snp Id" /></span>
					
						<span class="property-value" aria-labelledby="snpId-label"><g:fieldValue bean="${jobPatientChromosomeVariantInstance}" field="snpId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientChromosomeVariantInstance?.allele}">
				<li class="fieldcontain">
					<span id="allele-label" class="property-label"><g:message code="jobPatientChromosomeVariant.allele.label" default="Allele" /></span>
					
						<span class="property-value" aria-labelledby="allele-label"><g:fieldValue bean="${jobPatientChromosomeVariantInstance}" field="allele"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientChromosomeVariantInstance?.job}">
				<li class="fieldcontain">
					<span id="job-label" class="property-label"><g:message code="jobPatientChromosomeVariant.job.label" default="Job" /></span>
					
						<span class="property-value" aria-labelledby="job-label"><g:link controller="job" action="show" id="${jobPatientChromosomeVariantInstance?.job?.id}">${jobPatientChromosomeVariantInstance?.job?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobPatientChromosomeVariantInstance?.id}" />
					<g:link class="edit" action="edit" id="${jobPatientChromosomeVariantInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

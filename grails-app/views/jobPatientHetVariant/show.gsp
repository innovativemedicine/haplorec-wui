
<%@ page import="haplorec.wui.JobPatientHetVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-jobPatientHetVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-jobPatientHetVariant" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jobPatientHetVariant">
			
				<g:if test="${jobPatientHetVariantInstance?.patientId}">
				<li class="fieldcontain">
					<span id="patientId-label" class="property-label"><g:message code="jobPatientHetVariant.patientId.label" default="Patient Id" /></span>
					
						<span class="property-value" aria-labelledby="patientId-label"><g:fieldValue bean="${jobPatientHetVariantInstance}" field="patientId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientHetVariantInstance?.physicalChromosome}">
				<li class="fieldcontain">
					<span id="physicalChromosome-label" class="property-label"><g:message code="jobPatientHetVariant.physicalChromosome.label" default="Physical Chromosome" /></span>
					
						<span class="property-value" aria-labelledby="physicalChromosome-label"><g:fieldValue bean="${jobPatientHetVariantInstance}" field="physicalChromosome"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientHetVariantInstance?.hetCombo}">
				<li class="fieldcontain">
					<span id="hetCombo-label" class="property-label"><g:message code="jobPatientHetVariant.hetCombo.label" default="Het Combo" /></span>
					
						<span class="property-value" aria-labelledby="hetCombo-label"><g:fieldValue bean="${jobPatientHetVariantInstance}" field="hetCombo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientHetVariantInstance?.hetCombos}">
				<li class="fieldcontain">
					<span id="hetCombos-label" class="property-label"><g:message code="jobPatientHetVariant.hetCombos.label" default="Het Combos" /></span>
					
						<span class="property-value" aria-labelledby="hetCombos-label"><g:fieldValue bean="${jobPatientHetVariantInstance}" field="hetCombos"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientHetVariantInstance?.snpId}">
				<li class="fieldcontain">
					<span id="snpId-label" class="property-label"><g:message code="jobPatientHetVariant.snpId.label" default="Snp Id" /></span>
					
						<span class="property-value" aria-labelledby="snpId-label"><g:fieldValue bean="${jobPatientHetVariantInstance}" field="snpId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientHetVariantInstance?.allele}">
				<li class="fieldcontain">
					<span id="allele-label" class="property-label"><g:message code="jobPatientHetVariant.allele.label" default="Allele" /></span>
					
						<span class="property-value" aria-labelledby="allele-label"><g:fieldValue bean="${jobPatientHetVariantInstance}" field="allele"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jobPatientHetVariantInstance?.job}">
				<li class="fieldcontain">
					<span id="job-label" class="property-label"><g:message code="jobPatientHetVariant.job.label" default="Job" /></span>
					
						<span class="property-value" aria-labelledby="job-label"><g:link controller="job" action="show" id="${jobPatientHetVariantInstance?.job?.id}">${jobPatientHetVariantInstance?.job?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${jobPatientHetVariantInstance?.id}" />
					<g:link class="edit" action="edit" id="${jobPatientHetVariantInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

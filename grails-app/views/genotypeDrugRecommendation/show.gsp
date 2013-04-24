
<%@ page import="haplorec.wui.GenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-genotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-genotypeDrugRecommendation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list genotypeDrugRecommendation">
			
				<g:if test="${genotypeDrugRecommendationInstance?.geneName}">
				<li class="fieldcontain">
					<span id="geneName-label" class="property-label"><g:message code="genotypeDrugRecommendation.geneName.label" default="Gene Name" /></span>
					
						<span class="property-value" aria-labelledby="geneName-label"><g:fieldValue bean="${genotypeDrugRecommendationInstance}" field="geneName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${genotypeDrugRecommendationInstance?.haplotypeName1}">
				<li class="fieldcontain">
					<span id="haplotypeName1-label" class="property-label"><g:message code="genotypeDrugRecommendation.haplotypeName1.label" default="Haplotype Name1" /></span>
					
						<span class="property-value" aria-labelledby="haplotypeName1-label"><g:fieldValue bean="${genotypeDrugRecommendationInstance}" field="haplotypeName1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${genotypeDrugRecommendationInstance?.haplotypeName2}">
				<li class="fieldcontain">
					<span id="haplotypeName2-label" class="property-label"><g:message code="genotypeDrugRecommendation.haplotypeName2.label" default="Haplotype Name2" /></span>
					
						<span class="property-value" aria-labelledby="haplotypeName2-label"><g:fieldValue bean="${genotypeDrugRecommendationInstance}" field="haplotypeName2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${genotypeDrugRecommendationInstance?.drugRecommendation}">
				<li class="fieldcontain">
					<span id="drugRecommendation-label" class="property-label"><g:message code="genotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></span>
					
						<span class="property-value" aria-labelledby="drugRecommendation-label"><g:link controller="drugRecommendation" action="show" id="${genotypeDrugRecommendationInstance?.drugRecommendation?.id}">${genotypeDrugRecommendationInstance?.drugRecommendation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${genotypeDrugRecommendationInstance?.id}" />
					<g:link class="edit" action="edit" id="${genotypeDrugRecommendationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

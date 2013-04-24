
<%@ page import="haplorec.wui.GenePhenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-genePhenotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-genePhenotypeDrugRecommendation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list genePhenotypeDrugRecommendation">
			
				<g:if test="${genePhenotypeDrugRecommendationInstance?.geneName}">
				<li class="fieldcontain">
					<span id="geneName-label" class="property-label"><g:message code="genePhenotypeDrugRecommendation.geneName.label" default="Gene Name" /></span>
					
						<span class="property-value" aria-labelledby="geneName-label"><g:fieldValue bean="${genePhenotypeDrugRecommendationInstance}" field="geneName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${genePhenotypeDrugRecommendationInstance?.phenotypeName}">
				<li class="fieldcontain">
					<span id="phenotypeName-label" class="property-label"><g:message code="genePhenotypeDrugRecommendation.phenotypeName.label" default="Phenotype Name" /></span>
					
						<span class="property-value" aria-labelledby="phenotypeName-label"><g:fieldValue bean="${genePhenotypeDrugRecommendationInstance}" field="phenotypeName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${genePhenotypeDrugRecommendationInstance?.drugRecommendation}">
				<li class="fieldcontain">
					<span id="drugRecommendation-label" class="property-label"><g:message code="genePhenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></span>
					
						<span class="property-value" aria-labelledby="drugRecommendation-label"><g:link controller="drugRecommendation" action="show" id="${genePhenotypeDrugRecommendationInstance?.drugRecommendation?.id}">${genePhenotypeDrugRecommendationInstance?.drugRecommendation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${genePhenotypeDrugRecommendationInstance?.id}" />
					<g:link class="edit" action="edit" id="${genePhenotypeDrugRecommendationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

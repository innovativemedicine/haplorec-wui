
<%@ page import="haplorec.wui.DrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'drugRecommendation.label', default: 'DrugRecommendation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-drugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-drugRecommendation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list drugRecommendation">
			
				<g:if test="${drugRecommendationInstance?.drugName}">
				<li class="fieldcontain">
					<span id="drugName-label" class="property-label"><g:message code="drugRecommendation.drugName.label" default="Drug Name" /></span>
					
						<span class="property-value" aria-labelledby="drugName-label"><g:fieldValue bean="${drugRecommendationInstance}" field="drugName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugRecommendationInstance?.implications}">
				<li class="fieldcontain">
					<span id="implications-label" class="property-label"><g:message code="drugRecommendation.implications.label" default="Implications" /></span>
					
						<span class="property-value" aria-labelledby="implications-label"><g:fieldValue bean="${drugRecommendationInstance}" field="implications"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugRecommendationInstance?.recommendation}">
				<li class="fieldcontain">
					<span id="recommendation-label" class="property-label"><g:message code="drugRecommendation.recommendation.label" default="Recommendation" /></span>
					
						<span class="property-value" aria-labelledby="recommendation-label"><g:fieldValue bean="${drugRecommendationInstance}" field="recommendation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugRecommendationInstance?.classification}">
				<li class="fieldcontain">
					<span id="classification-label" class="property-label"><g:message code="drugRecommendation.classification.label" default="Classification" /></span>
					
						<span class="property-value" aria-labelledby="classification-label"><g:fieldValue bean="${drugRecommendationInstance}" field="classification"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugRecommendationInstance?.diplotypeEgs}">
				<li class="fieldcontain">
					<span id="diplotypeEgs-label" class="property-label"><g:message code="drugRecommendation.diplotypeEgs.label" default="Diplotype Egs" /></span>
					
						<span class="property-value" aria-labelledby="diplotypeEgs-label"><g:fieldValue bean="${drugRecommendationInstance}" field="diplotypeEgs"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${drugRecommendationInstance?.genePhenotypeDrugRecommendations}">
				<li class="fieldcontain">
					<span id="genePhenotypeDrugRecommendations-label" class="property-label"><g:message code="drugRecommendation.genePhenotypeDrugRecommendations.label" default="Gene Phenotype Drug Recommendations" /></span>
					
						<g:each in="${drugRecommendationInstance.genePhenotypeDrugRecommendations}" var="g">
						<span class="property-value" aria-labelledby="genePhenotypeDrugRecommendations-label"><g:link controller="genePhenotypeDrugRecommendation" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${drugRecommendationInstance?.genotypeDrugRecommendations}">
				<li class="fieldcontain">
					<span id="genotypeDrugRecommendations-label" class="property-label"><g:message code="drugRecommendation.genotypeDrugRecommendations.label" default="Genotype Drug Recommendations" /></span>
					
						<g:each in="${drugRecommendationInstance.genotypeDrugRecommendations}" var="g">
						<span class="property-value" aria-labelledby="genotypeDrugRecommendations-label"><g:link controller="genotypeDrugRecommendation" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${drugRecommendationInstance?.id}" />
					<g:link class="edit" action="edit" id="${drugRecommendationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

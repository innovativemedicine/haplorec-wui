
<%@ page import="haplorec.wui.GenePhenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-genePhenotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-genePhenotypeDrugRecommendation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="geneName" title="${message(code: 'genePhenotypeDrugRecommendation.geneName.label', default: 'Gene Name')}" />
					
						<g:sortableColumn property="phenotypeName" title="${message(code: 'genePhenotypeDrugRecommendation.phenotypeName.label', default: 'Phenotype Name')}" />
					
						<th><g:message code="genePhenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${genePhenotypeDrugRecommendationInstanceList}" status="i" var="genePhenotypeDrugRecommendationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${genePhenotypeDrugRecommendationInstance.id}">${fieldValue(bean: genePhenotypeDrugRecommendationInstance, field: "geneName")}</g:link></td>
					
						<td>${fieldValue(bean: genePhenotypeDrugRecommendationInstance, field: "phenotypeName")}</td>
					
						<td>${fieldValue(bean: genePhenotypeDrugRecommendationInstance, field: "drugRecommendation")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${genePhenotypeDrugRecommendationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

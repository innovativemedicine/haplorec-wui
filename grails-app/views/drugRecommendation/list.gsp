
<%@ page import="haplorec.wui.DrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'drugRecommendation.label', default: 'DrugRecommendation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-drugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-drugRecommendation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="drugName" title="${message(code: 'drugRecommendation.drugName.label', default: 'Drug Name')}" />
					
						<g:sortableColumn property="implications" title="${message(code: 'drugRecommendation.implications.label', default: 'Implications')}" />
					
						<g:sortableColumn property="recommendation" title="${message(code: 'drugRecommendation.recommendation.label', default: 'Recommendation')}" />
					
						<g:sortableColumn property="classification" title="${message(code: 'drugRecommendation.classification.label', default: 'Classification')}" />
					
						<g:sortableColumn property="diplotypeEgs" title="${message(code: 'drugRecommendation.diplotypeEgs.label', default: 'Diplotype Egs')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${drugRecommendationInstanceList}" status="i" var="drugRecommendationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${drugRecommendationInstance.id}">${fieldValue(bean: drugRecommendationInstance, field: "drugName")}</g:link></td>
					
						<td>${fieldValue(bean: drugRecommendationInstance, field: "implications")}</td>
					
						<td>${fieldValue(bean: drugRecommendationInstance, field: "recommendation")}</td>
					
						<td>${fieldValue(bean: drugRecommendationInstance, field: "classification")}</td>
					
						<td>${fieldValue(bean: drugRecommendationInstance, field: "diplotypeEgs")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${drugRecommendationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

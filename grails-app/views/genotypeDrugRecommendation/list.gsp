
<%@ page import="haplorec.wui.GenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-genotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-genotypeDrugRecommendation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="geneName" title="${message(code: 'genotypeDrugRecommendation.geneName.label', default: 'Gene Name')}" />
					
						<g:sortableColumn property="haplotypeName1" title="${message(code: 'genotypeDrugRecommendation.haplotypeName1.label', default: 'Haplotype Name1')}" />
					
						<g:sortableColumn property="haplotypeName2" title="${message(code: 'genotypeDrugRecommendation.haplotypeName2.label', default: 'Haplotype Name2')}" />
					
						<th><g:message code="genotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${genotypeDrugRecommendationInstanceList}" status="i" var="genotypeDrugRecommendationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${genotypeDrugRecommendationInstance.id}">${fieldValue(bean: genotypeDrugRecommendationInstance, field: "geneName")}</g:link></td>
					
						<td>${fieldValue(bean: genotypeDrugRecommendationInstance, field: "haplotypeName1")}</td>
					
						<td>${fieldValue(bean: genotypeDrugRecommendationInstance, field: "haplotypeName2")}</td>
					
						<td>${fieldValue(bean: genotypeDrugRecommendationInstance, field: "drugRecommendation")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${genotypeDrugRecommendationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

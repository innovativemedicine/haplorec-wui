
<%@ page import="haplorec.wui.GenotypePhenotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-genotypePhenotype" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-genotypePhenotype" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="geneName" title="${message(code: 'genotypePhenotype.geneName.label', default: 'Gene Name')}" />
					
						<g:sortableColumn property="haplotypeName1" title="${message(code: 'genotypePhenotype.haplotypeName1.label', default: 'Haplotype Name1')}" />
					
						<g:sortableColumn property="haplotypeName2" title="${message(code: 'genotypePhenotype.haplotypeName2.label', default: 'Haplotype Name2')}" />
					
						<g:sortableColumn property="phenotypeName" title="${message(code: 'genotypePhenotype.phenotypeName.label', default: 'Phenotype Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${genotypePhenotypeInstanceList}" status="i" var="genotypePhenotypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${genotypePhenotypeInstance.id}">${fieldValue(bean: genotypePhenotypeInstance, field: "geneName")}</g:link></td>
					
						<td>${fieldValue(bean: genotypePhenotypeInstance, field: "haplotypeName1")}</td>
					
						<td>${fieldValue(bean: genotypePhenotypeInstance, field: "haplotypeName2")}</td>
					
						<td>${fieldValue(bean: genotypePhenotypeInstance, field: "phenotypeName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${genotypePhenotypeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

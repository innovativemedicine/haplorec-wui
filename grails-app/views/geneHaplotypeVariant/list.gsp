
<%@ page import="haplorec.wui.GeneHaplotypeVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-geneHaplotypeVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-geneHaplotypeVariant" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="geneName" title="${message(code: 'geneHaplotypeVariant.geneName.label', default: 'Gene Name')}" />
					
						<g:sortableColumn property="haplotypeName" title="${message(code: 'geneHaplotypeVariant.haplotypeName.label', default: 'Haplotype Name')}" />
					
						<g:sortableColumn property="snpId" title="${message(code: 'geneHaplotypeVariant.snpId.label', default: 'Snp Id')}" />
					
						<g:sortableColumn property="allele" title="${message(code: 'geneHaplotypeVariant.allele.label', default: 'Allele')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${geneHaplotypeVariantInstanceList}" status="i" var="geneHaplotypeVariantInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${geneHaplotypeVariantInstance.id}">${fieldValue(bean: geneHaplotypeVariantInstance, field: "geneName")}</g:link></td>
					
						<td>${fieldValue(bean: geneHaplotypeVariantInstance, field: "haplotypeName")}</td>
					
						<td>${fieldValue(bean: geneHaplotypeVariantInstance, field: "snpId")}</td>
					
						<td>${fieldValue(bean: geneHaplotypeVariantInstance, field: "allele")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${geneHaplotypeVariantInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

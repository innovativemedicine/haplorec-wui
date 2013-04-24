
<%@ page import="haplorec.wui.GeneHaplotypeVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-geneHaplotypeVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-geneHaplotypeVariant" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list geneHaplotypeVariant">
			
				<g:if test="${geneHaplotypeVariantInstance?.geneName}">
				<li class="fieldcontain">
					<span id="geneName-label" class="property-label"><g:message code="geneHaplotypeVariant.geneName.label" default="Gene Name" /></span>
					
						<span class="property-value" aria-labelledby="geneName-label"><g:fieldValue bean="${geneHaplotypeVariantInstance}" field="geneName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${geneHaplotypeVariantInstance?.haplotypeName}">
				<li class="fieldcontain">
					<span id="haplotypeName-label" class="property-label"><g:message code="geneHaplotypeVariant.haplotypeName.label" default="Haplotype Name" /></span>
					
						<span class="property-value" aria-labelledby="haplotypeName-label"><g:fieldValue bean="${geneHaplotypeVariantInstance}" field="haplotypeName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${geneHaplotypeVariantInstance?.snpId}">
				<li class="fieldcontain">
					<span id="snpId-label" class="property-label"><g:message code="geneHaplotypeVariant.snpId.label" default="Snp Id" /></span>
					
						<span class="property-value" aria-labelledby="snpId-label"><g:fieldValue bean="${geneHaplotypeVariantInstance}" field="snpId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${geneHaplotypeVariantInstance?.allele}">
				<li class="fieldcontain">
					<span id="allele-label" class="property-label"><g:message code="geneHaplotypeVariant.allele.label" default="Allele" /></span>
					
						<span class="property-value" aria-labelledby="allele-label"><g:fieldValue bean="${geneHaplotypeVariantInstance}" field="allele"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${geneHaplotypeVariantInstance?.id}" />
					<g:link class="edit" action="edit" id="${geneHaplotypeVariantInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

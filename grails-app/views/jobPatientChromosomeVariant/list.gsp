
<%@ page import="haplorec.wui.JobPatientChromosomeVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-jobPatientChromosomeVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-jobPatientChromosomeVariant" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientChromosomeVariant.patientId.label', default: 'Patient Id')}" />
					
						<g:sortableColumn property="physicalChromosome" title="${message(code: 'jobPatientChromosomeVariant.physicalChromosome.label', default: 'Physical Chromosome')}" />
					
						<g:sortableColumn property="snpId" title="${message(code: 'jobPatientChromosomeVariant.snpId.label', default: 'Snp Id')}" />
					
						<g:sortableColumn property="allele" title="${message(code: 'jobPatientChromosomeVariant.allele.label', default: 'Allele')}" />
					
						<th><g:message code="jobPatientChromosomeVariant.job.label" default="Job" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientChromosomeVariantInstanceList}" status="i" var="jobPatientChromosomeVariantInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobPatientChromosomeVariantInstance.id}">${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "patientId")}</g:link></td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "physicalChromosome")}</td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "snpId")}</td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "allele")}</td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "job")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientChromosomeVariantInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

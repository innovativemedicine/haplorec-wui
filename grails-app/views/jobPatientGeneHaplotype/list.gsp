
<%@ page import="haplorec.wui.JobPatientGeneHaplotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-jobPatientGeneHaplotype" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-jobPatientGeneHaplotype" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientGeneHaplotype.patientId.label', default: 'Patient Id')}" />
					
						<g:sortableColumn property="geneName" title="${message(code: 'jobPatientGeneHaplotype.geneName.label', default: 'Gene Name')}" />
					
						<g:sortableColumn property="haplotypeName" title="${message(code: 'jobPatientGeneHaplotype.haplotypeName.label', default: 'Haplotype Name')}" />
					
						<th><g:message code="jobPatientGeneHaplotype.job.label" default="Job" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientGeneHaplotypeInstanceList}" status="i" var="jobPatientGeneHaplotypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobPatientGeneHaplotypeInstance.id}">${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "patientId")}</g:link></td>
					
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "geneName")}</td>
					
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "haplotypeName")}</td>
					
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "job")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientGeneHaplotypeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

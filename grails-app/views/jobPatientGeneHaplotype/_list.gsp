
<%@ page import="haplorec.wui.JobPatientGeneHaplotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-jobPatientGeneHaplotype" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientGeneHaplotype.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="geneName" title="${message(code: 'jobPatientGeneHaplotype.geneName.label', default: 'Gene Name')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="haplotypeName" title="${message(code: 'jobPatientGeneHaplotype.haplotypeName.label', default: 'Haplotype Name')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
						<th><g:message code="jobPatientGeneHaplotype.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientGeneHaplotypeInstanceList}" status="i" var="jobPatientGeneHaplotypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobPatientGeneHaplotypeInstance.id}">${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "patientId")}</g:link></td>
					
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "geneName")}</td>
					
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "haplotypeName")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "job")}</td>
                        </g:if>
					
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

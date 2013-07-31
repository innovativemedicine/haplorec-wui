
<%@ page import="haplorec.wui.JobPatientGenotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-jobPatientGenotype" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientGenotype.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>

						<g:sortableColumn property="hetCombo" title="${message(code: 'jobPatientGenotype.hetCombo.label', default: 'Het Combo')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="geneName" title="${message(code: 'jobPatientGenotype.geneName.label', default: 'Gene Name')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="haplotypeName1" title="${message(code: 'jobPatientGenotype.haplotypeName1.label', default: 'Haplotype Name1')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="haplotypeName2" title="${message(code: 'jobPatientGenotype.haplotypeName2.label', default: 'Haplotype Name2')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
						<th><g:message code="jobPatientGenotype.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientGenotypeInstanceList}" status="i" var="jobPatientGenotypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: jobPatientGenotypeInstance, field: "patientId")}</td>

						<td>${fieldValue(bean: jobPatientGenotypeInstance, field: "hetCombo") ?: 1} / ${fieldValue(bean: jobPatientGenotypeInstance, field: "hetCombos") ?: 1}</td>
					
						<td>${fieldValue(bean: jobPatientGenotypeInstance, field: "geneName")}</td>
					
						<td>${fieldValue(bean: jobPatientGenotypeInstance, field: "haplotypeName1")}</td>
					
						<td>${fieldValue(bean: jobPatientGenotypeInstance, field: "haplotypeName2")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientGenotypeInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientGenotypeInstanceTotal}" params="[jobId:jobId]"/>
			</div>
		</div>
	</body>
</html>

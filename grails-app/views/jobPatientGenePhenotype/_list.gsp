
<%@ page import="haplorec.wui.JobPatientGenePhenotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-jobPatientGenePhenotype" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientGenePhenotype.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>

						<g:sortableColumn property="hetCombo" title="${message(code: 'jobPatientGenePhenotype.hetCombo.label', default: 'Het Combo')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="geneName" title="${message(code: 'jobPatientGenePhenotype.geneName.label', default: 'Gene Name')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="phenotypeName" title="${message(code: 'jobPatientGenePhenotype.phenotypeName.label', default: 'Phenotype Name')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
						<th><g:message code="jobPatientGenePhenotype.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientGenePhenotypeInstanceList}" status="i" var="jobPatientGenePhenotypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: jobPatientGenePhenotypeInstance, field: "patientId")}</td>

						<td>${fieldValue(bean: jobPatientGenePhenotypeInstance, field: "hetCombo") ?: 1} / ${fieldValue(bean: jobPatientGenePhenotypeInstance, field: "hetCombos") ?: 1}</td>
					
						<td>${fieldValue(bean: jobPatientGenePhenotypeInstance, field: "geneName")}</td>
					
						<td>${fieldValue(bean: jobPatientGenePhenotypeInstance, field: "phenotypeName")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientGenePhenotypeInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientGenePhenotypeInstanceTotal}" params="[jobId:jobId]"/>
			</div>
		</div>
	</body>
</html>

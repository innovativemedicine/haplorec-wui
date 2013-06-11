
<%@ page import="haplorec.wui.JobPatientChromosomeVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-jobPatientChromosomeVariant" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientChromosomeVariant.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="physicalChromosome" title="${message(code: 'jobPatientChromosomeVariant.physicalChromosome.label', default: 'Physical Chromosome')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="snpId" title="${message(code: 'jobPatientChromosomeVariant.snpId.label', default: 'Snp Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="allele" title="${message(code: 'jobPatientChromosomeVariant.allele.label', default: 'Allele')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
						<th><g:message code="jobPatientChromosomeVariant.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientChromosomeVariantInstanceList}" status="i" var="jobPatientChromosomeVariantInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "patientId")}</td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "physicalChromosome")}</td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "snpId")}</td>
					
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "allele")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientChromosomeVariantInstance, field: "job")}</td>
                        </g:if>
					
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

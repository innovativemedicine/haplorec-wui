
<%@ page import="haplorec.wui.JobPatientVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientVariant.label', default: 'JobPatientVariant')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-jobPatientVariant" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientVariant.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="physicalChromosome" title="${message(code: 'jobPatientVariant.physicalChromosome.label', default: 'Physical Chromosome')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="snpId" title="${message(code: 'jobPatientVariant.snpId.label', default: 'Snp Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="allele" title="${message(code: 'jobPatientVariant.allele.label', default: 'Allele')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="zygosity" title="${message(code: 'jobPatientVariant.zygosity.label', default: 'Zygosity')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
						<th><g:message code="jobPatientVariant.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientVariantInstanceList}" status="i" var="jobPatientVariantInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "patientId")}</td>
					
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "physicalChromosome")}</td>
					
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "snpId")}</td>
					
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "allele")}</td>
					
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "zygosity")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientVariantInstanceTotal}" params="[jobId:jobId]"/>
			</div>
		</div>
	</body>
</html>

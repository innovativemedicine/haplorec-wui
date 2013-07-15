
<%@ page import="haplorec.wui.JobPatientUniqueHaplotype" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <%--
		<a href="#list-jobPatientUniqueHaplotype" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-jobPatientUniqueHaplotype" class="content scaffold-list" role="main">
        --%>
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientUniqueHaplotype.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="physicalChromosome" title="${message(code: 'jobPatientUniqueHaplotype.physicalChromosome.label', default: 'Physical Chromosome')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="geneName" title="${message(code: 'jobPatientUniqueHaplotype.geneName.label', default: 'Gene Name')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
                        <th><g:message code="jobPatientGeneHaplotype.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientUniqueHaplotypeInstanceList}" status="i" var="jobPatientUniqueHaplotypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: jobPatientUniqueHaplotypeInstance, field: "patientId")}</td>
					
						<td>${fieldValue(bean: jobPatientUniqueHaplotypeInstance, field: "physicalChromosome")}</td>
					
						<td>${fieldValue(bean: jobPatientUniqueHaplotypeInstance, field: "geneName")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientGeneHaplotypeInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientUniqueHaplotypeInstanceTotal}" params="[jobId:jobId]"/>
			</div>

            <g:if test="${jobId != null}">
            <g:link class="drug-report btn btn-primary" controller="pipelineJob" action="novelHaplotypeReport" id="${jobId}">${entityName} Report</g:link>
            </g:if>

		</div>
	</body>
</html>

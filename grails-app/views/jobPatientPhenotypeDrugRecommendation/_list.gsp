
<%@ page import="haplorec.wui.JobPatientPhenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <%--
		<a href="#list-jobPatientPhenotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
        --%>
		<div id="list-jobPatientPhenotypeDrugRecommendation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientPhenotypeDrugRecommendation.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>

                        <%-- join drugRecommendation
						<th><g:message code="jobPatientPhenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></th>
                        --%>

						<g:sortableColumn property="drugRecommendation.drugName" title="${message(code: 'drugRecommendation.drugName.label', default: 'Drug Name')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.implications" title="${message(code: 'drugRecommendation.implications.label', default: 'Implications')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.recommendation" title="${message(code: 'drugRecommendation.recommendation.label', default: 'Recommendation')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.classification" title="${message(code: 'drugRecommendation.classification.label', default: 'Classification')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.diplotypeEgs" title="${message(code: 'drugRecommendation.diplotypeEgs.label', default: 'Diplotype Egs')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
                        <th><g:message code="jobPatientPhenotypeDrugRecommendation.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientPhenotypeDrugRecommendationInstanceList}" status="i" var="jobPatientPhenotypeDrugRecommendationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobPatientPhenotypeDrugRecommendationInstance.id}">${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance, field: "patientId")}</g:link></td>
					
                        <%-- join drugRecommendation
						<td>${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance, field: "drugRecommendation")}</td>
                        --%>
					
						<td><g:link controller="drugRecommendation" action="show" id="${jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation?.id}">${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation, field: "drugName")}</g:link></td>
					
						<td>${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation, field: "implications")}</td>
					
						<td>${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation, field: "recommendation")}</td>
					
						<td>${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation, field: "classification")}</td>
					
						<td>${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation, field: "diplotypeEgs")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientPhenotypeDrugRecommendationInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientPhenotypeDrugRecommendationInstanceTotal}" />
			</div>

            <g:if test="${jobId != null}">
            <g:link class="drug-report btn btn-primary" controller="pipelineJob" action="phenotypeReport" id="${jobId}">${entityName} Report</g:link>
            </g:if>

		</div>
	</body>
</html>

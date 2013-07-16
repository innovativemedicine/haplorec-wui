
<%@ page import="haplorec.wui.JobPatientGenotypeDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <%--
		<a href="#list-jobPatientGenotypeDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
        --%>
		<div id="list-jobPatientGenotypeDrugRecommendation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <g:if test="${jobId != null}">
            <g:link class="drug-report btn btn-primary" controller="pipelineJob" action="genotypeReport" id="${jobId}">${entityName} Report</g:link>
            </g:if>

			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientGenotypeDrugRecommendation.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>

                        <%-- join drugRecommendation
						<th><g:message code="jobPatientGenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></th>
                        --%>

						<g:sortableColumn property="drugRecommendation.drugName" title="${message(code: 'drugRecommendation.drugName.label', default: 'Drug Name')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.implications" title="${message(code: 'drugRecommendation.implications.label', default: 'Implications')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.recommendation" title="${message(code: 'drugRecommendation.recommendation.label', default: 'Recommendation')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.classification" title="${message(code: 'drugRecommendation.classification.label', default: 'Classification')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="drugRecommendation.diplotypeEgs" title="${message(code: 'drugRecommendation.diplotypeEgs.label', default: 'Diplotype Egs')}" params="[jobId:jobId]"/>
					
                        <g:if test="${jobId == null}">
                        <th><g:message code="jobPatientGenotypeDrugRecommendation.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientGenotypeDrugRecommendationInstanceList}" status="i" var="jobPatientGenotypeDrugRecommendationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: jobPatientGenotypeDrugRecommendationInstance, field: "patientId")}</td>
					
                        <%-- join drugRecommendation
						<td>${fieldValue(bean: jobPatientGenotypeDrugRecommendationInstance, field: "drugRecommendation")}</td>
                        --%>
					
						<td><g:link controller="drugRecommendation" action="show" id="${jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation?.id}">${fieldValue(bean: jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation, field: "drugName")}</g:link></td>
					
						<td>${jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation?.imp_shortener()}</td>
					
						<td>${jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation?.rec_shortener()}</td>
					
						<td>${fieldValue(bean: jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation, field: "classification")}</td>
					
						<td>${fieldValue(bean: jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation, field: "diplotypeEgs")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientGenotypeDrugRecommendationInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientGenotypeDrugRecommendationInstanceTotal}" params="[jobId:jobId]"/>
			</div>

		</div>
	</body>
</html>


<%@ page import="haplorec.wui.JobPatientDrugRecommendation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <%--
		<a href="#list-jobPatientDrugRecommendation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
        --%>
		<div id="list-jobPatientDrugRecommendation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientDrugRecommendation.patientId.label', default: 'Patient Id')}" />
					
						<th><g:message code="jobPatientDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" /></th>
					
                        <g:if test="${jobId == null}">
                        <th><g:message code="jobPatientDrugRecommendation.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientDrugRecommendationInstanceList}" status="i" var="jobPatientDrugRecommendationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobPatientDrugRecommendationInstance.id}">${fieldValue(bean: jobPatientDrugRecommendationInstance, field: "patientId")}</g:link></td>
					
						<td>${fieldValue(bean: jobPatientDrugRecommendationInstance, field: "drugRecommendation")}</td>
					
                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientDrugRecommendationInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientDrugRecommendationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

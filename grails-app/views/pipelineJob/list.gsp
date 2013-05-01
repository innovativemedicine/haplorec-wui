<%@ page import="haplorec.wui.Job" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<div id="list-job" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="jobName" title="${message(code: 'job.jobName.label', default: 'Job Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobInstanceList}" status="i" var="jobInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobInstance.id}">${fieldValue(bean: jobInstance, field: "jobName")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobInstanceTotal}" />
			</div>
		</div>

	</body>
</html>

<%@ page import="haplorec.wui.Job" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
	
		<div id="create-job" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${jobInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${jobInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:uploadForm action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					<button type="button" id="startup">Here</button>
				</fieldset>
			</g:uploadForm>
		</div>
		<r:script>
		$(document).ready(function(){
			$("#startup").click(function(){
				jsonstream.get("http://localhost:8080/haplorec-wui/pipelineJob/status?jobId=18",function(n){console.log(n)});
			});
		});
		
		</r:script>
	</body>
</html>

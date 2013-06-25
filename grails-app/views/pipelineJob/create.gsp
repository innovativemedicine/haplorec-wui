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
					<button type="button" class="save">Here</button>
				</fieldset>
			</g:uploadForm>
		</div>
		<r:script>
		$(document).ready(function(){
			$(".save").click(function(){
				jsonstream.get(
					'${createLink(controller:'pipelineJob', action:'status')}?jobId=${Job.list()[-1].getId()+1}',
						function(message){
							if (message.state=="done"){
							$("#"+message.target).removeClass("running failed").addClass("done");
							}
							if (message.state=="running"){
							$("#"+message.target).removeClass("done failed").addClass("running");
							}
							if (message.state=="failed"){
							$("#"+message.target).removeClass("done running").addClass("failed");
							}
						}
				);
			});	
		});
		</r:script>
	</body>
</html>

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
			
			<g:uploadForm action="save">
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
              
				</fieldset>
			</g:uploadForm> 
		</div>
		<div class="iframeloading"></div>
		<r:script>
		$(document).ready(function(){
			var next_id = "loading/"+${ident}.Auto_increment.toString();
			
			//using iframe to avoid getOuputStream already called error
			
			$(".save").click(function(){
				setTimeout(
				function(){
				$("#create-job").hide();
				$(".buttons").hide();
				$(".iframeloading").html('<iframe src="'+next_id+'" seamless width=100% height=800px scrolling="no"></iframe>');
				}
				,500);
				
			});	
		});
		
		</r:script>
	</body>
</html>


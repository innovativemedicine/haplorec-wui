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
					<a class='blamo'>blamo</a>
              
				</fieldset>
			</g:uploadForm> 
			<input class='save2' type='submit' value='hello'/>
		</div>
		<div class="iframeloading"></div>
		<r:script>
		
		$(document).ready(function(){
			//using iframe to avoid getOuputStream already called error
			$(".save").click(function(){
			//$(".blamo").click(function(){
			// $(".save").click(function(){
				
				// $(".iframeloading").html("herpderp");
				// setTimeout(function() {

					$('#create-job form').submit(function(e) {
				        e.preventDefault();
				        $.ajax({
				            type: 'POST',
				            cache: false,
				            url: "${createLink(controller:'pipelineJob', action:'save')}",
				            data: $(this).serialize(), 

				        })
				        .done(function(data) {
			            	debugger;
			                $("body").html(data);
			            })
			            .fail(function(jqXHR, textStatus, errorThrown) {
			            	$("body").html(jqXHR.responseText);
			            	debugger;
			            });
					});
					// var new_job = "${resource()}"

					// var iframeHtml = '<iframe src="'+new_job+'" seamless width=100% height=800px scrolling="no"></iframe>';
					var iframe = document.createElement("iframe");
					iframe.onload = pollIframe;
					iframe.src = "loading/?jobName="+$("#jobName").val();
					var timeoutID = null;
					var pollIframe = function() {
						alert("iframe loaded");
						if ($('#loading-page', iframe.document).length > 0) {
							/* The pipeline job page has been created and we can start watching it load.
							 */
							$(".iframeloading")[0].appendChild(iframe);
							if (timeoutID !== null) {
								clearTimeout(timeoutID);
							}
		 					$("#create-job").hide();
							$(".buttons").hide();
						} else if (timeoutID === null) {
							/* Poll until it's created.
							 */ 	
							 timeoutID = setTimeout(pollIframe, 1*1000);
						}
					};
					
				 	



					
					

					//$(".iframeloading").html(iframeHtml);
					//var iframe = $(".iframeloading iframe").get(0);
				// }, 1);
				
				//while($("iframe").contents().find("#list-job").length>0){
				//	$(".iframeloading").html(iframeHtml);
				//}
			});	
		});
		
		</r:script>
	</body>
</html>


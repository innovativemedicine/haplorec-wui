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
		<r:script>
		
		$(document).ready(function(){
			$(".save").click(function(){

                    if (!($("#jobName").val()=="")){
					/* Asynchronously submit the form (since synchronously submitting it has a weird issue
					 * where we can't conurrently perform a GET to check job status.
					 */
					$('#create-job form').submit(function(e) {
				        e.preventDefault();
				        $.ajax({
				            type: 'POST',
				            cache: false,
		                    contentType: false,
        					processData: false,
				            url: "${createLink(controller:'pipelineJob', action:'save')}",
				            data: new FormData(this),

				        })
                        .done(function(data, textStatus, jqXHR) {
                            /* Manually redirect to the new job's show page (to emulate a synchronous request).
                             */
                            window.location.href = "${createLink(controller: 'pipelineJob', action: 'show')}?jobName="+$("#jobName").val();
                            
			            })
			            .fail(function(jqXHR, textStatus, errorThrown) {
			            	$("body").html(jqXHR.responseText);
			            });
					});

					/* Check the job status by loading it in an iframe.  Since the job may not be created 
					 * yet, this request might fail, so we poll until it succeeds.
					 */
                    var loadingPage = "${createLink(controller: 'pipelineJob', action: 'status')}?jobName="+$("#jobName").val();
					var timeoutID = null;

					var pollLoading = function() {
                        $("._jsPlumb_connector").hide();
                        $(".dependency").hide();
                        $("._jsPlumb_endpoint").hide();
                        jsonstream.get(
                            loadingPage,
                            function(message) {

                                //getting rid of numbers since they dont update, and loading image

                                var node_content = $("#"+message.target).html();
                                var new_content = node_content.replace(/[0-9()]/g,"");
                                new_content = new_content.replace('<img src="${resource(dir: 'images', file: 'spin.gif')}" alt="Loading">','');
                                $("#"+message.target).html(new_content);

                                //updating nodes

                                if (message.state=="done"){
                                    $("#"+message.target).removeClass("running failed").addClass("done").show();
                                }
                                if (message.state=="running"){
                                    var x = $("#"+message.target).html()
                                    $("#"+message.target).html('<img src="${resource(dir: 'images', file: 'spin.gif')}" alt="Loading">'+x).removeClass("done failed").addClass("running").show();
                                }
                                if (message.state=="failed"){
                                    $("#"+message.target).removeClass("done running").addClass("failed").show();
                                }

                                /* The pipeline job page has been created and we can start watching it load.
                                 */
                                if (timeoutID !== null) {
                                    clearTimeout(timeoutID);
                                }
                            },
                            function() {
                                if (timeoutID === null) {
                                    /* Poll until it's created.
                                     */ 	
                                    timeoutID = setTimeout(pollLoading, 1*1000);
                                }
                            }
                        );
					};
                    pollLoading();

			}});	
		});
		
		</r:script>
	</body>
</html>


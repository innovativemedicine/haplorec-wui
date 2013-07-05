<%@ page import="haplorec.wui.Job" %>

<r:require modules="pipeline, backbone, jquery, jsonstream"/>
<r:script>
var g, gView;
$(document).ready(function(){
    g = new pipeline.DependencyGraph(${dependencyGraphJSON});
    gView = new pipeline.Views.DependencyGraphShow({
        model: g, 
        height: $(window).height()/3,
        spinnerContainer: $('.spinner-container'),
    });
    gView.fetchAsync = function(index) {
        return ! $(this).hasClass('drug-report');
    };
    gView.render();
    Backbone.history.start();
    
    // TODO: remove this; it's to facilitate testing of pipelineJob/status
    jsonstream.get('${createLink(controller:'pipelineJob', action:'status')}?jobId=${jobInstance.id}', function(message) {
	    console.log(message)
    });
});
</r:script>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title>Loading Job</title>
	
	</head>
	<body>
		<div id="show-job" class="content scaffold-show" role="main">
			<h1>
				<g:if test="${jobInstance?.jobName}">
                <span class="property-value" aria-labelledby="jobName-label"><g:fieldValue bean="${jobInstance}" field="jobName"/></span>
                </g:if>
                <g:else>
                <g:message code="default.show.label" args="[entityName]" />
                </g:else>
            </h1>


			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <div id="dependency-graph"></div>

          
  
		</div>
		<r:script>
		$(document).ready(function(){
				$(".navbar").hide();
				$("._jsPlumb_connector").hide();
				$(".dependency").hide();
				$("._jsPlumb_endpoint").hide();
				
				jsonstream.get(
					'${createLink(controller:'pipelineJob', action:'status')}?jobId=${jobInstance.id}',
						function(message){
						
							//getting rid of numbers since they dont update, and loading image
							
							var node_content = $("#"+message.target).html();
							var new_content = node_content.replace(/[0-9]/g,"");
							new_content = new_content.replace("(","");
							new_content = new_content.replace(")","");
							new_content = new_content.replace('<img src="/haplorec-wui/static/images/spin.gif" alt="Loading">','');
							$("#"+message.target).html(new_content);
							
							//updating nodes
							
							if (message.state=="done"){
								$("#"+message.target).removeClass("running failed").addClass("done").show();
							}
							if (message.state=="running"){
								var x = $("#"+message.target).html()
								$("#"+message.target).html('<img src="${resource(dir: 'images', file: 'spin.gif')}" alt="Loading"/>'+x).removeClass("done failed").addClass("running").show();
							}
							if (message.state=="failed"){
								$("#"+message.target).removeClass("done running").addClass("failed").show();
							}
						}
				);
				
		});	
		
		</r:script>
	</body>
</html>
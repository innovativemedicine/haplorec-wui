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

});
</r:script>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	
	</head>
	<body>
		<div id="show-job" class="content scaffold-show" role="main">
            <div class="job-header">
                <h1>
                    <g:if test="${jobInstance?.jobName}">
                    <span class="property-value" aria-labelledby="jobName-label"><g:fieldValue bean="${jobInstance}" field="jobName"/></span>
                    </g:if>
                    <g:else>
                    <g:message code="default.show.label" args="[entityName]" />
                    </g:else>
                </h1>
                <div>
                    <g:form class='delete-form pull-right align-center'>
                    <fieldset class="buttons">
                        <g:hiddenField name="id" value="${jobInstance?.id}" />
                        <g:actionSubmit class="delete btn btn-danger delete-btn align-center" action="delete" value="${message(code: 'custom.button.delete.label', default: 'Delete', args: [entityName])}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </fieldset>
                    </g:form>
                </div>
            </div>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <div id="dependency-graph"></div>

            <%--
			<ol class="property-list job">
			
				<li class="fieldcontain">
					<span id="jobName-label" class="property-label"><g:message code="job.jobName.label" default="Job Name" /></span>
					
						
					
				</li>
			
				<g:if test="${jobInstance?.jobPatientDrugRecommendations}">
				<li class="fieldcontain">
					<span id="jobPatientDrugRecommendations-label" class="property-label"><g:message code="job.jobPatientDrugRecommendations.label" default="Job Patient Drug Recommendations" /></span>
					
						<g:each in="${jobInstance.jobPatientDrugRecommendations}" var="j">
						<span class="property-value" aria-labelledby="jobPatientDrugRecommendations-label"><g:link controller="jobPatientDrugRecommendation" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientGeneHaplotypes}">
				<li class="fieldcontain">
					<span id="jobPatientGeneHaplotypes-label" class="property-label"><g:message code="job.jobPatientGeneHaplotypes.label" default="Job Patient Gene Haplotypes" /></span>
					
						<g:each in="${jobInstance.jobPatientGeneHaplotypes}" var="j">
						<span class="property-value" aria-labelledby="jobPatientGeneHaplotypes-label"><g:link controller="jobPatientGeneHaplotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientGenePhenotypes}">
				<li class="fieldcontain">
					<span id="jobPatientGenePhenotypes-label" class="property-label"><g:message code="job.jobPatientGenePhenotypes.label" default="Job Patient Gene Phenotypes" /></span>
					
						<g:each in="${jobInstance.jobPatientGenePhenotypes}" var="j">
						<span class="property-value" aria-labelledby="jobPatientGenePhenotypes-label"><g:link controller="jobPatientGenePhenotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientGenotypes}">
				<li class="fieldcontain">
					<span id="jobPatientGenotypes-label" class="property-label"><g:message code="job.jobPatientGenotypes.label" default="Job Patient Genotypes" /></span>
					
						<g:each in="${jobInstance.jobPatientGenotypes}" var="j">
						<span class="property-value" aria-labelledby="jobPatientGenotypes-label"><g:link controller="jobPatientGenotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${jobInstance?.jobPatientVariants}">
				<li class="fieldcontain">
					<span id="jobPatientVariants-label" class="property-label"><g:message code="job.jobPatientVariants.label" default="Job Patient Variants" /></span>
					
						<g:each in="${jobInstance.jobPatientVariants}" var="j">
						<span class="property-value" aria-labelledby="jobPatientVariants-label"><g:link controller="jobPatientVariant" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
            --%>
  
		</div>
		<r:script>
		/* Hiding the enitre dependency graph
		 * using jsonstream.get() to show each dependency as it switches between states
		 * and to show the entire dependency graph if all the dependencies are done
		 */
		$(document).ready(function(){
				$("._jsPlumb_connector").hide();
				$(".dependency").hide();
				$("._jsPlumb_endpoint").hide();
				jsonstream.get(
					'${createLink(controller:'pipelineJob', action:'status')}?jobId=${jobInstance.id}',
						function(message){
						
							/* Hiding loading spinner
							 */
							var y = $("#"+message.target).html().replace('<img src="${resource(dir: 'images', file: 'spin.gif')}" alt="Loading">','');
							$("#"+message.target).html(y)
							
							/* Updating dependency's class with it's state
							 */
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
							
							/* showing complete graph
							 */
							if ($(".dependency").length==$(".done").length){
								$("._jsPlumb_connector").show();
								$("._jsPlumb_endpoint").show();
							}
						}
				);
				
		});	
		
		</r:script>
	</body>
</html>

<%@ page import="haplorec.wui.JobPatientDrugRecommendation" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientDrugRecommendationInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientDrugRecommendation.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientDrugRecommendationInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientDrugRecommendationInstance, field: 'drugRecommendation', 'error')} required">
	<label for="drugRecommendation">
		<g:message code="jobPatientDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="drugRecommendation" name="drugRecommendation.id" from="${haplorec.wui.DrugRecommendation.list()}" optionKey="id" required="" value="${jobPatientDrugRecommendationInstance?.drugRecommendation?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientDrugRecommendationInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientDrugRecommendation.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientDrugRecommendationInstance?.job?.id}" class="many-to-one"/>
</div>


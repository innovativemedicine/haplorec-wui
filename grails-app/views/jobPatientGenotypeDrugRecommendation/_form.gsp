<%@ page import="haplorec.wui.JobPatientGenotypeDrugRecommendation" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeDrugRecommendationInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientGenotypeDrugRecommendation.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientGenotypeDrugRecommendationInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeDrugRecommendationInstance, field: 'drugRecommendation', 'error')} required">
	<label for="drugRecommendation">
		<g:message code="jobPatientGenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="drugRecommendation" name="drugRecommendation.id" from="${haplorec.wui.DrugRecommendation.list()}" optionKey="id" required="" value="${jobPatientGenotypeDrugRecommendationInstance?.drugRecommendation?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeDrugRecommendationInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientGenotypeDrugRecommendation.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientGenotypeDrugRecommendationInstance?.job?.id}" class="many-to-one"/>
</div>


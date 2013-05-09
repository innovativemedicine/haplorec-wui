<%@ page import="haplorec.wui.JobPatientPhenotypeDrugRecommendation" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientPhenotypeDrugRecommendationInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientPhenotypeDrugRecommendation.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientPhenotypeDrugRecommendationInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientPhenotypeDrugRecommendationInstance, field: 'drugRecommendation', 'error')} required">
	<label for="drugRecommendation">
		<g:message code="jobPatientPhenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="drugRecommendation" name="drugRecommendation.id" from="${haplorec.wui.DrugRecommendation.list()}" optionKey="id" required="" value="${jobPatientPhenotypeDrugRecommendationInstance?.drugRecommendation?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientPhenotypeDrugRecommendationInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientPhenotypeDrugRecommendation.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientPhenotypeDrugRecommendationInstance?.job?.id}" class="many-to-one"/>
</div>


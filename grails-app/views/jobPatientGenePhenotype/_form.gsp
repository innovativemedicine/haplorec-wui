<%@ page import="haplorec.wui.JobPatientGenePhenotype" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientGenePhenotypeInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientGenePhenotype.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientGenePhenotypeInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenePhenotypeInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="jobPatientGenePhenotype.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${jobPatientGenePhenotypeInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenePhenotypeInstance, field: 'phenotypeName', 'error')} ">
	<label for="phenotypeName">
		<g:message code="jobPatientGenePhenotype.phenotypeName.label" default="Phenotype Name" />
		
	</label>
	<g:textField name="phenotypeName" maxlength="50" value="${jobPatientGenePhenotypeInstance?.phenotypeName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenePhenotypeInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientGenePhenotype.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientGenePhenotypeInstance?.job?.id}" class="many-to-one"/>
</div>


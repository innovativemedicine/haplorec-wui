<%@ page import="haplorec.wui.JobPatientGeneHaplotype" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientGeneHaplotypeInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientGeneHaplotype.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientGeneHaplotypeInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGeneHaplotypeInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="jobPatientGeneHaplotype.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${jobPatientGeneHaplotypeInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGeneHaplotypeInstance, field: 'haplotypeName', 'error')} ">
	<label for="haplotypeName">
		<g:message code="jobPatientGeneHaplotype.haplotypeName.label" default="Haplotype Name" />
		
	</label>
	<g:textField name="haplotypeName" maxlength="50" value="${jobPatientGeneHaplotypeInstance?.haplotypeName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGeneHaplotypeInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientGeneHaplotype.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientGeneHaplotypeInstance?.job?.id}" class="many-to-one"/>
</div>


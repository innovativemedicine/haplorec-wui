<%@ page import="haplorec.wui.JobPatientUniqueHaplotype" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientUniqueHaplotypeInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientUniqueHaplotype.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientUniqueHaplotypeInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientUniqueHaplotypeInstance, field: 'physicalChromosome', 'error')} ">
	<label for="physicalChromosome">
		<g:message code="jobPatientUniqueHaplotype.physicalChromosome.label" default="Physical Chromosome" />
		
	</label>
	<g:textField name="physicalChromosome" maxlength="50" value="${jobPatientUniqueHaplotypeInstance?.physicalChromosome}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientUniqueHaplotypeInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="jobPatientUniqueHaplotype.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${jobPatientUniqueHaplotypeInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientUniqueHaplotypeInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientUniqueHaplotype.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientUniqueHaplotypeInstance?.job?.id}" class="many-to-one"/>
</div>


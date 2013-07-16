<%@ page import="haplorec.wui.JobPatientNovelHaplotype" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientNovelHaplotypeInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientNovelHaplotype.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientNovelHaplotypeInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientNovelHaplotypeInstance, field: 'physicalChromosome', 'error')} ">
	<label for="physicalChromosome">
		<g:message code="jobPatientNovelHaplotype.physicalChromosome.label" default="Physical Chromosome" />
		
	</label>
	<g:textField name="physicalChromosome" maxlength="50" value="${jobPatientNovelHaplotypeInstance?.physicalChromosome}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientNovelHaplotypeInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="jobPatientNovelHaplotype.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${jobPatientNovelHaplotypeInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientNovelHaplotypeInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientNovelHaplotype.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientNovelHaplotypeInstance?.job?.id}" class="many-to-one"/>
</div>


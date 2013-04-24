<%@ page import="haplorec.wui.JobPatientGenotype" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientGenotype.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientGenotypeInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="jobPatientGenotype.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${jobPatientGenotypeInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeInstance, field: 'haplotypeName1', 'error')} ">
	<label for="haplotypeName1">
		<g:message code="jobPatientGenotype.haplotypeName1.label" default="Haplotype Name1" />
		
	</label>
	<g:textField name="haplotypeName1" maxlength="50" value="${jobPatientGenotypeInstance?.haplotypeName1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeInstance, field: 'haplotypeName2', 'error')} ">
	<label for="haplotypeName2">
		<g:message code="jobPatientGenotype.haplotypeName2.label" default="Haplotype Name2" />
		
	</label>
	<g:textField name="haplotypeName2" maxlength="50" value="${jobPatientGenotypeInstance?.haplotypeName2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientGenotypeInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientGenotype.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientGenotypeInstance?.job?.id}" class="many-to-one"/>
</div>


<%@ page import="haplorec.wui.JobPatientChromosomeVariant" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientChromosomeVariantInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientChromosomeVariant.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientChromosomeVariantInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientChromosomeVariantInstance, field: 'physicalChromosome', 'error')} ">
	<label for="physicalChromosome">
		<g:message code="jobPatientChromosomeVariant.physicalChromosome.label" default="Physical Chromosome" />
		
	</label>
	<g:textField name="physicalChromosome" maxlength="50" value="${jobPatientChromosomeVariantInstance?.physicalChromosome}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientChromosomeVariantInstance, field: 'snpId', 'error')} ">
	<label for="snpId">
		<g:message code="jobPatientChromosomeVariant.snpId.label" default="Snp Id" />
		
	</label>
	<g:textField name="snpId" maxlength="50" value="${jobPatientChromosomeVariantInstance?.snpId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientChromosomeVariantInstance, field: 'allele', 'error')} ">
	<label for="allele">
		<g:message code="jobPatientChromosomeVariant.allele.label" default="Allele" />
		
	</label>
	<g:textField name="allele" maxlength="50" value="${jobPatientChromosomeVariantInstance?.allele}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientChromosomeVariantInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientChromosomeVariant.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientChromosomeVariantInstance?.job?.id}" class="many-to-one"/>
</div>


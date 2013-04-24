<%@ page import="haplorec.wui.JobPatientVariant" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientVariantInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientVariant.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientVariantInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientVariantInstance, field: 'physicalChromosome', 'error')} ">
	<label for="physicalChromosome">
		<g:message code="jobPatientVariant.physicalChromosome.label" default="Physical Chromosome" />
		
	</label>
	<g:textField name="physicalChromosome" maxlength="50" value="${jobPatientVariantInstance?.physicalChromosome}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientVariantInstance, field: 'snpId', 'error')} ">
	<label for="snpId">
		<g:message code="jobPatientVariant.snpId.label" default="Snp Id" />
		
	</label>
	<g:textField name="snpId" maxlength="50" value="${jobPatientVariantInstance?.snpId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientVariantInstance, field: 'allele', 'error')} ">
	<label for="allele">
		<g:message code="jobPatientVariant.allele.label" default="Allele" />
		
	</label>
	<g:textField name="allele" maxlength="50" value="${jobPatientVariantInstance?.allele}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientVariantInstance, field: 'zygosity', 'error')} ">
	<label for="zygosity">
		<g:message code="jobPatientVariant.zygosity.label" default="Zygosity" />
		
	</label>
	<g:textField name="zygosity" maxlength="3" value="${jobPatientVariantInstance?.zygosity}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientVariantInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientVariant.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientVariantInstance?.job?.id}" class="many-to-one"/>
</div>


<%@ page import="haplorec.wui.JobPatientHetVariant" %>



<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'patientId', 'error')} ">
	<label for="patientId">
		<g:message code="jobPatientHetVariant.patientId.label" default="Patient Id" />
		
	</label>
	<g:textField name="patientId" maxlength="50" value="${jobPatientHetVariantInstance?.patientId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'physicalChromosome', 'error')} ">
	<label for="physicalChromosome">
		<g:message code="jobPatientHetVariant.physicalChromosome.label" default="Physical Chromosome" />
		
	</label>
	<g:textField name="physicalChromosome" maxlength="50" value="${jobPatientHetVariantInstance?.physicalChromosome}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'hetCombo', 'error')} ">
	<label for="hetCombo">
		<g:message code="jobPatientHetVariant.hetCombo.label" default="Het Combo" />
		
	</label>
	<g:field name="hetCombo" type="number" value="${jobPatientHetVariantInstance.hetCombo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'hetCombos', 'error')} ">
	<label for="hetCombos">
		<g:message code="jobPatientHetVariant.hetCombos.label" default="Het Combos" />
		
	</label>
	<g:field name="hetCombos" type="number" value="${jobPatientHetVariantInstance.hetCombos}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'snpId', 'error')} ">
	<label for="snpId">
		<g:message code="jobPatientHetVariant.snpId.label" default="Snp Id" />
		
	</label>
	<g:textField name="snpId" maxlength="50" value="${jobPatientHetVariantInstance?.snpId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'allele', 'error')} ">
	<label for="allele">
		<g:message code="jobPatientHetVariant.allele.label" default="Allele" />
		
	</label>
	<g:textField name="allele" maxlength="50" value="${jobPatientHetVariantInstance?.allele}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobPatientHetVariantInstance, field: 'job', 'error')} required">
	<label for="job">
		<g:message code="jobPatientHetVariant.job.label" default="Job" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="job" name="job.id" from="${haplorec.wui.Job.list()}" optionKey="id" required="" value="${jobPatientHetVariantInstance?.job?.id}" class="many-to-one"/>
</div>


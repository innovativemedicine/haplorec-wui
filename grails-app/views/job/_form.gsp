<%@ page import="haplorec.wui.Job" %>



<div class="fieldcontain ${hasErrors(bean: jobInstance, field: 'jobName', 'error')} ">
	<label for="jobName">
		<g:message code="job.jobName.label" default="Job Name" />
		
	</label>
	<g:textField name="jobName" maxlength="50" value="${jobInstance?.jobName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: jobInstance, field: 'jobPatientDrugRecommendations', 'error')} ">
	<label for="jobPatientDrugRecommendations">
		<g:message code="job.jobPatientDrugRecommendations.label" default="Job Patient Drug Recommendations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${jobInstance?.jobPatientDrugRecommendations?}" var="j">
    <li><g:link controller="jobPatientDrugRecommendation" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="jobPatientDrugRecommendation" action="create" params="['job.id': jobInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: jobInstance, field: 'jobPatientGeneHaplotypes', 'error')} ">
	<label for="jobPatientGeneHaplotypes">
		<g:message code="job.jobPatientGeneHaplotypes.label" default="Job Patient Gene Haplotypes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${jobInstance?.jobPatientGeneHaplotypes?}" var="j">
    <li><g:link controller="jobPatientGeneHaplotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="jobPatientGeneHaplotype" action="create" params="['job.id': jobInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: jobInstance, field: 'jobPatientGenePhenotypes', 'error')} ">
	<label for="jobPatientGenePhenotypes">
		<g:message code="job.jobPatientGenePhenotypes.label" default="Job Patient Gene Phenotypes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${jobInstance?.jobPatientGenePhenotypes?}" var="j">
    <li><g:link controller="jobPatientGenePhenotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="jobPatientGenePhenotype" action="create" params="['job.id': jobInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: jobInstance, field: 'jobPatientGenotypes', 'error')} ">
	<label for="jobPatientGenotypes">
		<g:message code="job.jobPatientGenotypes.label" default="Job Patient Genotypes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${jobInstance?.jobPatientGenotypes?}" var="j">
    <li><g:link controller="jobPatientGenotype" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="jobPatientGenotype" action="create" params="['job.id': jobInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: jobInstance, field: 'jobPatientVariants', 'error')} ">
	<label for="jobPatientVariants">
		<g:message code="job.jobPatientVariants.label" default="Job Patient Variants" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${jobInstance?.jobPatientVariants?}" var="j">
    <li><g:link controller="jobPatientVariant" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="jobPatientVariant" action="create" params="['job.id': jobInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant')])}</g:link>
</li>
</ul>

</div>


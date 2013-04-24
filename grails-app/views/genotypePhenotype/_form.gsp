<%@ page import="haplorec.wui.GenotypePhenotype" %>



<div class="fieldcontain ${hasErrors(bean: genotypePhenotypeInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="genotypePhenotype.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${genotypePhenotypeInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genotypePhenotypeInstance, field: 'haplotypeName1', 'error')} ">
	<label for="haplotypeName1">
		<g:message code="genotypePhenotype.haplotypeName1.label" default="Haplotype Name1" />
		
	</label>
	<g:textField name="haplotypeName1" maxlength="50" value="${genotypePhenotypeInstance?.haplotypeName1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genotypePhenotypeInstance, field: 'haplotypeName2', 'error')} ">
	<label for="haplotypeName2">
		<g:message code="genotypePhenotype.haplotypeName2.label" default="Haplotype Name2" />
		
	</label>
	<g:textField name="haplotypeName2" maxlength="50" value="${genotypePhenotypeInstance?.haplotypeName2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genotypePhenotypeInstance, field: 'phenotypeName', 'error')} ">
	<label for="phenotypeName">
		<g:message code="genotypePhenotype.phenotypeName.label" default="Phenotype Name" />
		
	</label>
	<g:textField name="phenotypeName" maxlength="50" value="${genotypePhenotypeInstance?.phenotypeName}"/>
</div>


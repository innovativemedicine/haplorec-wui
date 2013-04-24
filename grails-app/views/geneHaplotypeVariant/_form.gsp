<%@ page import="haplorec.wui.GeneHaplotypeVariant" %>



<div class="fieldcontain ${hasErrors(bean: geneHaplotypeVariantInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="geneHaplotypeVariant.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${geneHaplotypeVariantInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: geneHaplotypeVariantInstance, field: 'haplotypeName', 'error')} ">
	<label for="haplotypeName">
		<g:message code="geneHaplotypeVariant.haplotypeName.label" default="Haplotype Name" />
		
	</label>
	<g:textField name="haplotypeName" maxlength="50" value="${geneHaplotypeVariantInstance?.haplotypeName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: geneHaplotypeVariantInstance, field: 'snpId', 'error')} ">
	<label for="snpId">
		<g:message code="geneHaplotypeVariant.snpId.label" default="Snp Id" />
		
	</label>
	<g:textField name="snpId" maxlength="50" value="${geneHaplotypeVariantInstance?.snpId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: geneHaplotypeVariantInstance, field: 'allele', 'error')} ">
	<label for="allele">
		<g:message code="geneHaplotypeVariant.allele.label" default="Allele" />
		
	</label>
	<g:textField name="allele" maxlength="50" value="${geneHaplotypeVariantInstance?.allele}"/>
</div>


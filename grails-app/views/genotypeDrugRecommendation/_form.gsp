<%@ page import="haplorec.wui.GenotypeDrugRecommendation" %>



<div class="fieldcontain ${hasErrors(bean: genotypeDrugRecommendationInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="genotypeDrugRecommendation.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${genotypeDrugRecommendationInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genotypeDrugRecommendationInstance, field: 'haplotypeName1', 'error')} ">
	<label for="haplotypeName1">
		<g:message code="genotypeDrugRecommendation.haplotypeName1.label" default="Haplotype Name1" />
		
	</label>
	<g:textField name="haplotypeName1" maxlength="50" value="${genotypeDrugRecommendationInstance?.haplotypeName1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genotypeDrugRecommendationInstance, field: 'haplotypeName2', 'error')} ">
	<label for="haplotypeName2">
		<g:message code="genotypeDrugRecommendation.haplotypeName2.label" default="Haplotype Name2" />
		
	</label>
	<g:textField name="haplotypeName2" maxlength="50" value="${genotypeDrugRecommendationInstance?.haplotypeName2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genotypeDrugRecommendationInstance, field: 'drugRecommendation', 'error')} required">
	<label for="drugRecommendation">
		<g:message code="genotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="drugRecommendation" name="drugRecommendation.id" from="${haplorec.wui.DrugRecommendation.list()}" optionKey="id" required="" value="${genotypeDrugRecommendationInstance?.drugRecommendation?.id}" class="many-to-one"/>
</div>


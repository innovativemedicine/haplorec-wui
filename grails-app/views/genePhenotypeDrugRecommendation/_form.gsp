<%@ page import="haplorec.wui.GenePhenotypeDrugRecommendation" %>



<div class="fieldcontain ${hasErrors(bean: genePhenotypeDrugRecommendationInstance, field: 'geneName', 'error')} ">
	<label for="geneName">
		<g:message code="genePhenotypeDrugRecommendation.geneName.label" default="Gene Name" />
		
	</label>
	<g:textField name="geneName" maxlength="50" value="${genePhenotypeDrugRecommendationInstance?.geneName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genePhenotypeDrugRecommendationInstance, field: 'phenotypeName', 'error')} ">
	<label for="phenotypeName">
		<g:message code="genePhenotypeDrugRecommendation.phenotypeName.label" default="Phenotype Name" />
		
	</label>
	<g:textField name="phenotypeName" maxlength="50" value="${genePhenotypeDrugRecommendationInstance?.phenotypeName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: genePhenotypeDrugRecommendationInstance, field: 'drugRecommendation', 'error')} required">
	<label for="drugRecommendation">
		<g:message code="genePhenotypeDrugRecommendation.drugRecommendation.label" default="Drug Recommendation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="drugRecommendation" name="drugRecommendation.id" from="${haplorec.wui.DrugRecommendation.list()}" optionKey="id" required="" value="${genePhenotypeDrugRecommendationInstance?.drugRecommendation?.id}" class="many-to-one"/>
</div>


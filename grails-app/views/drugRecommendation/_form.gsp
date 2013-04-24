<%@ page import="haplorec.wui.DrugRecommendation" %>



<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'drugName', 'error')} ">
	<label for="drugName">
		<g:message code="drugRecommendation.drugName.label" default="Drug Name" />
		
	</label>
	<g:textField name="drugName" maxlength="50" value="${drugRecommendationInstance?.drugName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'implications', 'error')} ">
	<label for="implications">
		<g:message code="drugRecommendation.implications.label" default="Implications" />
		
	</label>
	<g:textField name="implications" maxlength="50" value="${drugRecommendationInstance?.implications}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'recommendation', 'error')} ">
	<label for="recommendation">
		<g:message code="drugRecommendation.recommendation.label" default="Recommendation" />
		
	</label>
	<g:textField name="recommendation" maxlength="50" value="${drugRecommendationInstance?.recommendation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'classification', 'error')} ">
	<label for="classification">
		<g:message code="drugRecommendation.classification.label" default="Classification" />
		
	</label>
	<g:textField name="classification" maxlength="50" value="${drugRecommendationInstance?.classification}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'diplotypeEgs', 'error')} ">
	<label for="diplotypeEgs">
		<g:message code="drugRecommendation.diplotypeEgs.label" default="Diplotype Egs" />
		
	</label>
	<g:textField name="diplotypeEgs" maxlength="50" value="${drugRecommendationInstance?.diplotypeEgs}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'genePhenotypeDrugRecommendations', 'error')} ">
	<label for="genePhenotypeDrugRecommendations">
		<g:message code="drugRecommendation.genePhenotypeDrugRecommendations.label" default="Gene Phenotype Drug Recommendations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${drugRecommendationInstance?.genePhenotypeDrugRecommendations?}" var="g">
    <li><g:link controller="genePhenotypeDrugRecommendation" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="genePhenotypeDrugRecommendation" action="create" params="['drugRecommendation.id': drugRecommendationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: drugRecommendationInstance, field: 'genotypeDrugRecommendations', 'error')} ">
	<label for="genotypeDrugRecommendations">
		<g:message code="drugRecommendation.genotypeDrugRecommendations.label" default="Genotype Drug Recommendations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${drugRecommendationInstance?.genotypeDrugRecommendations?}" var="g">
    <li><g:link controller="genotypeDrugRecommendation" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="genotypeDrugRecommendation" action="create" params="['drugRecommendation.id': drugRecommendationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation')])}</g:link>
</li>
</ul>

</div>


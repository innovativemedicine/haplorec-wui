<%@ page import="haplorec.wui.Job" %>

<r:require modules="pipeline, backbone, jquery"/>
<r:script>
var sampleVariant;
var samplegeno;
var samplepheno;
$(document).ready(function(){

	var sampleVariant = new pipeline.Views.sampleinputfile({
	    model: new Backbone.Model(${sampleVariantJSON}),
	    el: $('#sample-variant'), 
	});
	sampleVariant.render();
	var samplegeno = new pipeline.Views.sampleinputfile({
	    model: new Backbone.Model(${samplegenoJSON}),
	    el: $('#sample-outgeno'), 
	});
	samplegeno.render();
	var samplepheno = new pipeline.Views.sampleinputfile({
	    model: new Backbone.Model(${samplephenoJSON}),
	    el: $('#sample-outpheno'), 
	});
	samplepheno.render();
	
});


</r:script>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style>
        </style>
	</head>
	<body>
    <h3>Mapping Variants to Haplotypes:</h3>
    <p>First of all, to determine which variants belong to each side of the chromosome there must be a maximum of one heterozygote variant.</p>
    <p>This is because when the variants are recorded for each location, the physical chromosome which they came from is not stored.</p>
    <img src="${resource(dir: 'images', file: 'chromosomes.png')}" alt="Chromosomes">
    <p>For example, the above physical chromosomes could be recorded as</p>
    <table border="1">
    	<tr>
			<th>Location</th>
			<th>Variant</th>
		</tr>
		<tr>
			<td>rs1</td>
			<td>AG</td>
		</tr>
		<tr>
			<td>rs2</td>
			<td>TC</td>
		</tr>
	</table>
	<h4>OR</h4>
	<table border="1">
		<tr>
			<th>Location</th>
			<th>Variant</th>
		</tr>
		<tr>
			<td>rs1</td>
			<td>AG</td>
		</tr>
		<tr>
			<td>rs2</td>
			<td>CT</td>
		</tr>
	</table>
	<p>The variants can not be split since the data does not show if A and T are on the same physical chromosome or A and C.</p> 
	<h4>How Variants are mapped to Haplotypes:</h4>
	
	<div>A portion of the gene's variants can be used to identify its haplotype if it is unique to a specific haplotype.
	For example, if you have the variants rs1050828 C, rs1050829 T, rs5030868 G then we can determine that the haplotype is B(wildtype) since the combination is unique to B(wildtype).</div>
	<img src="${resource(dir: 'images', file: 'matrix.png')}" alt="Matrix">
	<div><a href="http://www.pharmgkb.org/gene/PA28469#tabview=tab4&subtab=32">Gene-haplotype matrix</a></div>
	<h4>Novel Haplotypes</h4>
	
	<div>A novel haplotype occurs when the input variant list contains at least one snp for that gene, but there exists no known haplotype whose variants include all of the input variants for those snps.
	Also, novel haplotypes can be identified only if there is a maximum of one heterozygote variant in the variant list. </div>
	<h3>Drug Recommendations</h3>
	<h4>Genotype Drug Recommendations</h4>
	<div>The drug recommendation is based off a gene, and two haplotypes</div>
	<h4>Phenotype Drug Recommendations</h4>
	<p>The drug recommendation is based off a gene and a phenotype</p>
	<h4>Sample Drug Recommendation</h4>
	<div><a href="http://www.pharmgkb.org/gene/PA356">TPMT Gene Page</a></div>
	<img src="${resource(dir: 'images', file: 'drugrec.png')}" alt="drugRecommendation">
	
    </body>
</html>

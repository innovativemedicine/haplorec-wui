<%@ page import="haplorec.wui.Job" %>

<r:require modules="pipeline, backbone, jquery"/>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
		<title>Haplorec</title>
        <style>
        </style>
	</head>
	<body>
    <p>Haplorec is a pipeline for mapping sample variants to therapeutic drug recommendations 
    published by the Clinical Pharmacogenetics Implementation Consortium (CPIC), as catalogued by <a 
    href="http://www.pharmgkb.org/page/cpicGeneDrugPairs" target="_blank">PharmGKB</a>.</p>

    <h3>Mapping Variants to Haplotypes:</h3>
    <p>Resolving haplotypes for variants is complected by the presence of heterzygous variants for 
    the same gene.</p>
    <p>This is because when the variants are recorded for each location, the physical chromosome which they came from is not stored.</p>
    <img src="${resource(dir: 'images', file: 'chromosome_1.png')}" alt="Chromosomes">
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

    <p>To work around this limitation, we consider all the heterozygous variant combinations 
    matching the following cases:</p>

    <p>
    <ol>
    <li>There exists <b>one</b> unique known haplotype which contains alleles matching the observed heterozygote 
    alleles.  The remaining alleles (not belonging to the known haplotype) may make up a novel 
    haplotype (or they may ambiguously match more than one known haplotype).</li>
    <li>There exist <b>two</b> unique known haplotypes which contains alleles matching the observed heterozygote 
    alleles. Call those haplotypes.</li>
    </ol>
    <b>NOTE:</b> there can be multiple cases matching each of 1. and 2.
    </p>

	<h4>How Variants are mapped to Haplotypes:</h4>
	
	<div>A portion of the gene's variants can be used to identify its haplotype if it is unique to a specific haplotype.
	For example, if you have the variants rs1050828 C, rs1050829 T, rs5030868 G then we can determine that the haplotype is B(wildtype) since the combination is unique to B(wildtype). 
	However, if you have the variants rs1050828 C, rs1050829 T then we cannot uniquely determine the haplotype since the possible haplotypes are B(wildtype) and Mediterranean Haplotype.
	 Hence, a haplotype is not reported in this case. </div>
	<img src="${resource(dir: 'images', file: 'G6PD.png')}" alt="GeneLabel">
	<img src="${resource(dir: 'images', file: 'matrix.png')}" alt="Matrix">
	<div><a href="http://www.pharmgkb.org/gene/PA28469#tabview=tab4&subtab=32">Gene-haplotype matrix</a></div>
	<h4>Novel Haplotypes</h4>
	
	<p>A novel haplotype occurs when the input variant list contains at least one snp for that gene, but there exists no known haplotype whose variants include all of the input variants for those snps.
	Also, novel haplotypes can be identified only if there is a maximum of one heterozygote variant in the variant list. 
	For example, if you have the following samples for the G6PD gene-haplotype matrix:
	</p>
	<table border="1" style="display: inline-block;">
		<caption>Sample 1</caption>
		<tr>
			<th>Location</th>
			<th>Variant</th>
		</tr>
		<tr>
			<td>rs1050828</td>
			<td>C</td>
		</tr>
		<tr>
			<td>rs1050829</td>
			<td>T</td>
		</tr>
		<tr>
			<td>rs5030868</td>
			<td>G</td>
		</tr>
	</table>
	<table border="1" style="display: inline-block;">
		<caption>Sample 2</caption>
		<tr>
			<th>Location</th>
			<th>Variant</th>
		</tr>
		<tr>
			<td>rs1050828</td>
			<td>C</td>
		</tr>
		<tr>
			<td>rs1050829</td>
			<td>T</td>
		</tr>
		<tr>
			<td>rs5030868</td>
			<td>T</td>
		</tr>
	</table>
	<table border="1" style="display: inline-block;">
		<caption>Sample 3</caption>
		<tr>
			<th>Location</th>
			<th>Variant</th>
		</tr>
		<tr>
			<td>rs1050828</td>
			<td>T</td>
		</tr>
		<tr>
			<td>rs1050829</td>
			<td>T</td>
		</tr>
		<tr>
			<td>rs5030868</td>
			<td>G</td>
		</tr>
	</table>
	<p>We would get haplotype "B (wildtype)" for Sample 1, and both Sample 2 and Sample 3 would be recorded as having novel haplotypes for the G6PD gene. 
	For Sample 2, we record it as novel since no such variant rs5030868 T occurs in any haplotype. 
	For Sample 3, we record it as novel since no such haplotype has the combination of variants rs1050828 T, rs1050829 T, and rs5030868 G.</p>
	<h3>Drug Recommendations</h3>
	<h4>Genotype Drug Recommendations</h4>
	<div>The drug recommendation is based off a gene and two haplotypes for that gene.</div>
	<h4>Phenotype Drug Recommendations</h4>
	<p>The drug recommendation is based off a gene and a phenotype.</p>
	<h4>Sample Drug Recommendation</h4>
	<div><a href="http://www.pharmgkb.org/gene/PA356">TPMT Gene Page</a></div>
	<img src="${resource(dir: 'images', file: 'drugrec.png')}" alt="drugRecommendation">
	
    </body>
</html>

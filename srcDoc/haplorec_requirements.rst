Haplorec Requirements
=====================

Implemented
***********

Disambiguating heterozygous variants
------------------------------------

**Status:**

*Implemented.*

**Problem:**

Given a set of heterozygous variants (rs1, rs2, …, rn) for a given gene, we can’t determine which 
physical chromosome each variant occurs on.

**Solution:**

If there exist 1-2 known haplotypes which contain alleles matching the observed heterozygote 
alleles, and in the case of 2 haplotypes, the alleles of the haplotypes are non-overlapping.

**NOTE:**

in the case of 1 haplotype, the remaining heterozygote variants might make up a novel haplotype or 
ambiguously map to multiple known haplotypes, then call those haplotypes.

**Examples:**


*Example 1.*

.. csv-table:: Observed Heterozygous Variants
    :header: SNP,Call

    Rs1,AT
    Rs2,AT
|
.. csv-table:: Gene-haplotype Matrix
    :header: Haplotype,Rs1,Rs2

    \*1,A,T
    \*2,T,A
Call \*1/\*2

*Example 2.*

.. csv-table:: Observed Heterozygous Variants
    :header: SNP,Call

    Rs1,AT
    Rs2,AT
|
.. csv-table:: Gene-haplotype Matrix
    :header: Haplotype,Rs1,Rs2

    \*1,A,T
    \*2,T,A
    \*3,A,A
    \*4,T,T
Call nothing

**Additions:**

Instead of calling nothing in example 2., call all possible haplotype combinations (\*1/\*2, \*3/\*4)

Don’t bother to call pairs of novel haplotypes (apparently they are very rare).


Not Implemented
***************

Referring to the same strand in gene-haplotype matrices and variants
--------------------------------------------------------------------

**Problem:**

Variants calls may refer to one strand (forward/reverse) of the physical chromosome, while the 
gene-haplotype matrices may refer to another.

**Solution:**

For each gene-haplotype matrix, determine which strand it refers to (forward/reverse) and record it 
in the database.  Require the user to provide the Assay Design File (from which we can determine the 
primers used).  For each SNP we are detecting query dbSNP to determine which strand we are detecting 
(using the SNP’s primers from the Assay Design File), taking the compliment of the input variant if 
its strand differs from the gene-haplotype matrix.

**Additions:**

The Assay Design File will never change, so just use a table (provided by Aaron) that identifies for 
each SNP whether the called variant refers to the reverse compliment or not, when compared to the 
gene-haplotype matrix.

Ambiguous haplotypes with unique drug recommendation
----------------------------------------------------

**Problem/Solution:**

Report drug recommendations for genes whose variants map ambiguously to many haplotypes, but all of 
those haplotypes have the same phenotype (and hence only 1 drug recommendation).


Ambiguous haplotypes
--------------------

**Problem/Solution:**

Report all possible genotypes in the presence of > 1 heterozygous variant (even after 
disambiguation).


Miscellaneous requirements
--------------------------

Recommendations based on a combination of SNP id’s and genotypes (e.g. VKORC1)

PharmGKB doesn’t use SNP id’s for some SNPs

Some SNP ids in the input variants have a trailing ‘A’; remove it

Special cases of how to map certain variant calls to their gene-haplotype-matrix representation:

.. csv-table:: 
    :header: Gene,SNP,Call in input,Meaning in matrix

    CYP2D6,Rs72549357,A,NO ins (hom)
    ,,AA,insA (hom)
    ,,AAA,insA / NO ins (het)


Control filtering
-----------------

**Problem/Solution:** 

If all the control samples (those with SAMPLE_ID = Blank, where consecutive Blank’s with the same 
SNP belong to different controls) are non-empty and refer to the same allele, filter out those SNPs 
from the non-control samples.

Variants that are filtered out should be visible to the user (not silently filtered).

**TODO:**

If the controls match for a SNP, but there exists a sample whose allele for that SNP doesn’t match, 
what should we do? (Aaron said he would need to speak to Swan)

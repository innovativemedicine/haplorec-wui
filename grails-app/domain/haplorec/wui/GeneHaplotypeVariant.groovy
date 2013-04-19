package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

class GeneHaplotypeVariant implements Serializable {

	String geneName
	String haplotypeName
	String snpId
	String allele

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append geneName
		builder.append haplotypeName
		builder.append snpId
		builder.append allele
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append geneName, other.geneName
		builder.append haplotypeName, other.haplotypeName
		builder.append snpId, other.snpId
		builder.append allele, other.allele
		builder.isEquals()
	}

	static mapping = {
		id composite: ["geneName", "haplotypeName", "snpId", "allele"]
		version false
	}

	static constraints = {
		geneName maxSize: 50
		haplotypeName maxSize: 50
		snpId maxSize: 50
		allele maxSize: 50
	}
}

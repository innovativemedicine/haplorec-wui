package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

class GenotypePhenotype implements Serializable {

	String geneName
	String haplotypeName1
	String haplotypeName2
	String phenotypeName

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append geneName
		builder.append haplotypeName1
		builder.append haplotypeName2
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append geneName, other.geneName
		builder.append haplotypeName1, other.haplotypeName1
		builder.append haplotypeName2, other.haplotypeName2
		builder.isEquals()
	}

	static mapping = {
		id composite: ["geneName", "haplotypeName1", "haplotypeName2"]
		version false
	}

	static constraints = {
		geneName maxSize: 50
		haplotypeName1 maxSize: 50
		haplotypeName2 maxSize: 50
		phenotypeName nullable: true, maxSize: 50
	}
}

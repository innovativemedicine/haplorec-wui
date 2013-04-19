package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

class GenotypeDrugRecommendation implements Serializable {

	String geneName
	String haplotypeName1
	String haplotypeName2
	DrugRecommendation drugRecommendation

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append geneName
		builder.append haplotypeName1
		builder.append haplotypeName2
		builder.append drugRecommendation?.id
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append geneName, other.geneName
		builder.append haplotypeName1, other.haplotypeName1
		builder.append haplotypeName2, other.haplotypeName2
		builder.append drugRecommendation?.id, other.drugRecommendation?.id
		builder.isEquals()
	}

	static belongsTo = [DrugRecommendation]

	static mapping = {
		id composite: ["geneName", "haplotypeName1", "haplotypeName2", "drugRecommendation"]
		version false
	}

	static constraints = {
		geneName maxSize: 50
		haplotypeName1 maxSize: 50
		haplotypeName2 maxSize: 50
	}
}

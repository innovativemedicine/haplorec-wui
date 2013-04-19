package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

class GenePhenotypeDrugRecommendation implements Serializable {

	String geneName
	String phenotypeName
	DrugRecommendation drugRecommendation

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append geneName
		builder.append phenotypeName
		builder.append drugRecommendation?.id
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append geneName, other.geneName
		builder.append phenotypeName, other.phenotypeName
		builder.append drugRecommendation?.id, other.drugRecommendation?.id
		builder.isEquals()
	}

	static belongsTo = [DrugRecommendation]

	static mapping = {
		id composite: ["geneName", "phenotypeName", "drugRecommendation"]
		version false
	}

	static constraints = {
		geneName maxSize: 50
		phenotypeName maxSize: 50
	}
}

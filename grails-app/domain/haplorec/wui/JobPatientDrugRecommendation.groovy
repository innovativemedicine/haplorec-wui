package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

class JobPatientDrugRecommendation implements Serializable {

	String patientId
	Job job
	DrugRecommendation drugRecommendation

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append job?.id
		builder.append patientId
		builder.append drugRecommendation?.id
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append job?.id, other.job?.id
		builder.append patientId, other.patientId
		builder.append drugRecommendation?.id, other.drugRecommendation?.id
		builder.isEquals()
	}

	static belongsTo = [Job]

	static mapping = {
		id composite: ["job", "patientId", "drugRecommendation"]
		version false
	}

	static constraints = {
		patientId maxSize: 50
	}
}

package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

class JobPatientGenotype implements Serializable {

	String patientId
	String geneName
	String haplotypeName1
	String haplotypeName2
	Job job

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append job?.id
		builder.append patientId
		builder.append geneName
		builder.append haplotypeName1
		builder.append haplotypeName2
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append job?.id, other.job?.id
		builder.append patientId, other.patientId
		builder.append geneName, other.geneName
		builder.append haplotypeName1, other.haplotypeName1
		builder.append haplotypeName2, other.haplotypeName2
		builder.isEquals()
	}

	static belongsTo = [Job]

	static mapping = {
		id composite: ["job", "patientId", "geneName", "haplotypeName1", "haplotypeName2"]
		version false
	}

	static constraints = {
		patientId nullable: true, maxSize: 50
		geneName nullable: true, maxSize: 50
		haplotypeName1 nullable: true, maxSize: 50
		haplotypeName2 nullable: true, maxSize: 50
	}
}

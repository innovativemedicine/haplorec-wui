package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

@Mixin(JobPatientDomainMixin)
class JobPatientGenePhenotype implements Serializable {

	String patientId
	String geneName
	String phenotypeName
	Job job

    static namedQueries = {
        forJob { jobId ->
            eq 'job.id', jobId
        }
    }

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append job?.id
		builder.append patientId
		builder.append geneName
		builder.append phenotypeName
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append job?.id, other.job?.id
		builder.append patientId, other.patientId
		builder.append geneName, other.geneName
		builder.append phenotypeName, other.phenotypeName
		builder.isEquals()
	}

	static belongsTo = [Job]

	static mapping = {
		id composite: ["job", "patientId", "geneName", "phenotypeName"]
		version false
	}

	static constraints = {
		patientId nullable: true, maxSize: 50
		geneName nullable: true, maxSize: 50
		phenotypeName nullable: true, maxSize: 50
	}
}

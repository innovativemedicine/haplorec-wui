package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

@Mixin(JobPatientDomainMixin)
class JobPatientGeneHaplotype implements Serializable {

	String patientId
	String geneName
	String haplotypeName
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
		builder.append haplotypeName
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append job?.id, other.job?.id
		builder.append patientId, other.patientId
		builder.append geneName, other.geneName
		builder.append haplotypeName, other.haplotypeName
		builder.isEquals()
	}

	static belongsTo = [Job]

	static mapping = {
		id composite: ["job", "patientId", "geneName", "haplotypeName"]
		version false
	}

	static constraints = {
		patientId nullable: true, maxSize: 50
		geneName nullable: true, maxSize: 50
		haplotypeName nullable: true, maxSize: 50
	}
}

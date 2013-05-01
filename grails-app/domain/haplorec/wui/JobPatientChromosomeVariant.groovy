package haplorec.wui

import org.apache.commons.lang.builder.EqualsBuilder
import org.apache.commons.lang.builder.HashCodeBuilder

@Mixin(JobPatientDomainMixin)
class JobPatientChromosomeVariant implements Serializable {

	String patientId
	String physicalChromosome
	String snpId
	String allele
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
		builder.append physicalChromosome
		builder.append snpId
		builder.append allele
		builder.toHashCode()
	}

	boolean equals(other) {
		if (other == null) return false
		def builder = new EqualsBuilder()
		builder.append job?.id, other.job?.id
		builder.append patientId, other.patientId
		builder.append physicalChromosome, other.physicalChromosome
		builder.append snpId, other.snpId
		builder.append allele, other.allele
		builder.isEquals()
	}

	static belongsTo = [Job]

	static mapping = {
		id composite: ["job", "patientId", "physicalChromosome", "snpId", "allele"]
		version false
	}

	static constraints = {
		patientId nullable: true, maxSize: 50
		physicalChromosome nullable: true, maxSize: 50
		snpId nullable: true, maxSize: 50
		allele nullable: true, maxSize: 50
	}
}

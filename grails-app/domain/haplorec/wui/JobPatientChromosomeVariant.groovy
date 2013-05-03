package haplorec.wui

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

	static belongsTo = [Job]

	static mapping = {
		version false
	}

	static constraints = {
		patientId nullable: true, maxSize: 50
		physicalChromosome nullable: true, maxSize: 50
		snpId nullable: true, maxSize: 50
		allele nullable: true, maxSize: 50
	}
}

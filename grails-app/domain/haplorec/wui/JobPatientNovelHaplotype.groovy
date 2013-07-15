package haplorec.wui

@Mixin(JobPatientDomainMixin)
class JobPatientNovelHaplotype implements Serializable {

	String patientId
	String physicalChromosome
	String geneName
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
		geneName nullable: true, maxSize: 50
	}
}

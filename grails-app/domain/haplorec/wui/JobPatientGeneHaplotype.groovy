package haplorec.wui

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

	static belongsTo = [Job]

	static mapping = {
		version false
	}

	static constraints = {
		patientId nullable: true, maxSize: 50
		geneName nullable: true, maxSize: 50
		haplotypeName nullable: true, maxSize: 50
	}
}

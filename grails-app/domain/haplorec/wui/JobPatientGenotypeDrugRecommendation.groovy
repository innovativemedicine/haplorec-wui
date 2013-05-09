package haplorec.wui

class JobPatientGenotypeDrugRecommendation implements Serializable {

	String patientId
	Job job
	DrugRecommendation drugRecommendation

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
		patientId maxSize: 50
	}
}

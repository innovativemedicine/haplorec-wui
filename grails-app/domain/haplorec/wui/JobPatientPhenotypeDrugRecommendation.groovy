package haplorec.wui

class JobPatientPhenotypeDrugRecommendation implements Serializable {

	String patientId
    Integer hetCombo
    Integer hetCombos
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
        hetCombo nullable: true
        hetCombos nullable: true
	}
}

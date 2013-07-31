package haplorec.wui

@Mixin(JobPatientDomainMixin)
class JobPatientGenePhenotype implements Serializable {

	String patientId
    Integer hetCombo
    Integer hetCombos
	String geneName
	String phenotypeName
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
        hetCombo nullable: true
        hetCombos nullable: true
		geneName nullable: true, maxSize: 50
		phenotypeName nullable: true, maxSize: 50
	}
}

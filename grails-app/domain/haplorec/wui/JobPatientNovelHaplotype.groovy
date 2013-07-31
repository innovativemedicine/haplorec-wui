package haplorec.wui

@Mixin(JobPatientDomainMixin)
class JobPatientNovelHaplotype implements Serializable {

	String patientId
    Integer hetCombo
    Integer hetCombos
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
        hetCombo nullable: true
        hetCombos nullable: true
		physicalChromosome nullable: true, maxSize: 50
		geneName nullable: true, maxSize: 50
	}
}

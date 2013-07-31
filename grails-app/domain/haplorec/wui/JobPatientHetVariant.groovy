package haplorec.wui

@Mixin(JobPatientDomainMixin)
class JobPatientHetVariant implements Serializable {

	String patientId
    Integer hetCombo
    Integer hetCombos
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
        hetCombo nullable: true
        hetCombos nullable: true
		physicalChromosome nullable: true, maxSize: 50
		snpId nullable: true, maxSize: 50
		allele nullable: true, maxSize: 50
	}
}

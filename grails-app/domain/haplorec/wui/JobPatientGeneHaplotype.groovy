package haplorec.wui

@Mixin(JobPatientDomainMixin)
class JobPatientGeneHaplotype implements Serializable {

	String patientId
    Integer hetCombo
    Integer hetCombos
	String physicalChromosome
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
        hetCombo nullable: true
        hetCombos nullable: true
		physicalChromosome nullable: true, maxSize: 50
		geneName nullable: true, maxSize: 50
		haplotypeName nullable: true, maxSize: 50
	}
}

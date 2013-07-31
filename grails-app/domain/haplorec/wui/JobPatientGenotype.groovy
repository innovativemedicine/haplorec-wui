package haplorec.wui

@Mixin(JobPatientDomainMixin)
class JobPatientGenotype implements Serializable {

	String patientId
    Integer hetCombo
    Integer hetCombos
	String geneName
	String haplotypeName1
	String haplotypeName2
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
		haplotypeName1 nullable: true, maxSize: 50
		haplotypeName2 nullable: true, maxSize: 50
	}
}

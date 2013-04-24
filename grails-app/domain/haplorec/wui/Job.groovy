package haplorec.wui

class Job {

	String jobName

	static hasMany = [jobPatientChromosomeVariants: JobPatientChromosomeVariant,
	                  jobPatientDrugRecommendations: JobPatientDrugRecommendation,
	                  jobPatientGeneHaplotypes: JobPatientGeneHaplotype,
	                  jobPatientGenePhenotypes: JobPatientGenePhenotype,
	                  jobPatientGenotypes: JobPatientGenotype,
	                  jobPatientVariants: JobPatientVariant]

	static mapping = {
		version false
	}

	static constraints = {
		jobName nullable: true, maxSize: 50
	}
}
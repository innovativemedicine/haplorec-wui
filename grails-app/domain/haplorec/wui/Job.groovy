package haplorec.wui

class Job {

	String jobName

	static hasMany = [jobPatientChromosomeVariants: JobPatientChromosomeVariant,
	                  jobPatientGenotypeDrugRecommendations: JobPatientGenotypeDrugRecommendation,
	                  jobPatientPhenotypeDrugRecommendations: JobPatientPhenotypeDrugRecommendation,
	                  jobPatientGeneHaplotypes: JobPatientGeneHaplotype,
	                  jobPatientGenePhenotypes: JobPatientGenePhenotype,
	                  jobPatientGenotypes: JobPatientGenotype,
	                  jobPatientVariants: JobPatientVariant]

	static mapping = {
		version false
	}

	static constraints = {
		jobName blank: false, unique: true, nullable: false, maxSize: 50
	}
}

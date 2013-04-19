package haplorec.wui

class DrugRecommendation {

	String drugName
	String implications
	String recommendation
	String classification
	String diplotypeEgs

	static hasMany = [genePhenotypeDrugRecommendations: GenePhenotypeDrugRecommendation,
	                  genotypeDrugRecommendations: GenotypeDrugRecommendation]

	static mapping = {
		version false
	}

	static constraints = {
		drugName nullable: true, maxSize: 50
		implications nullable: true, maxSize: 50
		recommendation nullable: true, maxSize: 50
		classification nullable: true, maxSize: 50
		diplotypeEgs nullable: true, maxSize: 50
	}
}

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
		implications type: 'text'
		recommendation type: 'text'
		classification type: 'text'
		diplotypeEgs type: 'text'
	}

	static constraints = {
		drugName nullable: true, maxSize: 50
	}
}

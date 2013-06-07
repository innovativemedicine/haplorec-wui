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
	
	def shortener(arg) {
	    if (arg == null) {
			return null
		}
		def n = Math.min(100, arg.length())
		if (arg.length() > 100) {
			return arg.substring(0,n) + "..."
		}
		else {
			return arg.substring(0,n)
		}
	}
	
	def imp_shortener() {
		return shortener(this.implications)
	}
		
	def rec_shortener() {
		return shortener(this.recommendation)	
	}
}


 
		 
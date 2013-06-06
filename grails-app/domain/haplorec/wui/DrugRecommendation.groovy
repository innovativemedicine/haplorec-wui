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
	def imp_shortener(){
		def n=Math.min(100,this.implications.length());
		if (this.implications.length()>100){
			return this.implications.substring(0,n)+"...";
		}
		else{
			return this.implications.substring(0,n);}
	}
		
	def rec_shortener(){
		def n=Math.min(100,this.recommendation.length());
		if (this.recommendation.length()>100){
			return this.recommendation.substring(0,n)+"...";
		}
		else{
			return this.recommendation.substring(0,n);}
		
	}
}


 
		 
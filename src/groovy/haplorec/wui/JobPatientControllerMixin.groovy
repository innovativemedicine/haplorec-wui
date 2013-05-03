package haplorec.wui

class JobPatientControllerMixin {
    def jobPatientList(Class domainClass, Integer max, Long jobId) {
		def model = jobPatientListModel(domainClass, max, jobId)
		model
    }

	def jobPatientListTemplate(Class domainClass, Integer max, Long jobId) {
		def model = jobPatientListModel(domainClass, max, jobId)
		def domain = (domainClass.name =~ /\.?(\w+)$/)[0][1]
		def domainLower = domain.replaceAll(/^\w/, { it.toLowerCase() })
		render(template: "/${domainLower}/list", model: model)
	}

	private def jobPatientListModel = { Class domainClass, Integer max, Long jobId ->
		log.error("PARAMS == $params")
		params.max = Math.min(max ?: 10, 100)
		// strip the package name if there is any
		def domain = (domainClass.name =~ /\.?(\w+)$/)[0][1]
		def domainLower = domain.replaceAll(/^\w/, { it.toLowerCase() })
		def domainInstance = "${domainLower}Instance"
		def junk = domainClass.forJob(jobId)
		def l
		def c
		if (jobId != null) {
            def result = domainClass.forJob(jobId)
			l = domainClass.forJob(jobId).list(params)
            c = domainClass.forJob(jobId).count()
		} else {
			l = domainClass.list(params)
            c = domainClass.count()
		}
		def model = [
			jobId: jobId,
			( "${domainInstance}List".toString() ) : l,
			( "${domainInstance}Total".toString() ) : c,
		]
		log.error("MODEL == $model")
		return model
	}
	
}

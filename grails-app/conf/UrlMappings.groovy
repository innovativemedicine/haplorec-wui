class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/" {
			controller = "pipelineJob"
			action = "main"
		}
		
		"500"(view:'/error')
	}
}

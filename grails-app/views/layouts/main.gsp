<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<r:require modules="application"/>
		<g:layoutHead/>
		<r:layoutResources />
        <link rel="icon" type="image/ico" href="${resource(dir: 'images', file: 'favicon.ico')}"/>
	</head>	
	<body>
		<div class="container">

		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<a class="brand" href="${resource()}">Haplorec</a>
				<ul class="nav">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">Jobs<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<form id="job-search" class="navbar-search pull-left">
								<div class="input-prepend">
									<input type="text" class="search-query" placeholder="Search">
								</div>
							</form>
							<li><a href="${createLink(action: 'create', controller: 'pipelineJob')}">New Job</a></li>
							<li><a href="${createLink(action: 'list', controller: 'pipelineJob')}">List</a></li>
						</ul>
					</li>
				</ul>
				<!-- this is a hack...yup -->
				<div class="spinner-container pull-right" style="width: 3em; height: 3em;"></div>
			</div>
		</div>
		
		<r:script>
		$.get('http://localhost:8080/haplorec-wui/pipelineJob/jsonList',
            function(data) {
                var y = new Array(data.length);
                for(var i=0;i< data.length;i++){
                    y[i]=data[i].jobName;
                }
                $('input.search-query').typeahead({
                    source:y,
                    updater: function(item) {
                        for (var i=0; i< data.length; i++) {
                            if (data[i].jobName == item) {
                                var n = data[i].id;
                                var m = "/"+ n.toString();
                                window.location.replace("${createLink(action: 'show', controller: 'pipelineJob')}"+m);
                            }
                        }
                    }
                });
            }
        );
		$("#job-search").submit(function() {
            event.preventDefault();
        });
			
		</r:script>

		<g:layoutBody/>
		
		</div>
		<g:javascript library="application"/>
		<r:layoutResources />
		
	</body>
</html>


<%@ page import="haplorec.wui.JobPatientHetVariant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <%--
		<a href="#list-jobPatientHetVariant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
        --%>
		<div id="list-jobPatientHetVariant" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="patientId" title="${message(code: 'jobPatientHetVariant.patientId.label', default: 'Patient Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="physicalChromosome" title="${message(code: 'jobPatientHetVariant.physicalChromosome.label', default: 'Physical Chromosome')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="hetCombo" title="${message(code: 'jobPatientHetVariant.hetCombo.label', default: 'Het Combo')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="snpId" title="${message(code: 'jobPatientHetVariant.snpId.label', default: 'Snp Id')}" params="[jobId:jobId]"/>
					
						<g:sortableColumn property="allele" title="${message(code: 'jobPatientHetVariant.allele.label', default: 'Allele')}" params="[jobId:jobId]"/>

                        <g:if test="${jobId == null}">
						<th><g:message code="jobPatientGenePhenotype.job.label" default="Job" /></th>
                        </g:if>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jobPatientHetVariantInstanceList}" status="i" var="jobPatientHetVariantInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jobPatientHetVariantInstance.id}">${fieldValue(bean: jobPatientHetVariantInstance, field: "patientId")}</g:link></td>
					
						<td>${fieldValue(bean: jobPatientHetVariantInstance, field: "physicalChromosome")}</td>
					
						<td>${fieldValue(bean: jobPatientHetVariantInstance, field: "hetCombo") ?: 1} / ${fieldValue(bean: jobPatientHetVariantInstance, field: "hetCombos") ?: 1}</td>
					
						<td>${fieldValue(bean: jobPatientHetVariantInstance, field: "snpId")}</td>
					
						<td>${fieldValue(bean: jobPatientHetVariantInstance, field: "allele")}</td>

                        <g:if test="${jobId == null}">
						<td>${fieldValue(bean: jobPatientVariantInstance, field: "job")}</td>
                        </g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jobPatientHetVariantInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

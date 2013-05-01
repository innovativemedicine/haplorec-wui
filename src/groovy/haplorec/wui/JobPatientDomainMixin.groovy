package haplorec.wui

class JobPatientDomainMixin {
    static namedQueries = {
        forJob { jobId ->
            eq 'job.id', jobId
        }
    }
}

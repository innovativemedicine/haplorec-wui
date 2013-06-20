package haplorec.wui

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class JobState {

	Job job
	String target
	String state

    static namedQueries = {
        forJob { jobId ->
            eq 'job.id', jobId
        }
        jobTarget { jobId, target ->
            eq 'job.id', jobId
            eq 'target', target
        }
    }

	static belongsTo = [Job]

	static mapping = {
		version false
		cache false
	}

}

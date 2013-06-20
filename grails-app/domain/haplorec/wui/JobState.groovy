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
    }

	static belongsTo = [Job]

	static mapping = {
		version false
		cache false
	}

}

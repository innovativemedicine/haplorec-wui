-- Add tables specific to haplorec-wui that are added to the haplorec database 
-- (i.e. this schema is to be run after haplorec.sql from the haplorec project)

-- Table used for tracking the state of pipeline jobs.  If a target not in this table, then it is 
-- (implicitly) in a 'not yet running' state. 
CREATE TABLE job_state (
	id bigint not null auto_increment,
    job_id bigint not null,
    target varchar(200) not null,
    -- The possible states a job's target can be in.
    -- running: the target has begun / is in the middle of processing
    -- done: the target has finished processing
    -- failed: during processing, an error occured (e.g. an Exception was thrown)
    state enum('running', 'done', 'failed') not null,
    foreign key (job_id) references job(id),
    unique (job_id, target),
    primary key (id)
) ENGINE=InnoDB;

-- Add tables specific to haplorec-wui that are added to the haplorec database 
-- (i.e. this schema is to be run after haplorec.sql from the haplorec project)

-- Table used for tracking the state of pipeline jobs.  If a target not in this table, then it is 
-- (implicitly) in a 'not yet running' state. 
CREATE TABLE job_state (
    job_id bigint not null,
    target varchar(200) not null,
    state enum('running', 'done', 'failed') not null,
    foreign key (job_id) references job(id),
    primary key (job_id, target)
) ENGINE=InnoDB;

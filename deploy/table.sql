CREATE TABLE IF NOT EXISTS s3bench (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	op  VARCHAR(128) NOT NULL, 
	host  DECIMAL NOT NULL, 
	duration_s VARCHAR(128) NOT NULL, 
	objects_per_op VARCHAR(128) NOT NULL, 
	bytes DECIMAL NOT NULL, 
	full_ops DECIMAL NOT NULL, 
	partial_ops DECIMAL NOT NULL, 
	ops_started DECIMAL NOT NULL, 
	ops_ended DECIMAL NOT NULL, 
	errors DECIMAL NOT NULL, 
	mb_per_sec DECIMAL NOT NULL, 
	ops_ended_per_sec DECIMAL NOT NULL, 
	objs_per_sec DECIMAL NOT NULL, 
	reqs_ended_avg_ms DECIMAL NOT NULL, 
	start_time VARCHAR(128) NOT NULL, 
	end_time VARCHAR(128) NOT NULL
);

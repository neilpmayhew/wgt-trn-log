CREATE TABLE IF NOT EXISTS muscle_group(
  muscle_group_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  muscle_group_name varchar(50) NOT NULL,
  CONSTRAINT muscle_group_name_unique UNIQUE(muscle_group_name)
);

CREATE TABLE IF NOT EXISTS equipment_type(
  equipment_type_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  equipment_type_name varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS exercise(
  exercise_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  exercise_name varchar(100) NOT NULL,
  equipment_type_id INT NOT NULL,
  FOREIGN KEY (equipment_type_id) REFERENCES equipment_type(equipment_type_id)
);
CREATE SCHEMA IF NOT EXISTS log;
CREATE TABLE IF NOT EXISTS log.session(
  log_session_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_session_start timestamp NOT NULL,
  log_session_end timestamp NOT NULL
);
CREATE TABLE IF NOT EXISTS log.set(
  log_set_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_start timestamp NOT NULL,
  log_set_end timestamp NOT NULL,
  log_session_id int NOT NULL,
  FOREIGN KEY (log_session_id) REFERENCES log.session(log_session_id),
  exercise_id int NOT NULL,
  FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id),
  weight_in_kg int NOT NULL,
  reps int NOT NULL
);
CREATE TABLE IF NOT EXISTS log.set_reps_in_reserve(
  set_reps_in_reserve_id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int NOT NULL NOT NULL,
  FOREIGN KEY (log_set_id) REFERENCES log.set(log_set_id),
  reps_in_reserve smallint NOT NULL
); 
CREATE TABLE IF NOT EXISTS log.set_notes(
  set_notes_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int NOT NULL,
  FOREIGN KEY (log_set_id) REFERENCES log.set(log_set_id),
  notes TEXT NOT NULL
); 

CREATE SCHEMA IF NOT EXISTS plan;

CREATE TABLE IF NOT EXISTS plan.program(
  plan_program_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_program_name VARCHAR(100) NOT NULL,
  plan_program_major_version smallint,
  plan_program_minor_version smallint,
  plan_program_revision smallint,
  CONSTRAINT plan_program_unique_version UNIQUE(plan_program_name,plan_program_major_version,plan_program_minor_version,plan_program_revision)
);
CREATE TABLE IF NOT EXISTS plan.session(
  plan_session_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_program_id int NOT NULL,
  FOREIGN KEY (plan_program_id) REFERENCES plan.program(plan_program_id),
  plan_session_name VARCHAR(100) NOT NULL,
  CONSTRAINT plan_session_unique_name UNIQUE(plan_session_name),
  plan_program_ordinal smallint NOT NULL
  CONSTRAINT plan_session_unique_ordinal UNIQUE(plan_program_id,plan_program_ordinal),
);
CREATE TABLE IF NOT EXISTS plan.set_reps_in_reserve_goal(
  set_reps_in_reserve_goal_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (plan_session_id) REFERENCES plan.session(plan_session_id),
  reps_min smallint NOT NULL,
  reps_max smallint NOT NULL,
  set_reps_in_reserve_goal smallint NOT NULL
);

CREATE TABLE IF NOT EXISTS muscle_group(
  muscle_group_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  muscle_group_name varchar(50)
);
CREATE TABLE IF NOT EXISTS exercise(
  exercise_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  exercise_name varchar(100) NOT NULL,
  exercise_type varchar(100) NOT NULL,
  CONSTRAINT valid_exercise_type CHECK (exercise_type IN ('Barbell','Dumbell','Cable'))
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
  repetitions int NOT NULL
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

CREATE TABLE IF NOT EXISTS plan.session(
  plan_session_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_session_name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS plan.set(
  plan_set_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_session_id int NOT NULL, 
  FOREIGN KEY (plan_session_id) REFERENCES plan.session(plan_session_id),
  plan_set_ordinal smallint NOT NULL,
  exercise_id int NOT NULL,
  weight_in_kg int NOT NULL,
  repetitions int NOT NULL
);

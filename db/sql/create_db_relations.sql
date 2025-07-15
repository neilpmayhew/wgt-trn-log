CREATE TABLE IF NOT EXISTS muscle_group(
  muscle_group_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  muscle_group_name varchar(50) NOT NULL,
  CONSTRAINT muscle_group_name_unique UNIQUE(muscle_group_name)
);

CREATE TABLE IF NOT EXISTS exercise(
  exercise_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  exercise_name varchar(100) NOT NULL
);
CREATE SCHEMA IF NOT EXISTS log;
CREATE TABLE IF NOT EXISTS log.session(
  log_session_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_session_start timestamp NOT NULL,
  log_session_end timestamp NOT NULL
);
CREATE TABLE IF NOT EXISTS log.set(
  log_set_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_start timestamp NOT NULL,
  log_set_end timestamp NOT NULL,
  log_session_id smallint NOT NULL,
  FOREIGN KEY (log_session_id) REFERENCES log.session(log_session_id),
  exercise_id smallint NOT NULL,
  FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id),
  weight_in_kg smallint NOT NULL,
  reps smallint NOT NULL,
  CONSTRAINT chk_reps_range CHECK(rir BETWEEN 1 AND 50),
  rir smallint NULL,
  CONSTRAINT chk_rir_range CHECK(coalesce(rir,0) BETWEEN 0 AND 6),
  notes text DEFAULT ''
);

CREATE SCHEMA IF NOT EXISTS plan;

CREATE TABLE IF NOT EXISTS plan.program(
  plan_program_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_program_name VARCHAR(100) NOT NULL,
  plan_program_major_version smallint,
  plan_program_minor_version smallint,
  plan_program_revision smallint,
  CONSTRAINT plan_program_unique_version UNIQUE(plan_program_name,plan_program_major_version,plan_program_minor_version,plan_program_revision)
);
CREATE TABLE IF NOT EXISTS plan.session(
  plan_session_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_program_id smallint NOT NULL,
  FOREIGN KEY (plan_program_id) REFERENCES plan.program(plan_program_id),
  plan_session_name VARCHAR(100) NOT NULL,
  CONSTRAINT plan_session_unique_name UNIQUE(plan_session_name),
  plan_program_ordinal smallint NOT NULL,
  CONSTRAINT plan_session_unique_ordinal UNIQUE(plan_program_id,plan_program_ordinal)
);
CREATE TABLE IF NOT EXISTS plan.set_reps_in_reserve_goal(
  set_reps_in_reserve_goal_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  reps_min smallint NOT NULL,
  reps_max smallint NOT NULL,
  set_reps_in_reserve_goal smallint NOT NULL
);
CREATE TABLE IF NOT EXISTS plan.session_slot(
  plan_session_slot_id smallint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  exercise_id smallint NOT NULL,
  FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id),
  set_reps_in_reserve_goal_id smallint NOT NULL,
  FOREIGN KEY (set_reps_in_reserve_goal_id) REFERENCES plan.set_reps_in_reserve_goal(set_reps_in_reserve_goal_id)
);

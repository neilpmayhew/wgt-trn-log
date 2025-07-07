CREATE TABLE muscle_group(
  muscle_group_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  muscle_group_name varchar(50)
);
CREATE TABLE user(
  user_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_first_name varchar(100),
  user_last_name varchar(100)
);
CREATE TABLE exercise(
  exercise_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  exercise_name varchar(100),
);
CREATE SCHEMA log;
CREATE TABLE log.session(
  log_session_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_session_start datetime,
  log_session_end datetime,
  user_id FOREIGN KEY REFERENCES user(user_id)
);
CREATE TABLE log.set(
  log_set_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_start datetime,
  log_set_end datetime,
  log_session_id int FOREIGN KEY REFERENCES log.session(log_session_id),
  exercise_id int FOREIGN KEY REFERENCES exercise(exercise_id),
  weight_in_kg int,
  repetitions int
);
CREATE TABLE log.set_reps_in_reserve(
  set_reps_in_reserve_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int FOREIGN KEY REFERENCES log.set(log_set_id),
  reps_in_reserve tinyint NOT NULL
); 
CREATE TABLE log.set_pump(
  set_pump_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int FOREIGN KEY REFERENCES log.set(log_set_id),
  pump tinyint NOT NULL
); 
CREATE TABLE log.set_tension(
  set_tension_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int FOREIGN KEY REFERENCES log.set(log_set_id),
  tension tinyint NOT NULL
); 
CREATE TABLE log.set_mind_muscle_connection(
  set_mind_muscle_connection_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int FOREIGN KEY REFERENCES log.set(log_set_id),
  mind_muscle_connection tinyint NOT NULL
); 
CREATE TABLE log.set_notes(
  set_notes_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_id int FOREIGN KEY REFERENCES log.set(log_set_id),
  notes VARCHAR(MAX) NOT NULL
); 

CREATE SCHEMA plan;

CREATE TABLE plan.mesocycle_goal(
  mesocycle_goal_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  mesocycle_goal_name VARCHAR(100) NOT NULL,
  mesocycle_goal_description VARCHAR(MAX) NOT NULL,
);
CREATE TABLE plan.mesocycle(
  mesocycle_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  mesocycle_goal_id int FOREIGN KEY REFERENCES plan.mesocycle_goal(mesocycle_goal_id)
);
CREATE TABLE plan.microcycle_goal(
  microcycle_goal_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  microcycle_goal VARCHAR(500) NOT NULL
);
CREATE TABLE plan.microcycle(
  microcycle_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  mesocycle_id int FOREIGN KEY REFERENCES plan.mesocycle(mesocycle_id),
  mesocycle_ordinal tinyint NOT NULL,
  microcycle_goal_id FOREIGN KEY REFERENCES plan.microcycle_goal(microcycle_goal_id)
);

CREATE TABLE plan.session(
  plan_session_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_session_date DATE NOT NULL
)
CREATE TABLE plan.set(
  plan_set_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  plan_session_id int FOREIGN KEY REFERENCES plan.session(plan_session_id),
  plan_set_ordinal tinyint,
  exercise_id int,
  weight_in_kg int,
  repetitions int
);

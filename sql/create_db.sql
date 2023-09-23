CREATE TABLE muscle(
  muscle_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  muscle_name string
);
CREATE TABLE user(
  user_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_first_name string,
  user_last_name string
);
CREATE TABLE exercise(
  exercise_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  exercise_name string,
  primary_muscle_id int FOREIGN KEY REFERENCES muscle(muscle_id)
);
CREATE SCHEMA log;
CREATE TABLE log.session(
  session_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  session_date datetime,
  user_id FOREIGN KEY REFERENCES user(user_id)
);
CREATE TABLE log.set(
  log_set_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  log_set_ordinal tinyint,
  session_id int fk,
  exercise_id int,
  weight_in_kg int,
  repetitions int
);
CREATE TABLE log.set_review(
  set_review_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  set_id int fk,
  pump tinyint,
  tension tinyint,
  mind_muscle_connection tinyint,
  notes VARCHAR(MAX)
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
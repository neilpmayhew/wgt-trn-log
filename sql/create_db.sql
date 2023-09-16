CREATE TABLE muscle(
  muscle_id INT GENERATED ALWAYS AS IDENTITY
, muscle_name string
);

CREATE TABLE exercise(
  exercise_id INT GENERATED ALWAYS AS IDENTITY
, exercise_name string
, primary_muscle_id int
)

CREATE SCHEMA plan;

CREATE TABLE plan.program(
  program_id int GENERATED ALWAYS AS IDENTITY
, program_name varchar(500)
);

CREATE SCHEMA log;

CREATE TABLE log.session(
  session_id int GENERATED ALWAYS AS IDENTITY
, session_date datetime
);

CREATE TABLE log.session_exercise(
  session_exercise_id GENERATED ALWAYS AS IDENTITY
)

CREATE TABLE log.set(
  set_id int GENERATED ALWAYS AS IDENTITY
, set_ordinal tinyint
, session_id int fk
, exercise_id int
, weight_in_kg int
, repetitions int
);

CREATE TABLE log.set_review(
  set_review_id int GENERATED ALWAYS AS IDENTITY
,  set_id int fk
,  pump tinyint
,  tension tinyint
,  mind_muscle_connection tinyint
) 
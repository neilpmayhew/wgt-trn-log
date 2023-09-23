INSERT log.session(session_date, user_id)
VALUES(current_date(), 1)


INSERT log.set(
  set_ordinal
, session_id
, exercise_id
, weight_in_kg
, repetitions
)
VALUES
    (1
    ,1
    ,1
    ,100
    ,12)
    ,(2
    ,1
    ,1
    ,100
    ,10);
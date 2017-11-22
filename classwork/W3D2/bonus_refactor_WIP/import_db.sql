DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  question_id INTEGER NOT NULL,
  reply_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- seeding the database
INSERT INTO
  users (fname, lname)
VALUES
  ('Aaron', 'Agarunov'),
  ('David', 'Cha'),
  ('App', 'Academy');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Food', 'Do you hate pizza?', (SELECT id FROM users WHERE fname = 'Aaron')),
  ('Cars', 'Do you drive a Benz?', (SELECT id FROM users WHERE fname = 'David')),
  ('AppAcademy', 'Are you failing?', (SELECT id FROM users WHERE fname = 'App')),
  ('More Food', 'Do you hate pineapple?', (SELECT id FROM users WHERE fname = 'Aaron'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 2),
  (2, 1),
  (2, 2),
  (1, 3),
  (2, 3),
  (3, 3);

INSERT INTO
  replies (body, question_id, reply_id, user_id)
VALUES
  ('No I like pizza.', 1, NULL, 2),
  ('No I drive Mazzeratti.', 2, NULL, 1),
  ('WOW! That'' a nice car!', 2, 2, 2),
  ('No I''m better than you.', 3, NULL, 1), -- q_id 4
  ('No??????', 3, NULL, 2), -- q_id 5
  ('Better than who?', 3, 4, 3),
  ('Yes??????', 3, 5, 3);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 2),
  (2, 2),
  (2, 1),
  (1, 3),
  (2, 3),
  (3, 3);

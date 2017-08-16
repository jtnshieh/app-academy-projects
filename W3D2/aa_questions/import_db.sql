DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
  is_instructor INTEGER
);

DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER NOT NULL PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);




INSERT INTO
  users(fname, lname, is_instructor)
VALUES
  ('Justin', 'Shieh', 1),
  ('Andres', 'Alfaro', 0);


INSERT INTO
  questions(title, body, user_id)
VALUES
  ('dummy question','dummy body', (SELECT id FROM users WHERE fname = 'Justin')),
  ('andres quest','for knowledge', (SELECT id FROM users WHERE fname = 'Andres'));


INSERT INTO
  question_follows(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'dummy question'), (SELECT id FROM users WHERE fname = 'Justin')),
  ((SELECT id FROM questions WHERE title = 'dummy question'), (SELECT id FROM users WHERE fname = 'Andres')),
  ((SELECT id FROM questions WHERE title = 'andres quest'), (SELECT id FROM users WHERE fname = 'Andres'));


INSERT INTO
  question_likes(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'dummy question'), (SELECT id FROM users WHERE fname = 'Justin')),
  ((SELECT id FROM questions WHERE title = 'dummy question'), (SELECT id FROM users WHERE fname = 'Andres'));

INSERT INTO
  replies(body, question_id, user_id, parent_id)
VALUES
  ('dummy body 2', (SELECT id FROM questions WHERE title = 'dummy question'), (SELECT id FROM users WHERE fname = 'Justin'), NULL),
  ('dummy body 3', (SELECT id FROM questions WHERE title = 'dummy question'), (SELECT id FROM users WHERE fname = 'Andres'), 1);

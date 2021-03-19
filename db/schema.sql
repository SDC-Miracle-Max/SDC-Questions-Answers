DROP TABLE IF EXISTS answer_photos;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  body VARCHAR(500) NOT NULL,
  date_written DATE,
  asker_name VARCHAR(50) NOT NULL,
  asker_email VARCHAR(50) NOT NULL,
  reported BOOLEAN NOT NULL,
  helpful INT NOT NULL
);

COPY questions
FROM '/Users/chrisholley/hackReactor/SDC-Questions-Answers/questions.csv'
DELIMITER ','
CSV Header;

CREATE TABLE answers (
  id SERIAL PRIMARY KEY,
  question_id INT NOT NULL,
  body VARCHAR(500) NOT NULL,
  date_created DATE,
  answerer_name VARCHAR(50) NOT NULL,
  answerer_email VARCHAR(50) NOT NULL,
  reported BOOLEAN NOT NULL,
  helpful INT NOT NULL,
  FOREIGN KEY(question_id)
    REFERENCES questions (id)
);

COPY answers
FROM '/Users/chrisholley/hackReactor/SDC-Questions-Answers/answers.csv'
DELIMITER ','
CSV Header;

CREATE TABLE answer_photos (
  id SERIAL PRIMARY KEY,
  answer_id INT NOT NULL,
  "url" VARCHAR(300) NOT NULL,
  FOREIGN KEY(answer_id)
    REFERENCES answers (id)
);

COPY answer_photos
FROM '/Users/chrisholley/hackReactor/SDC-Questions-Answers/answers_photos.csv'
DELIMITER ','
CSV Header;

CREATE INDEX answers_question_id ON answers (question_id);
CREATE INDEX answers_photos_id ON answer_photos (answer_id);



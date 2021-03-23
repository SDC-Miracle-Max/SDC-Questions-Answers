DROP TABLE IF EXISTS answer_photos;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  question_id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  question_body VARCHAR(500) NOT NULL,
  question_date DATE,
  asker_name VARCHAR(50) NOT NULL,
  asker_email VARCHAR(50) NOT NULL,
  question_reported BOOLEAN NOT NULL,
  question_helpful INT NOT NULL
);

COPY questions
FROM '/Users/chrisholley/hackReactor/SDC-Questions-Answers/questions.csv'
DELIMITER ','
CSV Header;

CREATE TABLE answers (
  answer_id SERIAL PRIMARY KEY,
  question_id INT NOT NULL,
  answer_body VARCHAR(500) NOT NULL,
  answer_date DATE,
  answerer_name VARCHAR(50) NOT NULL,
  answerer_email VARCHAR(50) NOT NULL,
  answer_reported BOOLEAN NOT NULL,
  answer_helpful INT NOT NULL,
  FOREIGN KEY(question_id)
    REFERENCES questions (question_id)
);

COPY answers
FROM '/Users/chrisholley/hackReactor/SDC-Questions-Answers/answers.csv'
DELIMITER ','
CSV Header;

CREATE TABLE answer_photos (
  answer_photos_id SERIAL PRIMARY KEY,
  answer_id INT NOT NULL,
  "url" VARCHAR(300) NOT NULL,
  FOREIGN KEY(answer_id)
    REFERENCES answers (answer_id)
);

COPY answer_photos
FROM '/Users/chrisholley/hackReactor/SDC-Questions-Answers/answers_photos.csv'
DELIMITER ','
CSV Header;

CREATE INDEX questionsT_product_id_idx ON questions (product_id);
CREATE INDEX answersT_question_id_idx ON answers (question_id);
CREATE INDEX answerphotosT_answer_id_idx ON answer_photos (answer_id);

-- GRANT ALL ON questions TO root;
-- GRANT ALL ON answers TO root;
-- GRANT ALL ON answer_photos TO root;

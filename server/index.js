const express = require('express')
const pool = require('../db/config.js')
const app = express()
const port = 3000

app.use(express.json());

app.get('/empty/endpoint', (req, res) => {
  res.send('hello!');
  res.sendStatus(200);
})

app.get('/qa/questions', (req, res) => {
  const pId = req.query.product_id;

  pool.query(`
    SELECT * FROM questions WHERE product_id = $1;
  `, [pId])
    .then((questions) => {
      res.send(questions.rows)
    })
    .catch((err) => {
      res.send(400)
      throw err;
    })
})


// //Questions List (do not include reported Qs)
// app.get('/qa/questions', (req, res) => {
//   //don't forget to handle params: product_id, page, count
//   const pId = req.query.product_id;
//   pool.query(`
//     SELECT * FROM questions LEFT JOIN
//       answers ON questions.question_id = answers.question_id LEFT JOIN
//         answer_photos ON answers.answer_id = answer_photos.answer_id
//     WHERE product_id = $1;
//   `, [pId])
//     .then((questions) => {
//       res.send(questions.rows)
//     })
//     .catch((err) => {
//       res.sendStatus(400);
//       throw err;
//     })
//   // res.send('hello from qa/questions')
// })

//Answers list (do not include reported As)
app.get('/qa/questions/:question_id/answers', (req, res) => {
  //don't forget to handle params: question_id
  //Query params: page, count
  const qId = req.params.question_id;
  pool.query(`
    SELECT * FROM answers WHERE question_id = $1
  `, [qId])
    .then((answers) => {
      res.send(answers.rows)
    })
    .catch((err) => {
      res.sendStatus(400);
      throw err;
    })
})

//Add a question for a product
app.post('/qa/questions', (req, res) => {
  //params: body, name, email, product_id
  res.send('hello from qa/questions POST')
})

//Add an answer to a question
app.post('/qa/questions/:question_id/answers', (req, res) => {
  const { question_id } = req.params
  //params: question_id
  //body params: body, name, email, product_id
  res.send(`hello from qa/questions/${question_id}/answers POST`)
})

//Mark question as helpful
app.put('/qa/questions/:question_id/helpful', (req, res) => {
  //params: question_id
  res.send('hello from /qa/questions/:question_id/helpful PUT')
})

//Report a question
app.put('/qa/questions/:question_id/report', (req, res) => {
  //params: question_id
  res.send('hello from /qa/questions/:question_id/report PUT')
})

//Mark answer as helpful
app.put('/qa/questions/:answer_id/helpful', (req, res) => {
  //params: answer_id
  res.send('hello from /qa/questions/:answer_id/helpful PUT')
})

//Report a answer
app.put('/qa/questions/:answer_id/report', (req, res) => {
  //params: question_id
  res.send('hello from /qa/questions/:answer_id/report PUT')
})


app.get('/loaderio-b73e926d7093dc0a2c53cb3c8941e71e/', (req, res) => {
  res.send('loaderio-b73e926d7093dc0a2c53cb3c8941e71e')
})


app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

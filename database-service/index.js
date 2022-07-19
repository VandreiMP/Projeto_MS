const http = require('http');
const express = require('express');
const Client = require('pg').Client
const Pool = require('pg').Pool
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 5432;
var retorno;

app.use(express.json());

var urlEncodedParser = bodyParser.urlencoded({ extended: true });

app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  res.setHeader("Access-Control-Allow-Methods", 'GET,PUT,POST,DELETE');
  next();
})

app.get('/database', urlEncodedParser, async (req, res) => {
  res.send('OK');
})

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
// const request = require('request');
const http = require('http');
const axios = require('axios');
const express = require('express');
const Client = require('pg').Client
const Pool = require('pg').Pool
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 3000;
var retorno;

const pool = new Pool({
  user: "admin",
  password: "admin",
  host: "localhost",
  port: 5432,
  database: "banking",

})

app.use(express.json());

var urlEncodedParser = bodyParser.urlencoded({ extended: true });

app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  res.setHeader("Access-Control-Allow-Methods", 'GET,PUT,POST,DELETE');
  next();
})

app.post('/login', urlEncodedParser, async (req, res) => {
    
  retorno = await verificaLogin(req.body.login, req.body.senha)

  if (retorno == 'OK') {
    res.status(200).send(retorno);
  }
  else {
    res.status(500).send(retorno);
  }

})

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

async function verificaLogin(login, senha) {

  var contador = 0;

  try {
    try {

      if ((login == null || login == '') && (senha == null || senha == '')) {
        return 'Favor informar usuário e senha!';
      }

      console.log("Abrindo conexão 1" );
      var client = await pool.connect();

      var result = await client.query(
        "select count(1) contador"
      + "  from users "
      + " where login = " + "'" + login + "'"
      + "   and senha = " + "'" + senha + "'");
      
      for (let row of result.rows) {
        contador = row.contador
      }

    } catch (err) {
      console.error('Erro:'+ err);
      // pool.end();
      return err;
    };
    console.log("Conexão bem sucedida")
    pool.end;
    console.log("Cliente desconectado.")
    if (contador > 0) {
      return 'OK';
    } else {
      return 'Usuário ou senha inválidos!';
    }
  } catch (ex) {
    // await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return "Erro ao conectar com banco de dados. Erro: " + ex;
  }
}
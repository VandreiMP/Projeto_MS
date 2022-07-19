#liberar porta
#kill $(lsof -ti :$PORT)
#kill -9 $(lsof -ti :$PORT)

cria imagem
docker build -t vandrei/appbanking .
roda o docker
docker run -p 3000:3000 -d vandrei/appbanking
libera a porta
##kill -9 $(lsof -ti :3000)
sudo systemctl start postgresql
sudo systemctl enable postgresql

/*
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'application/json; charset=UTF-8');
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  res.setHeader("Access-Control-Allow-Methods", 'GET,PUT,POST,DELETE');
  console.log("1");
  //const obs = JSON.parse(req.body);
  console.log(req.body);
//  res.end(req.body);
res.end("OK");

});

*/




const http = require('http');
const express = require('express');
const Client = require('pg').Client
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 3000;

const client = new Client({
    user: "admin",
    password: "admin",
    host: "localhost",
    port: 5432,
    database: "banking",
})

//getUsers()

app.use(express.json());

var urlEncodedParser = bodyParser.urlencoded({ extended: true });

app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  res.setHeader("Access-Control-Allow-Methods", 'GET,PUT,POST,DELETE');
  next();
})

app.post('/login', urlEncodedParser, (req, res) => {

  console.log(req.body.senha);

  res.send('OK')
  
  return res.json('Hello World!!');
})

app.get('/', urlEncodedParser, async(req, res) => {
  const teste = await verificaLogin('vandrei', '1425')
  console.log('1: '+ teste)
  res.send('Hello World!!');
})

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

async function verificaLogin(login, senha) {
    try {
      var texto;
        console.log(client.id)
        console.log("Abrindo conexão")
        await client.connect()
        console.log("Conexão bem sucedida")
        var result = await client.query("select *"
                                      + "  from users "
                                      + " where login = " +"'"+login+"'"
                                      +"    and senha = " + "'" + senha+"'")
    //    result.rows.forEach(element => {
    //     texto = element.nome;
    //     console.log(texto)
    //    })                       

       return result.rowCount;

    } catch(ex) {
        console.log("Erro ao conectar com banco de dados. Erro: "+ex)
    }
    finally {
        await client.end()
        console.log("Cliente desconectado.")
    }
}

async function setUsers(id, nome) {
    try {
        console.log("Abrindo conexão")
        await client.connect()
        console.log("Conexão bem sucedida")
        var result = await client.query('insert into users("id", "nome") values ('+"'"+id+"', '" + nome+"');")
        console.log("Valor inserido")
        var result = await client.query("select *     "
                                      + "  from users "
                                      + " where id = " + id)
        console.table(result.rows);
        console.table(result.rows);

    } catch (ex){
        console.log("Erro ao conectar com banco de dados. Erro: "+ex)
    }
    finally {
        await client.end()
        console.log("Cliente desconectado.")
    }
}

async function deleteUsers(id) {
    try {
        console.log("Abrindo conexão")
        await client.connect()
        console.log("Conexão bem sucedida")
        var result = await client.query('delete from users where id = '+id)
        console.log("Valor inserido")
        var result = await client.query("select *     "
                                      + "  from users "
                                      + " where id = " + id)
        console.table(result.rows);
        console.table(result.rows);

    } catch (ex){
        console.log("Erro ao conectar com banco de dados. Erro: "+ex)
    }
    finally {
        await client.end()
        console.log("Cliente desconectado.")
    }
}


##############
const http = require('http');
const express = require('express');
const Client = require('pg').Client
const Pool = require('pg').Pool
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 3000;
var retorno;

const client = new Client({
  user: "admin",
  password: "admin",
  host: "localhost",
  port: 5432,
  database: "banking",
})

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



app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

async function verificaLogin(login, senha) {
  try {
    var texto;
    console.log('antes');
    // await pool.connect().then(
    //   (cliente) => {
    //     console.log('dentro');
    //     client.query("select count(1) contador"
    //       + "  from users "
    //       + " where login = " + "'" + login + "'"
    //       + "    and senha = " + "'" + senha + "'").then(
    //         res =>
    //         {
    //           res.rows.forEach(element => {

    //     console.log('dentro 2');
    //             retorno = element.contador;
    //             // console.log(retorno)
    //             if (parseInt(element.contador) > 0) {
    //               console.log('Contador: ' + element.contador)
    //               retorno = 'OK';
    //               retorno = element.contador;
    //             } else {
    //               retorno = 'Usuário ou senha inválidos ou não existentes!';
    //             }

    //           })
    //         }
    //       )
    //   }
    // );

    try { 
      const client = await pool.connect(); 
      const res = await client.query("select count(1) contador"
            + "  from users "
            + " where login = " + "'" + login + "'"
            + "    and senha = " + "'" + senha + "'"); 
      for (let row of res.rows) { retorno = "OK"} }
       catch (err) { console.error(err); }; 

    console.log("Abrindo conexão" + login + ' ' + senha)

    console.log("Conexão bem sucedida")
    // await cliente.query("select count(1) contador"
    //   + "  from users "
    //   + " where login = " + "'" + login + "'"
    //   + "    and senha = " + "'" + senha + "'", async(erro, res) => {
    //     // console.log(res);
    //     res.rows.forEach(element => {
    //       retorno = element.contador;
    //       // console.log(retorno)
    //       if (parseInt(element.contador) > 0) {
    //         console.log('Contador: '+element.contador)
    //         retorno = 'OK';
    //         retorno = element.contador;
    //       } else {
    //         retorno = 'Usuário ou senha inválidos ou não existentes!';
    //       }

    //     });



    console.log('fim');
    pool.end;
    console.log('Finally' + retorno)
    console.log("Cliente desconectado.")
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
  }

}

app.post('/login', urlEncodedParser, async (req, res) => {
  await verificaLogin(req.body.login, req.body.senha)
  console.log('Retorno: ' + retorno)
  res.send(retorno);

})
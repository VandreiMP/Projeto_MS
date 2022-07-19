const http = require('http');
const express = require('express');
const Client = require('pg').Client
const Pool = require('pg').Pool
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 3002;
var retorno;
var mapRetorno = new Map();

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

app.post('/user', urlEncodedParser, async (req, res) => {
  retorno = await verificaUsuario(req)
 
   console.log('Retorno: ' + retorno)
   res.status(200).send(retorno);
 
 })

 app.post('/getUser', urlEncodedParser, async (req, res) => {
   var teste;
   var mapTeste = new Map();

  // if(req.body.id != null && req.body.id != ''){
  //   mapRetorno = await getUserbyId(req);
  // }else{
  //   JsonGambiarra = await getUsers();
  // }
  // console.log('Retorno: ' + mapRetorno)
  // mapRetorno.forEach(function (item, indice){
  //   console.log('retorno: ' + item);
  //   mapTeste.set(indice, item);
  // });

  retorno = await getUserbyId(req);

  res.status(200).send(retorno);
  // res.status(200).send(mapRetorno);
 })

app.delete('/user', urlEncodedParser, async (req, res) => {
  retorno = await deleteUser(req)
 
   console.log('Retorno: ' + retorno)
   res.status(200).send(retorno);
 
 })

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

async function verificaUsuario(json) {
  var contador = 0;
  if(json.body.nome == null || json.body.nome == ''){
    return {'mensagem' : 'Favor informar o nome!'};
  }else if(json.body.cpf == null || json.body.cpf == ''){
    return {'mensagem': 'Favor informar o CPF!'};
  }else if(json.body.login == null || json.body.login == ''){
    return {'mensagem': 'Favor informar o login!'};
  }else if(json.body.senha == null || json.body.senha == ''){
    return {'mensagem': 'Favor informar a senha!'};
  }
  try {
    if(typeof json.body.id === 'undefined'){
      console.log('undefined');
      contador = 0;
    }else if(json.body.id != '' && json.body.id != null){
    try { 
     
      console.log("Abrindo conexão verificaUsuario");
      var client = await pool.connect();
      console.log(json.body.id);
      var result = await client.query(
                                        "select count(1) contador"
                                      + "  from users "
                                      + " where id = " + "" + json.body.id + "");

      for (let row of result.rows) {
         contador = row.contador
      }

    }catch (err) { 
      console.error(err);
      return {'mensagem': 'err'};
    };
    console.log("Conexão bem sucedida")
    pool.end;
    console.log("Cliente desconectado.")
  }
    if(contador > 0 ){
      return updateUser(json);
     }else{
      return setUser(json);
     }  
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return {'mensagem':"Erro ao conectar com banco de dados. Erro: " + ex};
  }
}

async function generateId() {
  var id = 0;
  try {
    try { 
      console.log("Abrindo conexão generateId");
      var client = await pool.connect();
      var result = await client.query(
                                        "select coalesce(max(id), 0) + 1 id"
                                      + "  from users");

      for (let row of result.rows) {
         id = row.id
      }

    }catch (err) { 
      console.error(err);
      return err;
    };
    console.log("Conexão bem sucedida")
    pool.end;
    console.log("Cliente desconectado.")
    console.log("ID " + id + " gerado com sucesso")
    return id
   
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return "Erro ao conectar com banco de dados. Erro: " + ex;
  }
}

async function setUser(json) {
  var id;
  try {
    try { 
      console.log("Abrindo conexão setUser");
      id = await generateId();
      
      var client = await pool.connect();
      var result = await client.query(
                                       "  insert"
                                      +"    into users"
                                      +"         (id, nome, cpf, telefone, celular, login, senha)"
                                      +"  values ("+id+", '"+ json.body.nome + "','" + json.body.cpf+"','"+json.body.telefone+"',"
                                      +"          '"+json.body.celular+"','"+json.body.login+"','"+json.body.senha+"'"+")");

      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro incluído com sucesso!");
      return {
        "mensagem" :  "Registro incluído com sucesso!",
        "id" : id
      }

    }catch (err) { 
      console.error(err);
      return {'mensagem':'err'};
    };
    
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return {'mensagem': "Erro ao conectar com banco de dados. Erro: " + ex};
  }
}

async function updateUser(json) {
  
  try {
    try { 
      console.log("Abrindo conexão updateUser");
      var client = await pool.connect();
      var result = await client.query(
                                       "  update users"
                                      +"     set nome     = '" + json.body.nome +"',"
                                      +"         cpf      = '" + json.body.cpf + "',"
                                      +"         telefone = '" + json.body.telefone + "',"
                                      +"         celular  = '" + json.body.celular + "',"
                                      +"         login    = '" + json.body.login + "', "
                                      +"         senha    = '" + json.body.senha + "'"
                                      +"   where id = " + json.body.id);

      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro atualizado com sucesso!");
      return {'mensagem':"Registro atualizado com sucesso!",
              'id' : json.body.id};
                                

    }catch (err) { 
      console.error(err);
      return {'mensagem':err};
    };
   
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return {'mensagem':"Erro ao conectar com banco de dados. Erro: " + ex};
  }
}

async function deleteUser(json) {

  try {
    try { 
      console.log("Abrindo conexão");
      var client = await pool.connect();
      var result = await client.query(
                                       "  delete"
                                      +"    from users"
                                      +"   where id = " + json.body.id);
                                      
      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro apagado com sucesso!");
      return {'mensagem':"Registro apagado com sucesso!"};

    }catch (err) { 
      console.error(err);
      return {'mensagem':'err'};
    };
    
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return {'mensagem':"Erro ao conectar com banco de dados. Erro: " + ex};
  }
}

async function getUserbyId(json) {
  var id = 0;
  var consulta;
  try {
    try { 
      console.log("Abrindo conexão getUserbyId");
      var client = await pool.connect();
      var result = await client.query(
        "select * "
      + "  from users "
      + " where id = " + json.body.id);
      
      for (let row of result.rows) {
        consulta = {
          "id" : row.id,
          "nome": row.nome,
          "cpf": row.cpf,
          "telefone": row.telefone,
          "celular": row.celular,
          "login": row.login,
          "senha": row.senha
        }
      
      }

   
    }catch (err) { 
      console.error(err);
      return {"mensagem":err};
    };
    console.log("Conexão bem sucedida")
    pool.end;
    console.log("Cliente desconectado.")
    console.log("Consulta efetuada com sucesso")
    return consulta;
   
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return "Erro ao conectar com banco de dados. Erro: " + ex;
  }
}

async function getUsers() {
  var id = 0;
  var consulta;
  var json = new Map();
  var contador = 1;
  var JsonGambiarra;

  try {
    try { 
      console.log("Abrindo conexão getUsers");
      var client = await pool.connect();
      var result = await client.query(
       "select * "
      +"  from users "
      +" order by id");
      
      for (let row of result.rows) {
        // map.set('id', row.id);
        // map.set('nome', row.nome);
        // map.set('cpf', row.cpf);
        // map.set('telefone', row.telefone);
        // map.set('celular', row.celular);
        // map.set('login', row.login);
        // map.set('senha', row.senha);
        
        consulta = {
          "id" : row.id,
          "nome": row.nome,
          "cpf": row.cpf,
          "telefone": row.telefone,
          "celular": row.celular,
          "login": row.login,
          "senha": row.senha
        };

        json.set(contador, consulta);

        contador = contador + 1;
      
      }

      // json.forEach(function (item, indice){
      //      console.log(item);
      // });
      // console.log(json);
     
      // var teste = json.map( function(item, indice){
      //   console(item.nome);
      //   return 1;
      // });
      
    }catch (err) { 
      console.error(err);
      return {"mensagem":err};
    };
    console.log("Conexão bem sucedida")
    pool.end;
    console.log("Cliente desconectado.")
    console.log("Consulta efetuada com sucesso")
    return retorno;
   
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return "Erro ao conectar com banco de dados. Erro: " + ex;
  }
}
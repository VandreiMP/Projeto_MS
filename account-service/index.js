const http = require('http');
const express = require('express');
const Client = require('pg').Client
const Pool = require('pg').Pool
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 3003;
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

app.post('/account', urlEncodedParser, async (req, res) => {
  retorno = await verificaConta(req)
  res.status(200).send(retorno);
 
 })

 app.post('/getAccount', urlEncodedParser, async (req, res) => {
  retorno = await getAccountById(req);
  res.status(200).send(retorno);
 })

app.delete('/account', urlEncodedParser, async (req, res) => {
  retorno = await deleteAccount(req)
  res.status(200).send(retorno);
 })

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

async function verificaConta(json) {
  var contador = 0;
  try {
    if(json.body.codigoBanco == null || json.body.codigoBanco == ''){
        return {'mensagem' : 'Favor informar o código do banco!', "id": null};
      }else if(json.body.nomeBanco == null || json.body.nomeBanco == ''){
        return {'mensagem': 'Favor informar o nome do banco!', "id": null};
      }else if(json.body.agencia == null || json.body.agencia == ''){
        return {'mensagem': 'Favor informar a agência!', "id": null};
      }else if(json.body.conta == null || json.body.conta == ''){
        return {'mensagem': 'Favor informar a conta!', "id": null};
      }
    if(typeof json.body.id === 'undefined'){
      console.log('undefined');
      contador = 0;
    }else if(json.body.id != '' && json.body.id != null){
    try { 

      console.log(json.body.agencia);
    
      console.log("Abrindo conexão verificaConta");
      var client = await pool.connect();
      console.log(json.body.id);
      var result = await client.query(
                                        "select count(1) contador"
                                      + "  from bankAccount "
                                      + " where id = " + "" + json.body.id + "");

      for (let row of result.rows) {
         contador = row.contador
      }

    }catch (err) { 
      console.error(err);
      return {'mensagem': err};
    };
    console.log("Conexão bem sucedida")
    pool.end;
    console.log("Cliente desconectado.")
  }
    if(contador > 0 ){
      return updateAccount(json);
     }else{
      return setAccount(json);
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
                                      + "  from bankAccount");

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

async function setAccount(json) {
  var id;
  try {
    try { 
      console.log("Abrindo conexão setAccount");
      id = await generateId();
      
      var client = await pool.connect();
      var result = await client.query(
                                       "  insert"
                                      +"    into bankAccount"
                                      +"         (id, codigoBanco, nomeBanco, agencia, conta)"
                                      +"  values ("+id+", "+ json.body.codigoBanco + ",'" + json.body.nomeBanco+"',"+json.body.agencia+","
                                      +"           "+json.body.conta+")");

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
      return {'mensagem':err,
              'id': id};
    };
    
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return {'mensagem': "Erro ao conectar com banco de dados. Erro: " + ex};
  }
}

async function updateAccount(json) {
  
  try {
    try { 
      console.log("Abrindo conexão updateAccount");
      var client = await pool.connect();
      var result = await client.query(
                                       "  update bankAccount"
                                      +"     set codigoBanco = "  + json.body.codigoBanco +","
                                      +"         nomeBanco   = '" + json.body.nomeBanco + "',"
                                      +"         agencia     = "  + json.body.agencia + ","
                                      +"         conta       = "  + json.body.conta
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

async function deleteAccount(json) {

  try {
    try { 
      console.log("Abrindo conexão");
      var client = await pool.connect();
      var result = await client.query(
                                       "  delete"
                                      +"    from bankAccount"
                                      +"   where id = " + json.body.id);
                                      
      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro apagado com sucesso!");
      return {'mensagem':"Registro apagado com sucesso!"};

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

async function getAccountById(json) {
  var id = 0;
  var consulta;
  try {
    try { 
      console.log("Abrindo conexão getAccountById");
      var client = await pool.connect();
      
      var result = await client.query(
        "select * "
      + "  from bankAccount "
      + " where id = " + json.body.codigoConta);
   
      for (let row of result.rows) {
       
        consulta = {
          "id" : row.id,
          "codigoBanco": row.codigobanco,
          "nomeBanco": row.nomebanco,
          "agencia": row.agencia,
          "conta": row.conta
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
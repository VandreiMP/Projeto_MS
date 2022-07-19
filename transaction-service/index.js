const http = require('http');
const express = require('express');
const Client = require('pg').Client
const Pool = require('pg').Pool
const bodyParser = require('body-parser');
const hostname = '0.0.0.0';
const app = express();
const port = 3004;
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

app.post('/transaction', urlEncodedParser, async (req, res) => {
  retorno = await verificaConta(req)
  res.status(200).send(retorno);

})

app.post('/getTransaction', urlEncodedParser, async (req, res) => {
  retorno = await getTransactionByAccount(req);
  res.status(200).send(retorno);
})

app.delete('/transaction', urlEncodedParser, async (req, res) => {
  retorno = await deletetransaction(req)
  res.status(200).send(retorno);
})

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

async function verificaConta(json) {
  var contador = 0;
  try {
    if (json.body.codigoConta == null || json.body.codigoConta == '') {
      return { 'mensagem': 'Favor informar o código da conta!', "sequencial": null };
    } else if (json.body.valor == null || json.body.valor == '') {
      return { 'mensagem': 'Favor informar o valor!', "sequencial": null };
    } else if (json.body.data == null || json.body.data == '') {
      return { 'mensagem': 'Favor informar a data!', "sequencial": null };
    }
    if (typeof json.body.id === 'undefined') {
      console.log('undefined');
      contador = 0;
    } else if (json.body.id != '' && json.body.id != null) {
      try {

        console.log(json.body.agencia);

        console.log("Abrindo conexão verificaConta");
        var client = await pool.connect();
        console.log(json.body.id);
        var result = await client.query(
          "select count(1) contador"
          + "  from transation "
          + " where sequencial = " + "" + json.body.sequencial + "");

        for (let row of result.rows) {
          contador = row.contador
        }

      } catch (err) {
        console.error(err);
        return { 'mensagem': err };
      };
      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
    }
    if (contador > 0) {
      return updatetransaction(json);
    } else {
      return settransaction(json);
    }
  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return { 'mensagem': "Erro ao conectar com banco de dados. Erro: " + ex };
  }
}

async function generateId() {
  var id = 0;
  try {
    try {
      console.log("Abrindo conexão generateId");
      var client = await pool.connect();
      var result = await client.query(
        "select coalesce(max(sequencial), 0) + 1 id"
        + "  from transaction");

      for (let row of result.rows) {
        id = row.id
      }

    } catch (err) {
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

async function settransaction(json) {
  var sequencial;
  try {
    try {
      console.log("Abrindo conexão settransaction");
      sequencial = await generateId();

      var client = await pool.connect();
      var result = await client.query(
        "  insert"
        + "    into transaction"
        + "         (sequencial, idConta, valor, dataHora, origem)"
        + "  values (" + sequencial + ", " + json.body.codigoConta + "," + parseFloat(String(json.body.valor).replace(",", ".")) + ",'" + json.body.data + "',"
        + "           '" + json.body.origem + "')");

      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro incluído com sucesso!");
      return {
        "mensagem": "Registro incluído com sucesso!",
        "id": sequencial
      }

    } catch (err) {
      console.error(err);
      return {
        'mensagem': err,
        'id': id
      };
    };

  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return { 'mensagem': "Erro ao conectar com banco de dados. Erro: " + ex };
  }
}

async function updatetransaction(json) {

  try {
    try {
      console.log("Abrindo conexão updateTransaction");
      var client = await pool.connect();
      var result = await client.query(
        "  update transaction"
        + "     set idConta  = " + json.body.codigoConta + ","
        + "         valor    = " + json.body.valor + ","
        + "         dataHora = " + json.body.data + ","
        + "         origem   = '" + json.body.origem + "'"
        + "   where sequencial = " + json.body.sequencial);

      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro atualizado com sucesso!");
      return {
        'mensagem': "Registro atualizado com sucesso!",
        'id': json.body.id
      };


    } catch (err) {
      console.error(err);
      return { 'mensagem': err };
    };

  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return { 'mensagem': "Erro ao conectar com banco de dados. Erro: " + ex };
  }
}

async function deletetransaction(json) {

  try {
    try {
      console.log("Abrindo conexão");
      var client = await pool.connect();
      var result = await client.query(
        "  delete"
        + "    from transaction"
        + "   where sequencial = " + json.body.sequencial);

      console.log("Conexão bem sucedida")
      pool.end;
      console.log("Cliente desconectado.")
      console.log("Registro apagado com sucesso!");
      return { 'mensagem': "Registro apagado com sucesso!" };

    } catch (err) {
      console.error(err);
      return { 'mensagem': err };
    };

  } catch (ex) {
    await pool.end()
    console.log("Erro ao conectar com banco de dados. Erro: " + ex)
    return { 'mensagem': "Erro ao conectar com banco de dados. Erro: " + ex };
  }
}

async function getTransactionByAccount(json) {
  var id = 0;
  var consulta;
  try {
    try {
      
      console.log("Abrindo conexão getTransactionByAccount");
      var client = await pool.connect();

      console.log(json.body.codigoConta);

      if (json.body.codigoConta != null && json.body.codigoConta != ''){
        console.log('if');
        var extrato = 'Banco/Agência/Conta: ';

        var result = await client.query(
          "select codigoBanco, nomeBanco, agencia, conta"
          + "  from bankAccount"
          + " where id = " + json.body.codigoConta);

        for (let row of result.rows) {
          extrato = extrato + row.codigobanco + ' - ' + row.nomebanco + '/' + row.agencia + '/' + row.conta + '\n';
        }

        var result = await client.query(
          "select case "
          + "       when origem = 'D' then "
          + "            'Despesa' "
          + "       when origem = 'G' then "
          + "            'Ganho'"
          + "       end origem, "
          + "       trim(to_char(valor, '999G999G999D99')) valor,"
          + "       to_char(dataHora, 'DD/MM/YYYY') dataHora"
          + "  from transaction"
          + " where idConta = " + json.body.codigoConta);

        for (let row of result.rows) {

          extrato = extrato + '\n' + '---------------------------------------------------\n';
          extrato = extrato + 'Origem: ' + row.origem + '\n';
          extrato = extrato + 'Valor: ' + row.valor + '\n';
          extrato = extrato + 'Data: ' + row.datahora + '\n';
          

          consulta = {
            "extrato": extrato
          }

        }
        
      }else{

        var ganhos;
        var despesas;
        var saldoGeral;
        
        var result = await client.query(
           "select to_char(coalesce(sum(valor), 0), 'FM999G999G999G9990D00') ganhos"
          +"  from transaction"
          +" where origem = 'G'");

        for (let row of result.rows) {
          ganhos = row.ganhos;
        }

        var result = await client.query(
          "select to_char(coalesce(sum(valor), 0), 'FM999G999G999G9990D00') despesas,"
         +"       to_char(" + parseFloat(ganhos) + " - coalesce(sum(valor), 0), 'FM999G999G999G9990D00') saldoGeral"
         +"  from transaction"
         +" where origem = 'D'");

       for (let row of result.rows) {
         despesas = row.despesas;
         saldoGeral = row.saldogeral;
       }
       
       //saldoGeral = parseFloat(ganhos) - parseFloat(despesas);
       console.log(saldoGeral);
       consulta = {
        "ganhos": ganhos,
        "despesas": despesas,
        "saldoGeral": saldoGeral
       };

     }

    } catch (err) {
      console.error(err);
      return { "mensagem": err };
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
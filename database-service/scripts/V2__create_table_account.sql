create table bankAccount
(id bigint not null,
 codigoBanco bigint not null,
 nomeBanco text not null,
 agencia bigint not null,
 conta bigint not null);

 alter table bankAccount add constraint pk_bankAccount primary key(id);
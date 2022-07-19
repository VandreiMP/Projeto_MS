create table transaction
(sequencial bigint not null,
 idConta bigint not null,
 valor bigint not null,
 dataHora date not null,
 origem text not null);

alter table transaction add constraint pk_transaction primary key(sequencial);

alter table transaction add constraint fk_transaction_conta foreign key(idConta) references bankAccount (id);
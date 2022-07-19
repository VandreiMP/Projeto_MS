create table users
(id bigint not null,
 nome text not null,
 cpf text not null,
 telefone text,
 celular text,
 login text not null,
 senha text not null);

 alter table users add constraint pk_users primary key(id);
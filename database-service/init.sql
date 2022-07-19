create database banking;
create user admin with ENCRYPTED PASSWORD 'admin';
GRANT ALL PRIVILEGES ON DATABASE banking TO admin;
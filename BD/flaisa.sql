create database dbisaefla;
use dbisaefla;

-- 1º EXERCICIOS -- 
create table tbUsuario (
IdUsuario int primary key,
Nomeusuario varchar (45),
DataNascimento date
);
show tables;
describe tbusuario;



create table TbCliente (
CodigoCli smallint ,
Nome varchar (50),
Endereco varchar (60)
);
alter table tbcliente modify codigocli smallint primary key;

show tables;
describe tbcliente;


create table Estado (
Id int,
UF char (2)
);
-- Modificamos colocando a chave primaria --
alter table Estado modify Id int primary key;


create table TbProduto (
Barra decimal (13,0) primary key,
Valor decimal (10,4),
descricao varchar (230)
);
show tables;
describe TbProduto;

show tables;
describe tbCliente;


-- 2º EXERCICIOS -- 
describe tbproduto;
show tables;
show databases;
alter table tbcliente modify nome varchar (58);
alter table tbProduto add Qtd int;
drop table Estado;
alter table tbusuario drop dataNascimento;


-- 3º EXERCICIOS -- 
create database dbandre;
use dbandre;
show tables;

create table tbproduto (
IdProp int not null primary key,
NomeProd char (50) not null,
Qtd int,
DataValidade date not null,
Preco decimal (8,2) not null
);
describe tbproduto;

create table tbcliente (
Codigo int primary key,
NomeCli char (50) not null,
DataNascimento date
);
describe tbcliente;
CREATE database dbcomercio;



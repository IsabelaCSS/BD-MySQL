-- EXERCICIOS I --

-- 1º EXERCICIO -- 
create database dbflaisa;
use dbflaisa;

-- 2º EXERCICIO -- 
create table tbUsuario (
IdUsuario int primary key,
NomeUsuario varchar (45),
DataNascimento date
);

create table tbCliente (
CodigoCli smallint primary key,
Nome varchar (50),
Endereco varchar (60)
);

create table tbEstado (
Id int primary key,
UF char (2)
);

create table tbProduto(
Barra decimal (13,0) primary key,
Valor decimal (10,4),
Descricao varchar (230)
);

-- 3º EXERCICIO -- 
describe tbProduto;

-- 4º EXERCICIO -- 
Show tables;

-- 5º EXERCICIO -- 
Show databases;

-- 6º EXERCICIO -- 
alter table tbCliente modify Nome varchar (58);

-- 7º EXERCICIO -- 
alter table tbProduto add Qtd int;

-- 8º EXERCICIO -- 
drop table tbEstado;

-- 9º EXERCICIO -- 
alter table tbUsuario drop dataNascimento;
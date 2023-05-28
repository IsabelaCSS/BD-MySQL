-- EXERCICIOS VI --

-- 1º EXERCICIO -- 
create database dbdesenvolvimento;
use dbdesenvolvimento;

-- 2º EXERCICIO -- 
create table tbProduto(
IdProp int primary key,
NomeProd char (50) not null,
Qtd int,
DataValidade date not null,
Preco decimal (10,2) not null
);

-- 3º EXERCICIO -- 
alter table tbProduto add Peso decimal (6,3);
alter table tbProduto add Cor char (50);
alter table tbProduto add Marca char (50) not null;

-- 4º EXERCICIO -- 
alter table tbProduto drop Cor;

-- 5º EXERCICIO -- 
alter table tbProduto modify Peso decimal (6,3) not null;
 
-- 6º EXERCICIO -- 
/* 
Não é possivel apagar a cor 
pois ja foi apagado anteriormente
*/

-- 7º EXERCICIO -- 
create database dbLojaGrande;
use dbLojaGrande;

-- 8º EXERCICIO -- 
use dbdesenvolvimento;
alter table tbProduto add Cor char (50);

-- 9º EXERCICIO -- 
create database dbLojica;
use dbLojica;

create table tbCliente(
NomeCli char (50) not null,
CodigoCli int primary key,
DataCadastro date not null
);

-- 10º EXERCICIO -- 
use dbLojaGrande;

create table tbFuncionario(
NomeFunc char (50) not null,
CodigoFunc int primary key,
DataCadastro datetime not null
);

-- 11º EXERCICIO -- 
drop database dbLojaGrande;

-- 12º EXERCICIO -- 
use dbLojica;

alter table tbCliente add CPF decimal (11,0) not null unique;
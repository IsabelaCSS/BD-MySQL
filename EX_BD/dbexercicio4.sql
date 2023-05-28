-- EXERCICIOS IV --

-- 1º EXERCICIO -- 
create database dbvera;
use dbvera;

-- 2º EXERCICIO -- 
create table tbProduto(
IdProd int primary key,
NomeProd char (50) not null,
Qtd int,
DataValidade date not null,
Preco decimal (10,2) not null
);

-- 3º EXERCICIO -- 
Alter table tbProduto add Peso decimal (6,3);
Alter table tbProduto add Cor char (50);
Alter table tbProduto add  Marca char (50) not null;

-- 4º EXERCICIO -- 
Alter table tbProduto drop Cor;

-- 5º EXERCICIO -- 
Alter table tbProduto modify Peso decimal (6,3) not null;

-- 6º EXERCICIO -- 
Alter table tbProduto drop DataValidade;
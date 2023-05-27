-- EXERCICIOS II --

-- 1º EXERCICIO -- 
create database dbandre;
use dbandre;

-- 2º EXERCICIO -- 
create table tbproduto (
IdProp int primary key,
NomeProd char (50) not null,
Qtd int,
DataValidade date not null,
Preco decimal (8,2) not null
);

-- 3º EXERCICIO -- 
create table tbcliente (
Codigo int primary key,
NomeCli char (50) not null,
DataNascimento date
);
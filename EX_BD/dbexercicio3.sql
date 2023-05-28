-- EXERCICIOS III --

-- 1º EXERCICIO -- 
create database dbcomercio;
use dbcomercio;

-- 2º EXERCICIO -- 
create table tbCliente (
Id int primary key,
NomeCli char (200) not null,
NumEnd decimal (6,0) not null,
CompEnd char (50) 
);

create table tbClientePF(
CPF decimal (11,0)  primary key,
RG decimal (9,0),
RGdig char(1),
Nascimento date not null
);
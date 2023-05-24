create database dbcomercio;
use dbcomercio;

Create table tbCliente (
Id int primary key,
NomeCli char (200) not null,
NumEnd decimal (6,0) not null,
CompEnd char (50) 
);

CREATE table tbClientePF(
CPF decimal (11,0)  primary key,
RG decimal (9,0),
RGdig char(1),
Nascimento date not null
);


describe tbCliente;
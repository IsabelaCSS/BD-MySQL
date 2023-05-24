Create database dbdesenvolvimento;
use dbdesenvolvimento;

CREATE table tbProduto(
IdProp int primary key,
NomeProd char (50) not null,
Qtd int,
DataValidade date not null,
preco decimal (10,2) not null
);

alter table tbProduto modify Preco decimal (10,2) not null;

alter table tbProduto add peso decimal (6,3);
alter table tbProduto add cor char (50);
alter table tbProduto add marca char (50) not null;

alter table tbProduto drop cor;

alter table tbProduto modify peso decimal (6,3) not null;

/* não é possivel apagar a cor pois ja foi apagado */

-- 22/05/2023 --
create database dbLojaGrande;
use dbLojaGrande;

use dbdesenvolvimento;

alter table tbProduto add Cor char (50);

create database dbLojica;
use dbLojica;

create table tbcliente(
NomeCli char (50) not null,
CodigoCli int primary key,
DataCadastro date not null
);

use dbLojaGrande;

create table tbFuncionario(
NomeFunc char (50) not null,
CodigoFunc int primary key,
DataCadastro datetime not null
);

drop database dbLojaGrande;

use dbLojica;

alter table tbCliente add CPF decimal (11,0) not null unique;


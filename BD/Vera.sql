CREATE database dbvera;
use dbvera;

CREATE table tbProduto(
IdProd int primary key,
NomeProd char (50) not null,
Qtd int,
DataValidade date not null,
preco decimal (10,2) not null
);

Alter table tbProduto add peso decimal (6,3);
Alter table tbProduto add cor char (50);
Alter table tbProduto add  marca char (50) not null;

Alter table tbProduto drop cor;

Alter table tbProduto modify peso decimal (6,3) not null;

Alter table tbProduto drop DataValidade;

describe tbProduto;
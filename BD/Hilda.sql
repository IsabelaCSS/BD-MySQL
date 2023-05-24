CREATE database dbhilda;
use dbhilda;

Create table tbVenda(
nf int primary key auto_increment,
DataValidade date not null,
CodigoB decimal (13,0) not null unique, 
foreign key (CodigoB) references tbProduto (CodigoB)
);

alter table tbVenda add preco decimal (10,2) not null;
alter table tbVenda add Qtd smallint;

alter table tbVenda drop DataValidade;

alter table tbVenda add DataVenda date;

Create table tbProduto(
CodigoB decimal (13,0) primary key,
NomeProd char (50) not null
);

describe tbVenda;

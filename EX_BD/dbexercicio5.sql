-- EXERCICIOS V --

-- 1º EXERCICIO -- 
create database dbhilda;
use dbhilda;

-- 2º EXERCICIO -- 
create table tbVenda(
NF int primary key auto_increment,
DataValidade date not null
);

-- 3º EXERCICIO -- 
alter table tbVenda add Preco decimal (10,2) not null;
alter table tbVenda add Qtd smallint;

-- 4º EXERCICIO -- 
alter table tbVenda drop DataValidade;

-- 5º EXERCICIO -- 
alter table tbVenda add DataVenda date default (current_date);
	
-- 6º EXERCICIO -- 
create table tbProduto(
CodigoB decimal (13,0) primary key,
NomeProd char (50) not null
);

-- 7º EXERCICIO -- 
Alter table tbvenda add CodigoB decimal (13,0) not null unique;
Alter table tbvenda add constraint CodigoB foreign key (CodigoB) references tbProduto (CodigoB);
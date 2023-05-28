-- EXERCICIOS VI --


-- 1º EXERCICIO -- 
-- Isabela e Flavia --

-- 2º EXERCICIO -- 
create database dbescola;
use dbescola;

-- 3º EXERCICIO -- 
create table tbcliente(
IdCli int primary key,
NomeCli varchar (50) not null,
NumEnd smallint,
DataCadastro datetime default current_timestamp
);

-- 4º EXERCICIO -- 
alter table tbcliente add CPF decimal (11,0) unique;

-- 5º EXERCICIO -- 
alter table tbcliente add Cep decimal (5,0);


-- 6º EXERCICIO -- 
create database dbempresa;

-- 7º EXERCICIO -- 
use dbescola;

create table tbendereco(
Cep decimal (5,0) primary key,
Logradouro char (250) not null,
IdUf tinyint
);

-- 8º EXERCICIO -- 
alter table tbcliente add Fk_Cep_tbcliente decimal (5,0);
alter table tbcliente add constraint Fk_Cep_tbcliente foreign key (Fk_Cep_tbcliente) references tbendereco(Cep);

-- 9º EXERCICIO -- 
describe tbcliente;

-- 10º EXERCICIO -- 
/* 
Colocar o datetime current_timestamp
Adicionar a foreign key 
Diferenciar os tipo de dados
*/

-- 11º EXERCICIO -- 
show databases;

-- 12º EXERCICIO -- 
drop database dbempresa;

 -- EXERCICIO VIII --
 
 -- 1º EXERCICIO -- 
use dbescola;
 create table tbEst(
 IdUf tinyint primary key,
 NomeUfs char (2) not null,
 NomeEstado varchar (40) not null
 );
 
 -- 2º EXERCICIO -- 
alter table tbendereco add Fk_IdUF_tbendereco tinyint;
alter table tbendereco add constraint Fk_IdUF_tbendereco foreign key  (Fk_IdUF_tbendereco ) references tbEst(IdUf);

 -- 3º EXERCICIO -- 
alter table tbEst drop NomeEstado;

 -- 4º EXERCICIO -- 
RENAME table tbEst TO tbEstado;

 -- 5º EXERCICIO -- 
alter table tbEstado RENAME COLUMN NomeUfs TO NomeUf;

 -- 6º EXERCICIO -- 
alter table tbendereco add IdCid int;

 -- 7º EXERCICIO -- 
create table tbCidade(
IdCid int primary key,
NomeCidade varchar (50) not null
);

 -- 8º EXERCICIO -- 
alter table tbCidade modify NomeCidade varchar (250) not null;

 -- 9º EXERCICIO -- 
alter table tbendereco add Fk_IdCid_tbendereco int;
alter table tbendereco add constraint Fk_IdCid_tbendereco foreign key  (Fk_IdCid_tbendereco) references tbCidade(IdCid);

describe tbendereco;
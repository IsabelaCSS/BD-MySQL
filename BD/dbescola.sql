-- Isabela e Flavia --
create database dbescola;
use dbescola;

create table tbcliente(
IdCli int primary key,
NomeCli char (50) not null,
NumEnd smallint,
DataCadastro datetime
);

alter table tbcliente modify NomeCli varchar (50);

alter table tbcliente modify DataCadastro datetime default current_timestamp;

alter table tbcliente add CPF decimal (11,0) unique not null;
alter table tbcliente modify CPF decimal (11,0) unique;

alter table tbcliente add Cep decimal (5,0);

create database dbempresa;
use dbescola;

create table tbendereco(
Cep decimal (5,0) primary key,
Logradouro char (250) not null,
IdUf tinyint
);

-- já tem cep na tabela Cliente --
alter table tbcliente add Fk_Cep_tbcliente decimal (5,0);
alter table tbcliente add constraint Fk_Cep_tbcliente foreign key  (Fk_Cep_tbcliente) references tbendereco(Cep);

describe tbcliente;

/* colocar o datetime 
Adicionar a foreign key 
colocar o tipo de dados
*/

show databases;

 -- EXERCICIO 8 --
 
use dbescola;
 create table tbEst(
 IdUf tinyint primary key,
 NomeUfs char (2) not null,
 NomeEstado varchar (40) not null
 );
 
alter table tbendereco add Fk_IdUf_tbendereco tinyint;
alter table tbendereco add constraint Fk_IdUf_tbendereco foreign key  (Fk_IdUf_tbendereco ) references tbEst(IdUf);

alter table tbEst drop NomeEstado;

RENAME table tbEst TO tbEstado;

alter table tbEstado RENAME COLUMN NomeUfs TO NomeUf;

alter table tbendereco add IdCid int;

create table tbCidade(
IdCid int primary key,
NomeCidade varchar (50) not null
);

alter table tbCidade modify NomeCidade varchar (50) not null;

alter table tbendereco modify Fk_IdCid_tbendereco int;
alter table tbendereco add constraint Fk_IdCid_tbendereco foreign key  (Fk_IdCid_tbendereco ) references tbCidade(IdCid);



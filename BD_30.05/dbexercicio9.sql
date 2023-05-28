 -- EXERCICIO IX --

-- 1º EXERCICIO -- 
create database dbBANCO;
use dbBANCO;

-- 2º EXERCICIO -- 
create table tbcliente(
Cpf bigint primary key,
Nome varchar(50) not null,
Sexo char(1)  not null,
Endereco varchar(50)  not null
);

create table tbtelefone_cliente(
Cpf bigint,
Telefone int
);

create table tbhistorico(
DataInicio date
);

create table tbconta(
NumeroConta int primary key,
Saldo decimal(7,2) not null,
TipoConta smallint not null
);

/* 
adicioanndo a fk da tabela tbhistorico do 
atributo NumeroConta para a tabela tbconta 
*/
alter table tbhistorico add NumeroConta int;
alter table tbhistorico add constraint NumeroConta foreign key (NumeroConta) references tbconta (NumeroConta);

alter table tbhistorico add Cpf bigint;
alter table tbhistorico add constraint Cpf foreign key (Cpf) references tbcliente (Cpf);

describe tbhistorico;

create table tbagencia(
NumeroAgencia int primary key,
Endereco varchar(50)
); 

alter table tbconta add NumAgencia int;
alter table tbconta add constraint NumAgencia foreign key (NumAgencia) references tbagencia (NumeroAgencia);

describe tbconta;

create table tbbanco(
Codigo Int primary key,
Nome varchar(50)
);

alter table tbagencia add CodBanco int;
alter table tbagencia add constraint CodBanco foreign key (CodBanco) references tbBanco (Codigo);
 

describe tbcliente;
describe tbtelefone_cliente;
describe tbhistorico;
describe tbconta;
describe tbagencia;
describe tbbanco;
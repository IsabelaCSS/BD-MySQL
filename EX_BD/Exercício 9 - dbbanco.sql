create database dbBANCO;
use dbBANCO;

create table tbcliente(
Cpf bigint primary key,
Nome varchar(50) not null,
Sexo char(1) not null,
Endereco varchar(50) not null
);

create table tbtelefone_cliente(
Telefone int primary key 
);

-- adicioanndo a fk -- 
alter table tbtelefone_cliente add Cpf bigint;
alter table tbtelefone_cliente add constraint Cpf foreign key (Cpf) references tbcliente (Cpf);


create table tbhistorico(
DataIncio date,
NumeroConta int,
Cpf bigint,
primary key (NumeroConta, Cpf),
foreign key (Cpf) references tbcliente (Cpf),
foreign key (NumeroConta) references tbconta (NumeroConta)
);


describe tbhistorico;

create table tbconta(
NumeroConta int primary key,
Saldo decimal(7,2),
TipoConta smallint
);

alter table tbconta add NumAgencia int;
alter table tbconta add constraint NumAgencia foreign key (NumAgencia) references tbagencia (NumeroAgencia);

describe tbconta;

create table tbagencia(
NumeroAgencia int primary key,
Endereco varchar(50) not null
); 

alter table tbagencia add CodBanco int;
alter table tbagencia add constraint CodBanco foreign key (CodBanco) references tbbanco (Codigo);
 
create table tbbanco(
Codigo Int primary key,
Nome varchar(50) not null
);

describe tbcliente;
describe tbtelefone_cliente;
describe tbhistorico;
describe tbconta;
describe tbagencia;
describe tbbanco;

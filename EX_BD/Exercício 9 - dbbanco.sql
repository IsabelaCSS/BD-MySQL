create database dbBANCO;
use dbBANCO;

create table tbcliente(
Cpf bigint primary key,
Nome varchar(50),
Sexo char(1),
Endereco varchar(50)
);

create table tbtelefone_cliente(
Telefone int
);

-- adicioanndo a fk -- 

create table tbhistorico(
DataIncio date
);

alter table tbhistorico modify DataInicio date not null;

alter table tbhistorico add NumeroConta int;
alter table tbhistorico add constraint NumeroConta foreign key (NumeroConta) references tbconta (NumeroConta);

alter table tbhistorico add Cpf bigint;
alter table tbhistorico add constraint Cpf foreign key (Cpf) references tbcliente (Cpf);

describe tbhistorico;

create table tbconta(
NumeroConta int primary key,
Saldo decimal(7,2) not null,
TipoConta smallint not null
);

alter table tbconta add NumAgencia int;
alter table tbconta add constraint NumAgencia foreign key (NumAgencia) references tbagencia (NumeroAgencia);

describe tbconta;

create table tbagencia(
NumeroAgencia int primary key,
Endereco varchar(50)
); 

alter table tbagencia add CodBanco int;
alter table tbagencia add constraint CodBanco foreign key (CodBanco) references tbbanco (Codigo);
 
create table tbbanco(
Codigo Int primary key,
Nome varchar(50)
);

describe tbcliente;
describe tbtelefone_cliente;
describe tbhistorico;
describe tbconta;
describe tbagencia;
describe tbbanco;
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
foreign key (Cpf) references tbcliente (Cpf),
Telefone int primary key
);

create table tbbanco(
Codigo Int primary key,
Nome varchar(50) not null
);

create table tbagencia(
CodBanco int,
foreign key (CodBanco) references tbbanco (Codigo), 
NumeroAgencia int primary key,
Endereco varchar(50) not null
); 

create table tbconta(
NumeroConta int primary key,
Saldo decimal(7,2),
TipoConta smallint,
NumAgencia int not null,
foreign key (NumAgencia) references tbagencia (NumeroAgencia)
);

create table tbhistorico(
Cpf bigint unique,	
NumeroConta int,
DataInicio date,
foreign key (NumeroConta) references tbconta(NumeroConta),
foreign key (Cpf) references tbcliente (Cpf),
constraint tbhistorico primary key (Cpf,NumeroConta)
);

describe tbcliente;
describe tbtelefone_cliente;
describe tbhistorico;
describe tbconta;
describe tbagencia;
describe tbbanco;

-- 3º EXERCICIO --
 
-- Registros da tabela BANCO -- 
insert into tbBANCO (codigo, Nome)
	values ( 1, 'Banco do Brasil');
    
insert into tbBANCO (codigo, Nome)
	values ( 104, 'Caixa Economica Federal');
    
insert into tbBANCO (codigo, Nome)
	values ( 801, 'Banco Escola');
    
select * from tbBANCO;
    
-- Registros da tabela AGENCIA -- 
insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 1, 123, 'Av  Paulista,78');
    
insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 104, 159, 'Rua Liberdade,124');
    
insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 801, 401, 'Rua Vinte três,23');

insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 801, 485, 'Av Marechal,68');

select * from tbAGENCIA;

-- Registros da tabela Cliente --
insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678910, 'Enildo', 'M', 'Rua Grande, 75');

insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678911, 'Astrogildo', 'M', 'Rua Pequena, 789');

insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678912, 'Monica', 'F', 'Rua Larga, 148');
    
insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678913, 'Cascão', 'M', 'Av Principal, 369');
    
select * from tbcliente;

-- Registros da tabela Conta -- 
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9876 , 456.05 , 1, 123);
    
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9877 , 321.00 , 1, 123);

insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9878 , 100.00 , 2, 485);
    
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9879 , 5589.48 , 1, 401);
    
select * from tbConta;

-- Registros da tabela historico -- 
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678910 , 9876 , '2001-04-15');
    
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678911 , 9877 , '2011-03-10');
    
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678912 , 9878 , '2021-03-11');
    
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678913 , 9879 , '2000-07-05');
    
select * from tbhistorico;


-- Registros da tabela telefone_cliente -- 
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678910 , '912345678');
    
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678911 , '912345679');
    
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678912 , '912345680');
    
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678913 , '912345681');
    
select * from tbtelefone_cliente;


-- 4º EXERCICIO --
alter table tbcliente add email varchar(40); 

-- 5º EXERCICIO --
select Cpf, Endereco from tbCliente where Nome = 'Monica';

-- 6º EXERCICIO --
select NumeroAgencia, endereco from tbAgencia where Codbanco= '801';

-- 7º EXERCICIO --
select * from tbCliente where sexo = 'M';


-- EXERCICIO IX --
 
-- 1º EXERCICIO --
set sql_safe_updates = 0;

delete from tbtelefone_cliente  where cpf = '12345678911';
select * from tbtelefone_cliente;

-- 2º EXERCICIO --
update tbconta set TipoConta = 2 where NumeroConta = 9879;
select * from tbConta;

-- 3º EXERCICIO --
update tbcliente set email = 'Astro@Escola.com' where Nome = 'Monica';
select * from tbcliente;

-- 4º EXERCICIO --
update tbconta set saldo = (saldo * (10/100)) + saldo where NumeroConta = 9876;
select * from tbconta;

-- 5º EXERCICIO --
select Nome, Email, Endereco from tbCliente  where Nome = 'Monica'; 

-- 6º EXERCICIO --
update tbCliente set Nome = 'Enildo Candido' , email = 'enildo@escola.com' where Nome = 'Enildo';
select * from tbcliente;

-- 7º EXERCICIO --
update tbconta set saldo = saldo - 30;
select * from tbconta;

-- 8º EXERCICIO --
delete from tbconta where NumeroConta = 9878;
-- Não foi possível apagar pois não podemos apagar uma linha pai; e tem muitas restições --


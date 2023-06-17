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

-- 3 --

insert into tbBANCO (codigo, Nome)
	values ( 1, 'Banco do Brasil');
    
insert into tbBANCO (codigo, Nome)
	values ( 104, 'Caixa Economica Federal');
    
insert into tbBANCO (codigo, Nome)
	values ( 801, 'Banco Escola');
    
select * from tbbanco;
    
insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 1, 123, 'Av  Paulista, 78');
    
insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 104, 159, 'Rua Liberdade, 124');
    
insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 801, 401, 'Rua Vinte três, 23');

select * from tbagencia;

insert into tbAGENCIA (CodBanco, NumeroAgencia, Endereco)
	values ( 801, 485, 'Av Marechal,68');
    
insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678910, 'Enildo', 'M', 'Rua Grande, 75');
    
    
insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678911, 'Astrogildo', 'M', 'Rua Pequena, 789');

insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678912, 'Monica', 'F', 'Rua Larga, 148');
    
insert into tbCliente (Cpf, Nome, Sexo, Endereco)
	values ( 12345678913, 'Cascão', 'M', 'Av Principal, 369');
    
select * from tbcliente;

insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9876 , 456.05 , 1, 123);
    
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9877 , 321.00 , 1, 123);

insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9878 , 100.00 , 2, 485);
    
insert into tbConta (NumeroConta, Saldo, TipoConta, NumAgencia)
	values (9879 , 5589.48 , 1, 401);
    
select * from tbConta;

insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678910 , 9876 , '2001-04-15');
    
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678911 , 9877 , '2011-03-10');
    
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678912 , 9878 , '2021-03-11');
    
insert into tbhistorico (Cpf, NumeroConta, DataInicio)
	values (12345678913 , 9879 , '2021-07-05');
    
select * from tbhistorico;

insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678910 , '912345678');
    
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678911 , '912345679');
    
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678912 , '912345680');
    
insert into tbtelefone_cliente (Cpf, telefone)
	values (12345678913 , '912345681');
    
select * from tbtelefone_cliente;


-- 4 -- 
alter table tbcliente add email varchar(40); 

-- 5 --
select Cpf, Endereco from tbCliente where Nome = 'Monica';

-- 6-- 
select NumeroAgencia, endereco from tbAgencia where Codbanco= '801';

-- 7 -- 
select * from tbCliente where sexo = 'M';


-- Ex X -- 
-- 1 -- 
set sql_safe_updates = 0;

delete from tbtelefone_cliente  where cpf = '12345678911';
select * from tbtelefone_cliente;

-- 2 --

update tbconta set TipoConta = 2 where NumeroConta = 9879;
select * from tbConta;

-- 3 -- 
update tbcliente set email = 'Astro@Escola.com' where Nome = 'Monica';
select * from tbcliente;

-- 4 --
update tbconta set saldo = saldo + (10/100) where NumeroConta = 9876;
select * from tbconta;

-- 5 --
select Nome, Email, Endereco from tbCliente  where Nome = 'Monica'; 

-- 6 -- 
update tbCliente set Nome = 'Enildo Candido' , email = 'enildo@escola.com' where Nome = 'Enildo';
select * from tbcliente;

-- 7 -- 
update tbconta set saldo = saldo - 30;
select * from tbconta;

-- 8 -- 
delete from tbconta where NumeroConta = 9878;
-- Não foi possível apagar pois não podemos apagar uma linha pai; e tem muitas restições --


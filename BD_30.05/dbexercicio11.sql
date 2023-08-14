create database dbdistribuidora;
use dbdistribuidora;

create table tbFornecedor(
Codigo int primary key auto_increment,
CNPJ decimal (14,0) unique,
Nome varchar (200) not null,
Telefone decimal (11,0)
);

create table tbProduto(
CodigoBarras decimal (14,0) primary key,
Nome varchar (200) not null,
ValorUnitario decimal (8,2) not null,
Qtd int
);

create table tbNota_fiscal(
NF int primary key,
TotalNota decimal (8,2) not null,
DataEmissao date not null
);

create table tbBairro(
BairroId int primary key auto_increment,
Bairro varchar (200) not null
);

create table tbCidade(
CidadeId int primary key auto_increment,
Cidade varchar (200) not null
);

create table tbEstado(
UFId int primary key auto_increment,
UF char (2) not null
);

create table tbCompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal (8,2) not null,
QtdTotal int not null,
Codigo int not null,
foreign key (Codigo) references tbFornecedor (Codigo)
);

create table tbItemCompra(
Qtd int not null,
ValorItem decimal (8,2) not null,
NotaFiscal int,
foreign key (NotaFiscal) references tbCompra (NotaFiscal),
CodigoBarras decimal (14,0),
foreign key (CodigoBarras) references tbProduto (CodigoBarras),
constraint tbItemCompra primary key (NotaFiscal,CodigoBarras)
);

create table tbEndereco(
lougradouro varchar (200) not null,
BairroId int,
foreign key (BairroId) references tbBairro (BairroId),
Cidade int,
foreign key (Cidade) references tbCidade (CidadeId),
UF int,
foreign key (UF) references tbEstado (UFId),
CEP decimal (8,0) primary key
);

create table tbCliente(
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd smallint not null,
CompEnd varchar (50),
CEP decimal (8,0),
foreign key (CEP) references tbEndereco (Cep)
);

create table tbVenda(
NumeroVenda int primary key,
DataVenda date,
TotalVenda decimal (8,2) not null,
NF int,
foreign key (NF) references tbNota_fiscal (NF),
Id_Cli int,
foreign key (Id_Cli) references tbCliente (Id)
);

create table tbItem_Venda(
Qtd int not null,
ValorItem decimal (8,2) not null,
CodigoBarras decimal (14,0),
foreign key (CodigoBarras) references tbProduto (CodigoBarras),
NumeroVenda int,
foreign key (NumeroVenda) references tbVenda (NumeroVenda),
constraint tbItem_Venda primary key (CodigoBarras,NumeroVenda)
);

create table tbcliente_PJ(
CNPJ decimal (14,0) primary key,
IE decimal (11,0) unique,
Id int,
foreign key (Id) references tbCliente (Id)
);

create table tbcliente_PF(
CPF decimal (11,0) primary key,
RG decimal (9,0) not null,
RG_Dig char (1) not null,
Nasc date not null,
Id int,
foreign key (Id) references tbCliente (Id)
);









create database dbdistribuidora;
use dbdistribuidora;

create table tbFornecedor(
Codigo int primary key auto_increment,
CNPJ decimal (14,0) unique,
Nome varchar (200) not null,
Telefone decimal (11,0)
);

create table tbCompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal (8,2) not null,
QtdTotal int not null,
Codigo int,
foreign key (Codigo) references tbFornecedor (Codigo)
);

create table tbProduto(
CodigoBarras decimal (14,0) primary key,
Nome varchar (200) not null,
ValorUnitario decimal (8,2) not null,
Qtd int
);

create table tbNota_fiscal(
NF int primary key,
TotalNota decimal (8,2) not null,
DataEmissao date not null
);

create table tbBairro(
BairroId int primary key auto_increment,
Bairro varchar (200) not null
);

create table tbCidade(
CidadeId int primary key auto_increment,
Cidade varchar (200) not null
);

create table tbEstado(
UFId int primary key auto_increment,
UF char (2) not null
);


create table tbItemCompra(
NotaFiscal int,
foreign key (NotaFiscal) references tbCompra (NotaFiscal),
CodigoBarras decimal (14,0),
foreign key (CodigoBarras) references tbProduto (CodigoBarras),
constraint tbItemCompra primary key (NotaFiscal,CodigoBarras),
ValorItem decimal (8,2) not null,
Qtd int not null
);

create table tbEndereco(
lougradouro varchar (200) not null,
CEP decimal (8,0) primary key,
BairroId int not null,
foreign key (BairroId) references tbBairro (BairroId),
CidadeId int not null,
foreign key (CidadeId) references tbCidade (CidadeId),
UFId int not null,
foreign key (UFId) references tbEstado (UFId)
);

create table tbCliente(
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd decimal (6,0) not null,
CompEnd varchar (50),
CEPCli decimal (8,0),
foreign key (CEPCli) references tbEndereco (CEP)
);

create table tbVenda(
NumeroVenda int primary key,
DataVenda date not null,
TotalVenda decimal (8,2) not null,
Id_Cli int not null,
foreign key (Id_Cli) references tbCliente (Id),
NF int,
foreign key (NF) references tbNota_fiscal (NF)
);

create table tbItem_Venda(
NumeroVenda int,
foreign key (NumeroVenda) references tbVenda (NumeroVenda),
CodigoBarras decimal (14,0),
foreign key (CodigoBarras) references tbProduto (CodigoBarras),
constraint tbItem_Venda primary key (NumeroVenda,CodigoBarras),
ValorItem decimal (8,2) not null,
Qtd int not null
);

create table tbcliente_PJ(
CNPJ decimal (14,0) primary key,
IE decimal (11,0) unique,
Id int,
foreign key (Id) references tbCliente (Id)
);

create table tbcliente_PF(
CPF decimal (11,0) primary key,
RG decimal (9,0) not null,
RG_Dig char (1) not null,
Nasc date not null,
Id int,
foreign key (Id) references tbCliente (Id)
);

-- Exercicio DML --
drop procedure spSelectFornecedor;

Delimiter $$
create procedure spSelectFornecedor(vNome varchar (200),vCNPJ decimal (14,0),vTelefone decimal (11,0))
Begin
insert into tbFornecedor (Nome,CNPJ,Telefone)
					values(vNome,vCNPJ,vTelefone);
END $$

call spSelectFornecedor('Revenda Chico Loco', 1245678937123, 11934567897);
call spSelectFornecedor('José Faz Tudo S/A', 1345678937123, 11934567898);
call spSelectFornecedor('Vadalto Entregas', 1445678937123, 11934567899);
call spSelectFornecedor('Astrogildo das Estrela', 1545678937123, 11934567800);
call spSelectFornecedor('Amoroso e Doce', 1645678937123, 11934567801);
call spSelectFornecedor('Marcelo Dedal', 1745678937123, 11934567802);
call spSelectFornecedor('Fransciscano Cachaça', 1845678937123, 11934567803);
call spSelectFornecedor('Joãozinho Chupeta', 1945678937123, 11934567804);

select * from tbFornecedor;

Delimiter $$
create procedure spSelectCidade(vCidade varchar (200))
Begin
insert into tbCidade (Cidade)
					values(vCidade);
END $$

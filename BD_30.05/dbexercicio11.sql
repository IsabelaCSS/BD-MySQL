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

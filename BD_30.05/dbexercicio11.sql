

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

call spSelectCidade('Rio de Janeiro');
call spSelectCidade('São Carlos');
call spSelectCidade('Campinas');
call spSelectCidade('Franco da Rocha');
call spSelectCidade('Osasco');
call spSelectCidade('Pirituba');
call spSelectCidade('lapa');
call spSelectCidade('Ponta Grossa');

select * from tbCidade;

Delimiter $$
create procedure spSelectEstado(vUF char(2))
Begin
insert into tbEstado (UF)
					values(vUF);
END $$

call spSelectEstado('SP');
call spSelectEstado('RS');
call spSelectEstado('RJ');


/* Exercício 4 */

Delimiter $$
create procedure spSelectBairro(vBairro varchar(200))
Begin 
insert into tbBairro(Bairro) values (vBairro);
END $$

call spSelectBairro('Aclimação');
call spSelectBairro('Capão Redondo');
call spSelectBairro('Pirituba');
call spSelectBairro('Liberdade');

select * from tbBairro;

/* Exercício 5 */

Delimiter $$
create procedure spSelectProduto(vCodigoBarras decimal (14,0), vNome varchar (200),vValorUnitario decimal (8,2),vQtd int)
Begin 
insert into tbProduto(CodigoBarras,Nome,ValorUnitario,Qtd) 
					values (vCodigoBarras,vNome,vValorUnitario,vQtd);
END $$

call spSelectProduto('12345678910111','Rei de Papel Mache','54.61','120');
call spSelectProduto('12345678910112','Bolinha de Sabão','100.45','120');
call spSelectProduto('12345678910113','Carro Bate','44.00','120');
call spSelectProduto('12345678910114','Bola Furada','10.00','120');
call spSelectProduto('12345678910115','Maçã Laranja','99.44','120');
call spSelectProduto('12345678910116','Boneoc de Hitler','124.00','200');
call spSelectProduto('12345678910117','Farinha de Suruói','50.00','200');
call spSelectProduto('12345678910118','Zelador de Cemitério','24.50','100');

/*
DECLARE lougradouro varchar (200) FALSE;
					        IF NOT EXISTS (SELECT 1 FROM tbEndereco WHERE lougradouro = 'Rua da Federal') THEN
					INSERT INTO minha_tabela (minha_coluna) VALUES (duplicado_value);
*/
Delimiter $$
create procedure spSelectEndereco(vlougradouro varchar (200), vBairro varchar (200),vCidade varchar (200),vUF varchar (200),vCEP decimal (8,0))
Begin 
insert into tbEndereco (lougradouro,BairroId,CidadeId,UFId,CEP)
					values (vlougradouro,vBairro,vCidade,vUF,vCEP);
         
END $$

select * from tbBairro;
select * from tbCidade;
call spSelectBairro('Lapa')
call spSelectCidade('São Paulo');
	call spSelectEndereco('Rua da Federal',5,9,1,'12345050');


call spSelectEndereco('Av Brasil',5,3,1,'12345051');


select * from tbBairro;
call spSelectBairro('Consolação');
	call spSelectEndereco('Rua Liberdade',6,9,1,'12345052');


select * from tbBairro;
call spSelectBairro('Penha');
	call spSelectEndereco('Av Paulista',7,1,3,'12345053');


call spSelectEndereco('Rua Ximbú',7,1,3,'12345054');


call spSelectEndereco('Rua Riu XI',7,3,1,'12345055');


select * from tbCidade;
call spSelectCidade('Barra Mansa')
	call spSelectEndereco('Rua Chocolate',1,10,3,'12345056');


select * from tbBairro;
call spSelectbairro('Barra Funda')
	call spSelectEndereco('Rua Pão na Chapa',8,8,2,'12345057');
    
    select * from tbEndereco;
/*
create view tb_Endereco
as select 
	tbEndereco.lougradouro,
	tbEndereco.CEP,
    tbBairro.Bairro,
    tbCidade.Cidade,
    tbEstado.UF 
    from tbEndereco inner join tbBairro
		on tbEndereco.BairroId = tbBairro.Bairro
	inner join tbCidade
		on tbEndereco.CidadeId = tbCidade.Cidade
	inner join tbEstado
		on tbEndereco.UFId = tbEstado.UF;
        
    select * from tb_Endereco;
    
    select lougradouro,Bairro,Cidade,UF,CEP from tb_Endereco;
*/


Delimiter $$
create procedure spSelectPF(vId int, vNomeCli varchar(200),vCidade varchar (200),vUF varchar (200),vCEP decimal (8,0))
Begin 
insert into tbEndereco (lougradouro,BairroId,CidadeId,UFId,CEP)
					values (vlougradouro,vBairro,vCidade,vUF,vCEP);
         
END $$


        create table tbcliente_PF(
CPF decimal (11,0) primary key,
RG decimal (9,0) not null,
RG_Dig char (1) not null,
Nasc date not null,
Id int,
foreign key (Id) references tbCliente (Id)
);

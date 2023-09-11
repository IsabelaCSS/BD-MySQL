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
-- Exercicio 1 --
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

-- Exercício 2 --
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

-- Exercício 3 --
Delimiter $$
create procedure spSelectEstado(vUF char(2))
Begin
insert into tbEstado (UF)
					values(vUF);
END $$

call spSelectEstado('SP');
call spSelectEstado('RS');
call spSelectEstado('RJ');


-- Exercício 4 --
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


-- Exercicio 5 --
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
call spSelectProduto('12345678910116','Boneco de Hitler','124.00','200');
call spSelectProduto('12345678910117','Farinha de Suruói','50.00','200');
call spSelectProduto('12345678910118','Zelador de Cemitério','24.50','100');

select * from tbProduto;


-- Exercicio 6 --
Delimiter $$
create procedure spSelectEndereco(vlougradouro varchar (200), vBairro varchar (200),vCidade varchar (200),vUF varchar (200),vCEP decimal (8,0))
Begin 
insert into tbEndereco (lougradouro,BairroId,CidadeId,UFId,CEP)
					values (vlougradouro,vBairro,vCidade,vUF,vCEP);
         
END $$

-- verifiquei em todas a tabela (Bairro, Cidade e Estado) se algum dado estava faltando, caso esteja adicionei em suas procedures --
select * from tbBairro;
select * from tbCidade;
call spSelectBairro('Lapa');
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
call spSelectCidade('Barra Mansa');
	call spSelectEndereco('Rua Chocolate',1,10,3,'12345056');


select * from tbBairro;
call spSelectbairro('Barra Funda');
	call spSelectEndereco('Rua Pão na Chapa',8,8,2,'12345057');
    
-- selecionei as tabelas e juntei em uma só na tabela tbEndereco --
select tbEndereco.lougradouro, tbBairro.Bairro, tbCidade.Cidade, tbEstado.UF, tbEndereco.CEP
         from tbEndereco
         inner join tbBairro
			on tbEndereco.BairroId = tbBairro.BairroId
         inner join tbCidade
			on tbEndereco.CidadeId = tbCidade.CidadeId
		inner join tbEstado
			on tbEndereco.UFId = tbEstado.UFId;


-- Exercício 7 --
Delimiter $$
create procedure spSelectClientePF(vCPF decimal (11,0),vRG decimal (9,0), vRG_Dig char (1),vNasc date, vId int)
Begin
		insert into tbCliente_PF(CPF, RG, RG_Dig, Nasc, Id)
					values (vCPF, vRG, vRG_Dig, vNasc, vId);
END $$

Delimiter $$
create procedure spSelectCliente(vNomeCli varchar(200),vNumEnd decimal (6,0), vCompEnd varchar(50), vCEPCli decimal (8,0)) 
Begin
		insert into tbCliente(NomeCli, NumEnd, CompEnd, CEPCli)
				values (vNomeCli, vNumEnd, vCompEnd, vCEPCli);
END $$

select * from tbEndereco; 
select * from tbCliente; 
select * from tbBairro; 
select * from tbCidade; 
select * from tbEstado;

select * from tbBairro;
call spSelectBairro('Jardim Santa Isabel');

select * from tbCidade;
call spSelectCidade('Cuiabá');

select * from tbEstado;
call spSelectEstado('MT');

 -- call tbEndereco (lougradouro,BairroId,CidadeId,UFId,CEP) --
call spSelectEndereco('Rua Veia',9,11,4,'12345059');
call spSelectEndereco('Av Nova',9,11,4,'12345058');


call spSelectCliente('Pimpão', '325', null, '12345051'); 
call spSelectClientePF('12345678911','12345678','0',STR_TO_DATE("12,10,2000","%d,%m,%Y"),1);

call spSelectCliente('Disney Chaplin','89','Ap.12','12345053');
call spSelectClientePF('12345678912','12345679','0',STR_TO_DATE("21,11,2001","%d,%m,%Y"),2);

call spSelectCliente('Marciano','744',null, '12345054');
call spSelectClientePF('12345678913','12345680','0',STR_TO_DATE("01,06,2001","%d,%m,%Y"),3);

call spSelectCliente('Lança Perfume','128', null, '12345059');
call spSelectClientePF('12345678914','12345681','X',STR_TO_DATE("05,04,2004","%d,%m,%Y"),4);

call spSelectCliente('Remédio Amargo','2585',null, '12345058');
call spSelectClientePF('12345678915','12345682','0',STR_TO_DATE("15,07,2002","%d,%m,%Y"),5);


select * from tbcliente;
select * from tbEndereco;
select * from tbBairro;
select * from tbCidade;
select * from tbEstado;
select * from tbcliente_PF;


-- Exercício 8 --
select * from tbBairro;
call spSelectBairro('Sei Lá');

select * from tbCidade;
call spSelectCidade('Recife');

select * from tbEstado;
call spSelectEstado('PE');

 -- call tbEndereco (lougradouro,BairroId,CidadeId,UFId,CEP) --
call spSelectEndereco('Rua dos Amores', 10, 12, 5, '12345060');

Delimiter $$
create procedure spSelectClientePJ(vCNPJ decimal (14,0), vIE decimal (11,0), vId int) 
Begin
		insert into tbCliente_PJ(CNPJ, IE, Id)
			values (vCNPJ, vIE, vId);
END $$


call spSelectCliente('Paganada','159', null, '12345059');
call spSelectClientePJ('12345678912345','98765432198',6);

call spSelectCliente('Caloteando','69', null, '12345053');
call spSelectClientePJ('12345678912346','98765432199',7);

call spSelectCliente('Semgrana','189', null, '12345060');
call spSelectClientePJ('12345678912347','98765432100',8);

call spSelectCliente('Cemreais','5024', 'Sala 23', '12345060');
call spSelectClientePJ('12345678912348','98765432101',9);

call spSelectCliente('Durango','1254', null, '12345060');
call spSelectClientePJ('12345678912349','98765432102',10);

/*
-- Exercício 9 --
drop procedure spInsertCompras;
Delimiter $$
create procedure spInsertCompras(vNotaFiscal int, vDataCompra date, vValorTotal decimal(8,2), vQtdTotal int, vCodigo int,
									vCodigoBarras decimal (14,0), vValorItem decimal (8,2), vQtd int) 
Begin
	If Exists(select Codigo from tbFornecedor where Codigo = vCodigo) 
        AND 
        (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) 
        THEN
		Insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo)
				values(vNotaFiscal, vDataCompra, vValorTotal, vQtdTotal, vCodigo);
    Else
		Insert into tbItemCompra(NotaFiscal, CodigoBarras, ValorItem, Qtd)
				values (vNotaFiscal, vCodigoBarras, vValorItem, vQtd);
    END if;
END $$

select * from tbFornecedor;
select * from tbproduto; 
describe tbCompra; 
describe tbItemCompra; 
describe tbproduto; 
describe tbFornecedor; 
describe tbNota_fiscal; 

 select tbCompra.NotaFiscal, tbFornecedor.Nome, tbCompra.DataCompra, tbProduto.CodigoBarras, 
 tbItemCompra.ValorItem, tbItemCompra.Qtd, tbCompra.QtdTotal, tbCompra.ValorTotal
         from tbCompra
         inner join tbNota_fiscal
			on tbCompra.NotaFiscal = tbNota_fiscal.NF
         inner join tbProduto
			on tbCompra.CidadeId = tbProduto.CodigoBarras
		inner join tbEstado
			on tbEndereco.UFId = tbEstado.UFId;

select * from tbCompra; 
select * from tb_ProdutoHistorico; 

insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo) 
			values ('8459', STR_TO_DATE("01,05,2018","%d,%m,%Y"),'21944.00','700',5);

insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo) 
			values ('2482', STR_TO_DATE("22,04,2020","%d,%m,%Y"),'7290.00','180',1);
            
insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo) 
			values ('21563', STR_TO_DATE("12,07,2020","%d,%m,%Y"),'900.00','300',6);
            
insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo) 
			values ('8459', STR_TO_DATE("04,12,2020","%d,%m,%Y"),'21944.00','700',5);
            
insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo) 
			values ('156354', STR_TO_DATE("23,11,2021","%d,%m,%Y"),'18900.00','350',1);



drop procedure spSelectItemVenda;

Delimiter $$
create procedure spSelectItemVenda(vNotaFiscal int, vCodigoBarras decimal (14,0), vValorItem decimal (8,2), vQtd int) 
Begin
		insert into tbItemCompra(NotaFiscal, CodigoBarras, ValorItem, Qtd)
				values (vNotaFiscal, vCodigoBarras, vValorItem, vQtd);
END $$

call spSelectItemVenda('8459','12345678910114','22.22','200');
 
 
-- Exercício 11 --	
select * from tbCliente;
select * from tbNota_fiscal;
select * from tbproduto;

drop procedure spSelecttbNota_fiscal;

Delimiter $$
create procedure spSelecttbNota_fiscal(vNF int, vTotalNota decimal (8,2), vDataEmissao date)
Begin
		Insert into tbNota_fiscal(NF, TotalNota, DataEmissao)
				values(vNF, vTotalNota, vDataEmissao); 
END $$

call spSelecttbNota_fiscal('359',STR_TO_DATE("05,09,2022","%d,%m,%Y"));
*/


-- Exercício 12 --	
call spSelectProduto('12345678910130','Camiseta de Políester', '35.61','100');
call spSelectProduto('12345678910131','Blusa Frio Moletom', '200.00','100');
call spSelectProduto('12345678910132','Vestido Decote Redondo', '144.00','50');


-- Exercício 13 --	
drop procedure ApagarRegistro;
Delimiter $$
create procedure ApagarRegistro(vCodigoBarras decimal (14,0))
Begin
    	delete from tbProduto where vCodigoBarras = CodigoBarras;
END $$

call ApagarRegistro('12345678910116');
call ApagarRegistro('12345678910117');

select * from tbProduto;


-- Exercício 15 --
Delimiter $$
create procedure spSelecttbProduto()
Begin
		select * from tbProduto;
END $$

call spSelecttbProduto();


-- Exercício 16 --
create table tb_ProdutoHistorico like tbProduto; 
describe tb_ProdutoHistorico;


-- Exercício 17 --
alter table tb_ProdutoHistorico add Ocorrencia varchar(20); 
alter table tb_ProdutoHistorico add Atualizacao datetime;
describe tb_ProdutoHistorico;


-- Exercício 18 --
alter table tb_ProdutoHistorico drop primary key; 
alter table tb_ProdutoHistorico add primary key(CodigoBarras, Ocorrencia, Atualizacao);
describe tb_ProdutoHistorico;


-- Exercício 19 --
Delimiter $$ 
create procedure spInsertHistorico(vCodigoBarras decimal (14,0), vNome varchar (200), vValorUnitario decimal (8,2), vQtd int) 
Begin
		Insert into tbProduto(CodigoBarras, Nome, ValorUnitario, Qtd)
    			values(vCodigoBarras, vNome, vValorUnitario, vQtd); 
    
    		Insert into tb_ProdutoHistorico(CodigoBarras, Nome, ValorUnitario, Qtd, Ocorrencia, Atualizacao)
    			values(vCodigoBarras, vNome, vValorUnitario, vQtd, 'Novo', current_timestamp());
END $$ 

call spInsertHistorico ('12345678910119', 'Agua mineral', '1.99', '500');

select * from tbProduto; 
select * from tb_ProdutoHistorico;


-- Exercício 20 --
Delimiter $$ 
create procedure spInsertAtt(vCodigoBarras decimal (14,0), vNome varchar (200), vValorUnitario decimal (8,2), vQtd int) 
Begin
	UPDATE tbProduto
	SET CodigoBarras = vCodigoBarras, Nome = vNome, ValorUnitario = vValorUnitario, Qtd = vQtd
	WHERE CodigoBarras = vCodigoBarras;
    
   If exists(select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) THEN
    	Insert into tb_ProdutoHistorico(CodigoBarras, Nome, ValorUnitario, Qtd, Ocorrencia, Atualizacao)
    		values(vCodigoBarras, vNome, vValorUnitario, vQtd, 'Atualizado', current_timestamp());
    
   Else 
    	Insert into tb_ProdutoHistorico(CodigoBarras, Nome, ValorUnitario, Qtd, Ocorrencia, Atualizacao)
    		values(vCodigoBarras, vNome, vValorUnitario, vQtd, 'Novo', current_timestamp());
    END if;
END $$

call spInsertAtt ('12345678910119', 'teste', '800.20', '200');

select * from tbProduto; 
select * from tb_ProdutoHistorico;


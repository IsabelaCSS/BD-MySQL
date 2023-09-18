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
create procedure spInsertFornecedor(vNome varchar (200),vCNPJ decimal (14,0),vTelefone decimal (11,0))
Begin
insert into tbFornecedor (Nome,CNPJ,Telefone)
					values(vNome,vCNPJ,vTelefone);
END $$

call spInsertFornecedor('Revenda Chico Loco', 1245678937123, 11934567897);
call spInsertFornecedor('José Faz Tudo S/A', 1345678937123, 11934567898);
call spInsertFornecedor('Vadalto Entregas', 1445678937123, 11934567899);
call spInsertFornecedor('Astrogildo das Estrela', 1545678937123, 11934567800);
call spInsertFornecedor('Amoroso e Doce', 1645678937123, 11934567801);
call spInsertFornecedor('Marcelo Dedal', 1745678937123, 11934567802);
call spInsertFornecedor('Fransciscano Cachaça', 1845678937123, 11934567803);
call spInsertFornecedor('Joãozinho Chupeta', 1945678937123, 11934567804);

select * from tbFornecedor;

-- Exercício 2 --
Delimiter $$
create procedure spInsertCidade(vCidade varchar (200))
Begin 
	IF NOT EXISTS (SELECT Cidade FROM tbCidade Where Cidade = vCidade) THEN
		Insert into tbCidade (Cidade) values (vCidade);
	End if;
END $$

call spInsertCidade('Rio de Janeiro');
call spInsertCidade('São Carlos');
call spInsertCidade('Campinas');
call spInsertCidade('Franco da Rocha');
call spInsertCidade('Osasco');
call spInsertCidade('Pirituba');
call spInsertCidade('lapa');
call spInsertCidade('Ponta Grossa');

select * from tbCidade;

-- Exercício 3 --
Delimiter $$
create procedure spInsertEstado(vUF char(2))
Begin
	IF NOT EXISTS (SELECT UF FROM tbEstado Where UF = vUF) THEN
		Insert into tbEstado (UF) values (vUF);
End if;
END $$

call spInsertEstado('SP');
call spInsertEstado('RS');
call spInsertEstado('RJ');

select * from tbEstado;

-- Exercício 4 --
Delimiter $$
create procedure spInsertBairro(vBairro varchar(200))
Begin 
	IF NOT EXISTS (SELECT Bairro FROM tbBairro Where Bairro = vBairro) THEN
		Insert into tbBairro (Bairro) values (vBairro);
     End if;   
END $$

call spInsertBairro('Aclimação');
call spInsertBairro('Capão Redondo');
call spInsertBairro('Pirituba');
call spInsertBairro('Liberdade');

select * from tbBairro;


-- Exercicio 5 --
Delimiter $$
create procedure spInsertProduto(vCodigoBarras decimal (14,0), vNome varchar (200),vValorUnitario decimal (8,2),vQtd int)
Begin 
	IF NOT EXISTS (SELECT CodigoBarras FROM tbProduto where CodigoBarras = vCodigoBarras) THEN
		Insert into tbProduto (CodigoBarras, Nome, ValorUnitario, Qtd) values (vCodigoBarras, vNome, vValorUnitario, vQtd);
	End if;
END $$

call spInsertProduto (12345678910111, 'Rei de Papel Mache', 54.61, 120);
call spInsertProduto (12345678910112, 'Bolinha de Sabão', 100.45, 120);
call spInsertProduto (12345678910113, 'Carro Bate', 44.00, 120);
call spInsertProduto (12345678910114, 'Bola Furada', 10.00, 120);
call spInsertProduto (12345678910115, 'Maçã Laranja', 99.44, 120);
call spInsertProduto (12345678910116, 'Boneco do Hitler', 124.00, 200);
call spInsertProduto (12345678910117, 'Farinha de Suruí', 50.00, 200);
call spInsertProduto (12345678910118, 'Zalador de Cemitério', 24.50, 100);
call spInsertProduto('12345678910111','Rei de Papel Mache','54.61','120');
call spInsertProduto('12345678910112','Bolinha de Sabão','100.45','120');
call spInsertProduto('12345678910113','Carro Bate','44.00','120');
call spInsertProduto('12345678910114','Bola Furada','10.00','120');
call spInsertProduto('12345678910115','Maçã Laranja','99.44','120');
call spInsertProduto('12345678910116','Boneco de Hitler','124.00','200');
call spInsertProduto('12345678910117','Farinha de Suruói','50.00','200');
call spInsertProduto('12345678910118','Zelador de Cemitério','24.50','100');

select * from tbProduto;


-- Exercicio 6 --
Delimiter $$
create procedure spInsertEndereco(vlougradouro varchar (200), vBairro varchar (200),vCidade varchar (200),vUF varchar (200),vCEP decimal (8,0))
Begin 
		IF NOT EXISTS (SELECT Bairro FROM tbBairro where Bairro = vBairro) THEN
              Insert into tbBairro (Bairro)
					 values (vBairro);
		END IF;
                  
		IF NOT EXISTS (SELECT Cidade FROM tbCidade where Cidade = vCidade) THEN
              Insert into tbCidade(Cidade)
                     values (vCidade);
		END IF;
        
		IF NOT EXISTS (SELECT UF FROM tbEstado where UF = vUF) THEN
              Insert into tbEstado (UF)
                     values (vUF);
		END IF;
        
		Insert into tbEndereco (lougradouro, BairroId, CidadeId, UFId, CEP)
									values (vlougradouro, (SELECT Bairroid FROM tbBairro where Bairro = vBairro), 
	
		(SELECT CidadeId FROM tbCidade where Cidade = vCidade), 
			(SELECT UFId FROM tbEstado where UF = vUF), vCEP);
END $$
     	 
call spInsertEndereco ('Rua da Federal', 'Lapa', 'São Paulo', 'SP', 12345050);
call spInsertEndereco ('Av Brasil', 'Lapa', 'Campinas', 'SP', 12345051);
call spInsertEndereco ('Rua Liberdade', 'Consolação', 'Campinas', 'SP', 12345052);
call spInsertEndereco ('Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ', 12345053);
call spInsertEndereco ('Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ', 12345054);
call spInsertEndereco ('Rua Piu XI', 'Penha', 'Campinas', 'SP', 12345055);
call spInsertEndereco ('Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ', 12345056);
call spInsertEndereco ('Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS', 12345057);
    
    
select * from tbEndereco;


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
create procedure spInsertClientePF(vNomeCli varchar(200),vNumEnd decimal (6,0), vCompEnd varchar(50),vCEP decimal (8,0),
									vCPF decimal (11,0),vRG decimal (9,0), vRG_Dig char (1),vNasc date,
                                    vlougradouro varchar (200), vBairro varchar (200),vCidade varchar (200),vUF varchar (200))
Begin
    IF NOT EXISTS (SELECT CEP from tbEndereco where CEP = vCEP) THEN
		call spInsertEndereco (vlougradouro, vBairro, vCidade, vUF, vCEP);
	END IF;
    
		IF NOT EXISTS (select CPF from tbcliente_PF where CPF = vCPF) THEN
			insert into tbCliente (NomeCli, NumEnd, CompEnd, CEPCli)
				values (vNomeCli, vNumEnd, vCompEnd, (select CEP from tbEndereco where CEP = vCEP));
			insert into tbCliente_PF (Id, CPF, RG, RG_Dig, Nasc)
				values ((select Id from tbCliente where NomeCli = vNomeCli and NumEnd = vNumEnd), vCPF, vRG, vRG_Dig, vNasc);
		END IF;    
END $$


call spInsertClientePF('Pimpão', 325, null, 12345051, 12345678911, 12345678, 0, STR_TO_DATE("12,10,2000","%d,%m,%Y"), 'Av Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertClientePF('Disney Chaplin', 89, 'Ap.12', 12345053, 12345678912, 12345679, 0, STR_TO_DATE("21,11,2001","%d,%m,%Y"), 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePF('Marciano', 744, null, 12345054, 12345678913, 12345680, 0, STR_TO_DATE("01,06,2001","%d,%m,%Y"), 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePF('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', STR_TO_DATE("05,04,2004","%d,%m,%Y"), 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT');
call spInsertClientePF('Remédio Amargo', 2585, null, 12345058, 12345678915, 12345682, 'X', STR_TO_DATE("15,07,2002","%d,%m,%Y"), 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT');

select * from tbcliente;
select * from tbEndereco;
select * from tbBairro;
select * from tbCidade;
select * from tbEstado;
select * from tbcliente_PF;

-- Exercício 8 --
drop procedure spInsertClientePJ;
describe tbcliente_PJ;

Delimiter $$
create procedure spInsertClientePJ(vNomeCli varchar(200),vCNPJ varchar (14), vIE decimal (11,0),vCEP varchar (12),
										vlougradouro varchar (200),vNumEnd decimal (6,0), vCompEnd varchar(50),
											vBairro varchar (200),vCidade varchar (200),vUF char (2))
Begin
    IF NOT EXISTS (SELECT CEP from tbEndereco where CEP = vCEP) THEN
		call spInsertEndereco (vlougradouro, vBairro, vCidade, vUF, vCEP);
	END IF;
		IF NOT EXISTS (select NomeCli from tbCliente where NomeCli = vNomeCli) THEN
			insert into tbCliente (NomeCli, NumEnd, CompEnd, CEPCli)
				values (vNomeCli, vNumEnd, vCompEnd, (select CEP from tbEndereco where CEP = vCEP));
		END IF;
        IF NOT EXISTS (select UF from tbEstado where UF = vUF) then
			insert into tbEstado (UF)
				values (vUF);
        end if;
        
		IF NOT EXISTS (select CNPJ from tbcliente_PJ where CNPJ = vCNPJ) THEN
			insert into tbcliente_PJ (CNPJ, IE, Id)
				values (vCNPJ, vIE, (select Id from tbCliente where NomeCli = vNomeCli and NumEnd = vNumEnd and CEPCli = (select CEP from tbEndereco where CEP = vCEP) LIMIT 1));
		END IF;    
END $$

call spInsertClientePJ('Paganada', '12345678912345',98765432198, 12345051, 'Av Brasil', 159, null, 'Lapa', 'Campinas', 'SP');
call spInsertClientePJ('Caloteando', '12345678912346', 98765432199, 12345053, 'Av Paulista', 69, null, 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePJ('Semgrana', '12345678912347', 98765432100, 12345060, 'Av Paulista', 189, 'Sala 23', 'Sei lá', 'Recife', 'PE');
call spInsertClientePJ('Durango', '12345678912349', 98765432102, 12345060, 'Av Paulista', 1254, null, 'Sei lá', 'Recife', 'PE');

select * from tbcliente;
select * from tbEndereco;
select * from tbBairro;
select * from tbCidade;
select * from tbEstado;
select * from tbcliente_PJ;


-- Exercício 9 --
select * from tbCompra;
select * from tbFornecedor;
select * from tbItemCompra;
describe tbFornecedor;

drop procedure spInsertCompras;

Delimiter $$
create procedure spInsertCompras(vNotaFiscal int, vNome varchar (200), vDataCompra date,vCodigoBarras decimal (14,0), 
									vValorItem decimal (8,2), vQtd int, vQtdTotal int, vValorTotal decimal(8,2)) 
Begin
    IF NOT EXISTS (SELECT Nome FROM tbFornecedor WHERE Nome = vNome) THEN
        INSERT INTO tbFornecedor (Nome)
        VALUES (vNome);
    END IF;

    IF NOT EXISTS (SELECT NotaFiscal FROM tbCompra WHERE NotaFiscal = vNotaFiscal) THEN
        INSERT INTO tbCompra (NotaFiscal, DataCompra, ValorTotal, QtdTotal)
        VALUES (vNotaFiscal, vDataCompra, vValorTotal, vQtdTotal);
    END IF;

    IF NOT EXISTS (SELECT CodigoBarras FROM tbItemCompra WHERE CodigoBarras = vCodigoBarras) THEN
        INSERT INTO tbItemCompra (NotaFiscal, CodigoBarras, ValorItem, Qtd)
        VALUES (vNotaFiscal, vCodigoBarras, vValorItem, vQtd);
    END IF;
END $$

call spInsertCompras(8459,'Amoroso e Doce', STR_TO_DATE("01,05,2018","%d,%m,%Y"), 12345678910111, 22.22, 200, 700, '21944.00');
call spInsertCompras(2482,'Revenda Chico Loco', STR_TO_DATE("22,04,2020","%d,%m,%Y"), 12345678910112, 40.50, 180, 180, '7290.00');
call spInsertCompras(21563,'Marcelo Dedal', STR_TO_DATE("12,07,2020","%d,%m,%Y"), 12345678910113, 3.00, 300, 300, '900.00');
call spInsertCompras(8459,'Amoroso e Doce', STR_TO_DATE("04,12,2020","%d,%m,%Y"), 12345678910114, 35.00, 500, 700, '21944.00');
call spInsertCompras(156354,'Revenda Chico Loco', STR_TO_DATE("23,11,2021","%d,%m,%Y"), 12345678910115, 54.00, 350, 350, '18900.00');

select * from tbCompra;
select * from tbFornecedor;
select * from tbItemCompra;

 
-- Exercício 11 --	
Delimiter $$
create procedure spSelecttbNota_fiscal(vNF int, vNomeCli varchar (200), vDataEmissao date,vTotalNota decimal (8,2))
Begin
	
    IF NOT EXISTS (SELECT NF FROM tbNota_fiscal WHERE NF = vNF) THEN
        INSERT INTO tbNota_fiscal (NF,TotalNota,DataEmissao)
        VALUES (vNF,vTotalNota,vDataEmissao);
    END IF;
    
    IF NOT EXISTS (SELECT NomeCli FROM tbCliente WHERE NomeCli = vNomeCli) THEN
        INSERT INTO tbCliente (NomeCli)
        VALUES (vNomeCli);
    END IF;
END $$

call spSelecttbNota_fiscal(359,'Pimpão',STR_TO_DATE("05,09,2022","%d,%m,%Y"),00.00);
call spSelecttbNota_fiscal(360,'Lança Perfume',STR_TO_DATE("05,09,2022","%d,%m,%Y"),00.00);

select * from tbCliente;
select * from tbNota_fiscal;



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
    
    insert into tb_ProdutoHistorico(CodigoBarras, Nome, ValorUnitario, Qtd, Ocorrencia, Atualizacao)
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
    insert into tb_ProdutoHistorico(CodigoBarras, Nome, ValorUnitario, Qtd, Ocorrencia, Atualizacao)
    values(vCodigoBarras, vNome, vValorUnitario, vQtd, 'Novo', current_timestamp());
    END if;
END $$

call spInsertAtt ('12345678910119', 'teste', '800.20', '200');

select * from tbProduto; 
select * from tb_ProdutoHistorico;


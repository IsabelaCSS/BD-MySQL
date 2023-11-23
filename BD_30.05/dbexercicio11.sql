create database dbDistribuidora; 
use dbDistribuidora;

create table tbCliente( 
ID int primary key auto_increment, 
NomeCli varchar(200) not null, 
NumEnd smallint not null, 
CompEnd varchar(50), 
CepCli numeric(8) not null 
);

create table tbClientePF( 
CPF numeric(11) primary key,
RG numeric(9) not null, 
RG_Dig char(1) not null, 
Nasc date not null, 
ID int not null 
);

create table tbClientePJ( 
CNPJ numeric(14) primary key, 
IE numeric(11) not null unique, 
ID int not null 
); 

create table tbEndereco( 
logradouro varchar(200) not null, 
CEP numeric(8) primary key, 
BairroID int not null, 
CidadeID int not null, 
UFID int not null 
); 

create table tbBairro( 
BairroID int primary key auto_increment, 
Bairro varchar(200) not null 
);

create table tbCidade( 
CidadeID int primary key auto_increment, 
Cidade varchar(200) not null 
);

create table tbEstado( 
UFID int primary key auto_increment, 
UF char(2) not null 
);

create table tbFornecedor( 
Cod int primary key auto_increment, 
CNPJ decimal (14,0) unique, 
Nome varchar (200) not null, 
Telefone decimal (11,0) 
); 

create table tbProduto( 
CodigoBarras numeric(14) primary key, 
Nome varchar(200) not null, 
Valor decimal(8,3), 
Qtd int 
);

create table tbCompra( 
NotaFiscal int primary key, 
DataCompra date not null, 
ValorTotal decimal (8,3) not null,
QtdTotal int not null, 
Cod int 
);

create table tbItemCompra ( 
NotaFiscal int, 
CodigoBarras numeric(14), 
ValorItem decimal (8,3) not null, 
Qtd int not null, 
primary key (NotaFiscal, CodigoBarras) 
); 

create table tbVenda( 
NumeroVenda int primary key, 
DataVenda date not null, 
TotalVenda decimal (8,3) not null, 
ID_Cli int not null, 
NF int 
);

create table tbItemVenda( 
NumeroVenda int, 
CodigoBarras decimal (14,0),
ValorItem decimal (8,3) not null, 
Qtd int not null, 
primary key (NumeroVenda, CodigoBarras) 
);

create table tbNota_Fiscal( 
NF int primary key, 
TotalNota decimal (8,3) not null, 
DataEmissao date not null 
);

alter table tbClientePF add foreign key (ID) references tbCliente(ID);
alter table tbClientePJ add foreign key (ID) references tbCliente(ID); 
alter table tbCliente add foreign key (CepCli) references tbEndereco(CEP);

alter table tbEndereco add foreign key (BairroID) references tbBairro(BairroID); 
alter table tbEndereco add foreign key (CidadeID) references tbCidade(CidadeID); 
alter table tbEndereco add foreign key (UFID) references tbEstado(UFID);

alter table tbCompra add foreign key (Cod) references tbFornecedor (Cod); 
alter table tbItemCompra add foreign key (NotaFiscal) references tbCompra (NotaFiscal); 
alter table tbItemCompra add foreign key (CodigoBarras) references tbProduto (CodigoBarras);

alter table tbVenda add foreign key (NF) references tbNota_Fiscal (NF); 
alter table tbVenda add foreign key (ID_Cli) references tbCliente (ID);

alter table tbItemVenda add foreign key (NumeroVenda) references tbVenda (NumeroVenda); 
alter table tbItemVenda add foreign key (CodigoBarras) references tbProduto (CodigoBarras);

-- EXERCICIO 1 --
delimiter && 
create procedure spinsertForne(vCNPJ decimal(14,0), vNome varchar (200), vTelefone decimal (11,0)) 
begin
IF NOT EXISTS (select CNPJ from tbFornecedor where CNPJ = vCNPJ) then
insert into tbFornecedor(CNPJ, Nome, Telefone)
    values(vCNPJ, vNome, vTelefone);
    end if;
end &&

call spinsertForne(1245678927123, 'Revenda Chico Loco', '11934567897'); 
call spinsertForne(1345678927123, 'Jose Faz Tudo S/A', '11934567898'); 
call spinsertForne(1445678927123, 'Vadalto Entregas', '11934567899'); 
call spinsertForne(1545678927123, 'Astrogildo das Estrela', '11934567800');
call spinsertForne(1645678927123, 'Amoroso e Doce', '11934567801'); 
call spinsertForne(1745678927123, 'Marcelo Dedal', '11934567802'); 
call spinsertForne(1845678927123, 'Fransciscano Cachaça', '11934567803');
call spinsertForne(1945678927123, 'Joãozinho Chupeta', '11934567804');

Select * from tbFornecedor;

-- EXERCICIO 2 --
delimiter && 
create procedure spinsertCidade(vCidade varchar (200)) 
begin
IF NOT EXISTS  (select Cidade from tbCidade where Cidade = vCidade) then
insert into tbCidade(CidadeID, Cidade)
    values(default,vCidade);
    end if;
end &&

call spinsertCidade('Rio de Janeiro'); 
call spinsertCidade('São Carlos'); 
call spinsertCidade('Campinas'); 
call spinsertCidade('Franco da Rocha'); 
call spinsertCidade('Osasco'); 
call spinsertCidade('Pirituba');
call spinsertCidade('Lapa'); 
call spinsertCidade('Ponta Grossa');

Select * from tbCidade;

-- EXERCICIO 3 --
delimiter && 
create procedure spinsertEstado(vUF char (2)) 
begin
IF NOT EXISTS (select UF from tbEstado where UF = vUF) then 
	insert into tbEstado(UFID, UF) 
		values(default,vUF); 
end if; 
end &&

call spinsertEstado('SP'); 
call spinsertEstado('RJ'); 
call spinsertEstado('RS');

Select * from tbEstado;

-- EXERCICIO 4 --
delimiter && 
create procedure spinsertBairro(vBairro varchar (200)) 
begin
IF NOT EXISTS (select Bairro from tbBairro WHERE Bairro = vBairro) then 
	insert into tbBairro(BairroID, Bairro) 
			values(default,vBairro); 
	end if; 
end &&

call spinsertBairro('Aclimação'); 
call spinsertBairro('Capão Redondo'); 
call spinsertBairro('Pirituba'); 
call spinsertBairro('Liberdade');

Select * from tbBairro;

-- EXERCICIO 5 --
delimiter && 
create procedure spinsertproduto(vCodigoBarras numeric(14), vNome varchar (200), vValor decimal (8,2), vQtd int) 
begin 
IF NOT EXISTS (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) then 
	insert into tbProduto(CodigoBarras, Nome, Valor, Qtd) 
			values(vCodigoBarras, vNome, vValor, vQtd); 
	end if; 
end &&

call spinsertproduto(12345678910111,'Rei de Rapel Mache', 54.61, 120); 
call spinsertproduto(12345678910112,'Bolinha de Sabao', 100.45, 120); 
call spinsertproduto(12345678910113,'Carro Bate ', 44.00, 120); 
call spinsertproduto(12345678910114,'Bola Furada', 10.00, 120); 
call spinsertproduto(12345678910115,'Maçã Laranja', 99.44, 120); 
call spinsertproduto(12345678910116,'Boneco do Hitler', 124.00, 200); 
call spinsertproduto(12345678910117,'Farinha de Suruí', 50.00, 200); 
call spinsertproduto(12345678910118,'Zelador de Cemitério', 24.50, 100);

Select * from tbProduto;

-- EXERCICIO 6 --
delimiter && 
create procedure spinsertendereco(vCEP numeric(8), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2)) 
begin
IF NOT EXISTS (select UF from tbEstado where UF = vUF) then 
	insert into tbEstado(UFID, UF) 
		values(default, vUF); 
	end if; 
IF NOT EXISTS (select Cidade from tbCidade where Cidade = vCidade) then 
	insert into tbCidade(CidadeID, Cidade) 
		values(default, vCidade); 
	end if; 
IF NOT EXISTS (select Bairro from tbBairro where Bairro = vBairro) then 
	insert into tbBairro(BairroID, Bairro) 
			values(default, vBairro); 
		end if;
IF NOT EXISTS  (select CEP from tbEndereco where CEP = vCEP) then
	insert into tbEndereco(CEP, Logradouro, BairroID, CidadeID, UFID)
		values (vCEP, vLogradouro, (select BairroID from tbBairro where Bairro = vBairro), 
        (select CidadeID from tbCidade where Cidade = vCidade), 
        (select UFID from tbEstado where UF = vUF));
	end if;
end &&

call spinsertendereco(12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP'); 
call spinsertendereco(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP'); 
call spinsertendereco(12345052, 'Rua Liberdade', 'Consolação', 'São Paulo', 'SP'); 
call spinsertendereco(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ'); 
call spinsertendereco(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ'); 
call spinsertendereco(12345055, 'Rua Piu XI', 'Penha', 'Campinas', 'SP'); 
call spinsertendereco(12345056, 'Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ'); 
call spinsertendereco(12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS');

Select * from tbEndereco;

-- EXERCICIO 7 --
delimiter && 
create procedure spinsertclientepf(vNomeCli varchar(200), vNumEnd smallint, vCompEnd varchar(50), vCepCli numeric(8), 
									vCPF numeric(11), vRG numeric(8), vRG_Dig char(1), vNasc date, vLogradouro varchar(200), 
                                    vBairro varchar(200), vCidade varchar(200), vUF char(2)) 
begin
IF NOT EXISTS (select UF from tbEstado where UF = vUF) then 
	insert into tbEstado(UFID, UF) 
		values(default, vUF); 
end if;
IF NOT EXISTS (select Cidade from tbCidade where Cidade = vCidade) then
	insert into tbCidade(CidadeID, Cidade)
		values(default, vCidade);
end if;
IF NOT EXISTS (select Bairro from tbBairro where Bairro = vBairro) then
	insert into tbBairro(BairroID, Bairro)
		values(default, vBairro);
end if;
IF NOT EXISTS  (select CEP from tbEndereco where CEP = vCepCli) then
	insert into tbEndereco(CEP, Logradouro, BairroID, CidadeID, UFID)
		values (vCepCli, vLogradouro, (select BairroID from tbBairro where Bairro = vBairro), 
        (select CidadeID from tbCidade where Cidade = vCidade), 
        (select UFID from tbEstado where UF = vUF));
end if;
IF NOT EXISTS (select CPF from tbClientePF where CPF = vCPF) then 
	insert into tbCliente(NomeCli, NumEnd, CompEnd, CepCli) 
		values (vNomeCli, vNumEnd, vCompEnd, vCepCli);

      insert into tbClientePF(ID, CPF, RG, RG_Dig, Nasc)
    values ((select ID from tbCliente where NomeCli = vNomeCli), vCPF, vRG, vRG_Dig, vNasc);
end if; 
end &&

call spinsertclientepf('Pimpão', 325, null, 12345051, 12345678911, 12345678, 0, '2000-10-12', 'Av Brasil', 'Lapa', 'Campinas', 'SP'); 
call spinsertclientepf('Disney Chaplin', 89, 'Ap. 12', 12345053, 12345678912, 12345679, 0, '2001-11-21', 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ'); 
call spinsertclientepf('Marciano', 744, null, 12345054, 12345678913, 12345680, 0, '2001-06-01', 'rua ximbú', 'Penha', 'Rio de Janeiro', 'RJ'); 
call spinsertclientepf('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004-04-05', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT'); 
call spinsertclientepf('Remédio Amargo', 2585, null, 12345058, 12345678915, 12345682, 0, '2002-07-15', 'Av Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT');

Select * from tbClientePF;
Select * from tbCliente;

-- EXERCICIO 8 --
delimiter && 
create procedure spinsertclientepj(vNomeCli varchar(200), vNumEnd smallint, vCompEnd varchar(50), vCepCli numeric(8), 
									vCNPJ numeric(14), vIE numeric(11), vLogradouro varchar(200), vBairro varchar(200),
                                    vCidade varchar(200), vUF char(2)) 
begin
IF NOT EXISTS (select UF from tbEstado where UF = vUF) then 
	insert into tbEstado(UFID, UF) 
		values(default, vUF); 
end if;
IF NOT EXISTS (select Cidade from tbCidade where Cidade = vCidade) then
	insert into tbCidade(CidadeID, Cidade)
		values(default, vCidade);
end if;
IF NOT EXISTS (select Bairro from tbBairro where Bairro = vBairro) then
	insert into tbBairro(BairroID, Bairro)
		values(default, vBairro);
end if;
IF NOT EXISTS  (select CEP from tbEndereco where CEP = vCepCli) then
	insert into tbEndereco(CEP, Logradouro, BairroID, CidadeID, UFID)
		values (vCepCli, vLogradouro, (select BairroID from tbBairro where Bairro = vBairro), 
										(select CidadeID from tbCidade where Cidade = vCidade), 
										(select UFID from tbEstado where UF = vUF));
end if;
IF NOT EXISTS (select CNPJ from tbClientePJ where CNPJ = vCNPJ) then 
	insert into tbCliente(NomeCli, NumEnd, CompEnd, CepCli) 
		values (vNomeCli, vNumEnd, vCompEnd, vCepCli);
      insert into tbClientePJ(ID, CNPJ, IE)
			values ((select ID from tbCliente where NomeCli = vNomeCli), vCNPJ, vIE);
end if; 
end &&

call spinsertclientepj('Paganada', 159, null, 12345051, 12345678912345, 98765432198, 'Av Brasil', 'Lapa', 'Campinas', 'SP'); 
call spinsertclientepj('Caloteando', 69, null, 12345053, 12345678912346, 98765432199, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ'); 
call spinsertclientepj('Semgrana', 189, null, 12345060, 12345678912347, 98765432100, 'Rua dos Amores', 'Sei Lá', 'Recife', 'PE'); 
call spinsertclientepj('Cemreais', 5024, 'Sala 23', 12345060, 12345678912348, 98765432101, 'Rua dos Amores', 'Sei Lá', 'Recife', 'PE'); 
call spinsertclientepj('Durango', 1254, null, 12345060, 12345678912349, 98765432102, 'Rua dos Amores', 'Sei Lá', 'Recife', 'PE');

Select * from tbClientePJ;

-- EXERCICIO 9 --
drop procedure spinsertcompra;
delimiter && 
create procedure spinsertcompra(vNotaFiscal int, vNome varchar(200), vDataCompra char(10), vCodigoBarras numeric(14), vValorItem decimal(8,3),
								vQtdTotal int, vValorTotal decimal(8,2)) 
begin 
if (select Cod from tbFornecedor where Nome = vNome) then 
set @fornecedor = (select Cod from tbFornecedor where Nome = vNome);

if not exists (select NF from tbNota_Fiscal where NF = vNotaFiscal) then
		insert into tbNota_Fiscal(NF, TotalNota, DataEmissao) 
            values (vNotaFiscal, vValorTotal, str_to_date(vDataCompra, '%d/%m/%Y'));
		insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Cod) 
            values (vNotaFiscal, str_to_date(vDataCompra, '%d/%m/%Y'), vValorTotal, vQtdTotal, @fornecedor);
		insert into tbItemCompra(Qtd, ValorItem, NotaFiscal, CodigoBarras) 
            values (vQtdTotal, vValorItem, vNotaFiscal, vCodigoBarras);
		else
			if not exists(select * from tbItemCompra where NotaFiscal = vNotaFiscal and CodigoBarras = vCodigoBarras) then
				insert into tbItemCompra(Qtd, ValorItem, NotaFiscal, CodigoBarras) 
                values (vQtdTotal, vValorItem, vNotaFiscal, vCodigoBarras);
			end if;
        end if;
	end if;
end &&

call spinsertcompra (8459,'amoroso e doce', '01/05/2018' , 12345678910111, 22.22, 700, 21944.00); 
call spinsertcompra (2482,'revenda chico loco', '22/04/2020' , 12345678910112, 40.50, 180, 7290.00); 
call spinsertcompra (21563,'marcelo dedal', '12/07/2020', 12345678910113, 3.00, 300, 900.00);
call spinsertcompra (8459,'amoroso e doce', '01/05/2018', 12345678910114, 35.00, 500, 21944.00);
call spinsertcompra (156354,'revenda chico loco', '23/11/2021', 12345678910115, 54.00, 350, 18900.00);

Select * from tbCompra;

-- EXERCICIO 10 --
delimiter && 
create procedure spinsertvenda(vNumeroVenda int, vNomeCli varchar(200), vCodigoBarras numeric(14,0), vValorItem decimal(8,3), vQtd int, vTotalVenda decimal(8,3)) 
begin 
if exists (select ID from tbCliente where NomeCli = vNomeCli) and exists (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras)then
		set @ID = (select ID from tbCliente where NomeCli = vNomeCli);
 
		if not exists (select NumeroVenda from tbVenda where NumeroVenda = vNumeroVenda) then 
				insert into tbvenda (NumeroVenda, DataVenda, TotalVenda, ID_Cli) 
					values (vNumeroVenda, current_date(), vTotalVenda, @ID);
			end if; 
		    
            if not exists ( select NumeroVenda from tbItemVenda where NumeroVenda = vNumeroVenda and CodigoBarras = vCodigoBarras )then
                insert into tbItemVenda (NumeroVenda, CodigoBarras, ValorItem, Qtd) 
					values (vNumeroVenda, vCodigoBarras, vValorItem, vQtd);
            end if;
        else 
         select 'Cliente ou produto não cadastrado' as 'Atenção!';
	end if;
end &&

call spInsertVenda(1, "Pimpão", 12345678910111, 54.61, 1, 54.61); 
call spInsertVenda(2, "Lança Perfume", 12345678910112, 100.45, 2, 200.90); 
call spInsertVenda(3, "Pimpão", 12345678910113, 44.00, 1, 44.00);

Select * from tbItemVenda;
Select * from tbVenda;


-- EXERCICIO 11 --
delimiter && 
create procedure spinsertNF(vNF int, vNomeCli varchar(200)) 
begin
if exists (select ID from tbCliente where NomeCli = vNomeCli) then
	if not exists(select NF from tbNota_Fiscal where NF = vNF) then
		set @IDC = (select ID from tbCliente where NomeCli = vNomeCli);
		-- o sum soma os valores, ja que no caso do pimpão tem 2 compras e sem a função dava subquery returns more than 1 row
		set @TotalNota = (select sum(TotalVenda) from tbVenda where ID_Cli = @IDC);
		
		if exists(select NumeroVenda from tbVenda where ID_Cli = @IDC) then
			insert into tbNota_Fiscal (NF, TotalNota, DataEmissao) 
				values (vNF, @TotalNota, current_date());
                -- adicionar a nota fiscal(que estava null) na tbVenda
				update tbvenda set NF = vNF where ID_Cli = @IDC;
		end if;
	end if;
end if;
end &&

call spinsertNF(359, "Pimpão"); 
call spinsertNF(360, "Lança Perfume");

Select * from tbNota_Fiscal;
Select * from tbCliente;

-- EXERCICIO 12 --
call spinsertproduto(12345678910130, 'Camiseta de Poliéster', 35.61, 100); 
call spinsertproduto(12345678910131, 'Blusa Frio Moletom', 200.00, 100); 
call spinsertproduto(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

Select * from tbProduto;

-- EXERCICIO 13 --
delimiter && 
create procedure spexcprod(vCodigoBarras numeric(14), vNome varchar (200), vValor decimal (8,3), vQtd int) 
begin
IF EXISTS(select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) then
	delete from tbProduto where CodigoBarras = vCodigoBarras and Nome = vNome and Valor = vValor and Qtd = vQtd;
end if;
end &&

call spexcprod(12345678910116, 'Boneco do Hitler', 124.00, 200); 
call spexcprod(12345678910117, 'Farinha de Suruí', 50.00, 200);

Select * from tbProduto;

-- EXERCICIO 14 --
delimiter && 
create procedure spattprod(vCodigoBarras numeric(14), vNome varchar (200), vValor decimal (8,3)) 
begin
IF EXISTS(select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) then
	UPDATE tbProduto
	SET CodigoBarras = vCodigoBarras, Nome = vNome, Valor = vValor
	WHERE CodigoBarras = vCodigoBarras;
end if;
end &&

call spattprod(12345678910111, 'Rei do Papel Mache', 64.50); 
call spattprod(12345678910112, 'Bolinha de Sabão', 120.00); 
call spattprod(12345678910113, 'Carro Bate Bate', 64.00);

Select * from tbProduto;

-- EXERCICIO 15 --
delimiter && 
create procedure spselectproduto() 
begin 
	select * from tbProduto;
end &&

call spselectproduto;

-- EXERCICIO 16 --
create table tb_ProdutoHistorico like tbProduto;

describe tb_ProdutoHistorico;

-- EXERCICIO 17 --
alter table tb_ProdutoHistorico add Ocorrencia varchar(20); 
alter table tb_ProdutoHistorico add Atualizacao datetime;

describe tb_ProdutoHistorico;

-- EXERCICIO 18 --
alter table tb_ProdutoHistorico drop primary key; 
alter table tb_ProdutoHistorico add primary key(CodigoBarras, Ocorrencia, Atualizacao);

describe tb_ProdutoHistorico;

-- EXERCICIO 19 --
delimiter && 
create trigger trgProdHist after insert on tbProduto for each row 
begin 
	insert into tb_ProdutoHistorico 
		set CodigoBarras = new.CodigoBarras, 
        Nome = new.Nome, 
        Valor = new.Valor, 
        Qtd = new.Qtd, 
        Ocorrencia = 'Novo', 
        Atualizacao = current_timestamp(); 
end; &&

call spinsertproduto(12345678910119, 'Água mineral', 1.99, 500);

select * from tbProduto;
select * from tb_ProdutoHistorico;

-- EXERCICIO 20 --
delimiter && 
create trigger trgprodhistupd before update on tbProduto for each row 
begin 
	insert into tb_ProdutoHistorico set 
    CodigoBarras = new.CodigoBarras, 
    Nome = new.Nome, 
    Valor = new.Valor, 
    Qtd = new.Qtd, 
    Ocorrencia = 'Atualizado', 
    Atualizacao = current_timestamp();
end; &&

call spattprod(12345678910119, 'Água mineral', 2.99);

select * from tbProduto;
select * from tb_ProdutoHistorico;

-- EXERCICIO 21 --
select * from tbProduto;

-- EXERCICIO 22 --
call spinsertvenda(4, 'Disney Chaplin', '12345678910111', 65.000, 1, 64.50)

-- EXERCICIO 23 --
select * from tbVenda order by NumeroVenda desc limit 1;

-- EXERCICIO 24 --
select * from tbItemVenda order by NumeroVenda desc limit 1;

-- EXERCICIO 25 --
delimiter && 
create procedure spinsertconsulta (vNomeCli varchar(200)) 
begin 
	select * from tbCliente where vNomeCli = NomeCli; 
end && 

call spinsertconsulta ('Disney Chaplin');

-- EXERCICIO 26 --
delimiter && 
create trigger trg_updatetbProduto after insert on tbItemVenda for each row 
begin 
	UPDATE tbProduto set 
    Qtd = Qtd - NEW.Qtd Where CodigoBarras = NEW.CodigoBarras; 
end &&

-- EXERCICIO 27 --
call spinsertVenda (7,'Paganada', 12345678910114, 10.00, 15, 150.00 );

-- EXERCICIO 28 --
select * from tbProduto;

-- EXERCICIO 29 --
delimiter && 
create trigger trg_addtbProduto after insert on tbItemCompra for each row 
begin 
	UPDATE tbProduto set 
    Qtd = Qtd + NEW.Qtd Where CodigoBarras = NEW.CodigoBarras; 
end && 

-- EXERCICIO 30 --
call spinsertCompra (10548,'Amoroso e Doce', '2018-05-01', 12345678910111, 40.00, 100, 100, 4000.00 ); 

-- EXERCICIO 31 --
select * from tbProduto; 
select * from tbCompra; 
select *from tbItemCompra;

-- EXERCICIO 32 --
select tbCliente.ID, tbCliente.NomeCli, tbCliente.NumEnd, tbCliente.CompEnd, tbCliente.CepCli as CEP, 
		tbClientePF.CPF, tbClientePF.RG, tbClientePF.RG_Dig, tbClientePF.Nasc, tbClientePF.ID 
        FROM tbCliente 
        INNER JOIN tbClientePF ON tbCliente.ID = tbClientePF.ID;

-- EXERCICIO 33 -- 
select tbCliente.ID, tbCliente.NomeCli, tbCliente.NumEnd, tbCliente.CompEnd, tbCliente.CEPCli as CEP,
		tbClientePJ.CNPJ, tbClientePJ.IE, tbClientePJ.ID 
        FROM tbCliente 
        INNER JOIN tbClientePJ ON tbCliente.ID = tbClientePJ.ID;

-- EXERCICIO 34 -- 
select tbCliente.ID, tbCliente.NomeCli, tbClientePJ.CNPJ, tbClientePJ.IE, tbClientePJ.ID 
		FROM tbCliente 
        INNER JOIN tbClientePJ ON tbCliente.ID = tbClientePJ.ID;

-- EXERCICIO 35 -- 
select tbCliente.ID, tbCliente.NomeCli, tbClientePF.CPF, tbClientePF.RG, tbClientePF.Nasc as "Data de Nascimento"
		FROM tbCliente 
        INNER JOIN tbClientePF ON tbCliente.ID = tbClientePF.ID;

-- EXERCICIO 36 -- 
SELECT * FROM tbCliente 
		INNER JOIN tbClientePJ ON tbCliente.ID = tbClientePJ.ID 
        INNER JOIN tbEndereco ON  tbCliente.CEPCli = tbEndereco.CEP;

-- EXERCICIO 37 -- 
SELECT tbCliente.ID, tbCliente.NomeCli, tbCliente.CEPCli as CEP, 
		tbEndereco.logradouro, 
        tbCliente.NumEnd, tbCliente.CompEnd, 
        tbBairro.Bairro, tbCidade.Cidade, tbEstado.UF 
        FROM tbCliente 
        INNER JOIN tbClientePJ ON tbCliente.ID = tbClientePJ.ID 
        INNER JOIN tbEndereco ON tbCliente.CEPCli = tbEndereco.CEP 
        INNER JOIN tbBairro ON tbEndereco.BairroId = tbBairro.BairroID 
        INNER JOIN tbCidade ON tbEndereco.CidadeId = tbCidade.CidadeID 
        INNER JOIN tbEstado ON tbEndereco.UFId = tbEstado.UFID;

-- EXERCICIO 38 --
delimiter && 
create procedure spSelectClientePFisica (vID int)
begin
select tbCliente.ID as Código, tbCliente.NomeCli as Nome, 
		tbClientePF.CPF, tbClientePF.RG, tbClientePF.RG_Dig as Digito, tbClientePF.Nasc as 'Data de Nascimento', 
        tbcliente.CEPCli as CEP, tbEndereco.Logradouro, tbCliente.NumEnd as Número, tbCliente.CompEnd as Complemento, 
        tbBairro.Bairro, tbCidade.Cidade, tbEstado.UF 
        FROM tbCliente 
        INNER JOIN tbClientePF ON tbCliente.ID = tbClientePF.ID 
        INNER JOIN tbEndereco ON tbCliente.CEPCli = tbEndereco.CEP 
        INNER JOIN tbBairro ON tbEndereco.BairroId = tbBairro.BairroID 
        INNER JOIN tbCidade ON tbEndereco.CidadeId = tbCidade.CidadeID 
        INNER JOIN tbEstado ON tbEndereco.UFID = tbEstado.UFID 
        WHERE tbCliente.Id = vId; 
end && 
call spSelectClientePFisica (2);

call spSelectClientePFisica (5);

-- EXERCICIO 39 -- 
SELECT * FROM tbProduto 
	LEFT JOIN tbItemVenda ON tbProduto.CodigoBarras = tbItemVenda.CodigoBarras;

-- EXERCICIO 40 -- 
SELECT * FROM tbCompra 
	RIGHT JOIN tbFornecedor ON tbCompra.Cod = tbFornecedor.Cod;

-- EXERCICIO 41 -- 
SELECT tbFornecedor.Cod, tbFornecedor.CNPJ, tbFornecedor.Nome, tbFornecedor.Telefone 
	FROM tbFornecedor 
    RIGHT JOIN tbcompra ON tbFornecedor.Cod = tbcompra.Cod;

-- EXERCICIO 42 -- 
SELECT tbCliente.ID, tbCliente.NomeCli, 
		tbVenda.DataVenda, 
        tbProduto.CodigoBarras, tbProduto.Nome, 
        tbItemVenda.ValorItem 
        FROM tbCliente 
        LEFT JOIN tbVenda ON tbCliente.ID = tbVenda.Id_Cli 
        LEFT JOIN tbItemVenda ON tbVenda.Id_Cli = tbItemVenda.NumeroVenda 
        LEFT JOIN tbProduto ON tbItemVenda.CodigoBarras = tbProduto.CodigoBarras 
        WHERE tbVenda.DataVenda IS NOT NULL 
        ORDER BY tbCliente.NomeCli;

/* EXERCICIO 43 -- 
SELECT tbBairro.Bairro 
	FROM tbBairro 
	LEFT JOIN tbEndereco ON tbBairro.BairroId = tbEndereco.BairroId 
    LEFT JOIN tbCliente ON tbEndereco.CEP = tbCliente.CEPCli 
    LEFT JOIN tbVenda ON tbCliente.Id = tbVenda.Id_Cli 
    WHERE tbVenda.TotalVenda IS NULL 
    GROUP BY tbBairro.Bairro; */

use master;
GO
drop database lojainfo;

create database lojainfo;
use	lojainfo;
GO
-- Criação de tabela --
CREATE TABLE tbClientes (
	IDCLIENTE INT PRIMARY KEY identity(1,1),
	NOME CHAR(50) not null,
	ENDERECO CHAR(100),
	FONE CHAR (15),
	EMAIL CHAR (70)
);

CREATE TABLE tbHardware (
	IDHardware	INT PRIMARY KEY identity(1,1),
	DESCRICAO	CHAR(50) not null,
	PRECOUNIT	DECIMAL,
	QTDANUAL	INT,
	QTDMINIMA	INT,
	IMGPRODUTO IMAGE DEFAULT NULL
);

CREATE TABLE tbVendas(
	IDVENDA		INT PRIMARY KEY identity(1,1),
	IDCLIENTE	INT not null,
	DATA		DATE not null,
	VALORTOTAL	DECIMAL(8,2) not null,
	DESCONTO	DECIMAL(8,2),
	VALORPAGO	DECIMAL(8,2)
);

CREATE TABLE tbItensVenda(
	IDItem	INT PRIMARY KEY identity(1,1),
	IDVENDA	INT not null,
	IDHardware INT not null,
	QTDE	INT not null,
	TOTALITEM DECIMAL(8,2) not null);
	-- Fim --						

	-- ALTERAÇÃO DAS TABELA --
	ALTER TABLE tbVendas
      ADD CONSTRAINT fk_cli
      FOREIGN KEY (IDCLIENTE) REFERENCES tbClientes(IDCLIENTE)
	
	ALTER TABLE tbItensVenda
      ADD CONSTRAINT fk_itens_venda
      FOREIGN KEY (IDVENDA) REFERENCES tbVendas(IDVENDA)
      
-- FIM -- 
	
-- Inserção de Dados Tabela tbClientes --
insert into tbClientes values ('Renan','Aguia Haia 451','11-88888-9999','renan@gmail.com'),
							  ('José','Rua um','11-99999-7777','josé@hotmail.com'),
                              ('Rafael','Rua dois','11-95555-9999','rafa@outlook.com');
  SELECT * FROM tbClientes;                            
-- FIM --                              

-- Inserção de Dados Tabela tbHardware -- 
insert into tbHardware values	('placa de video',50.50, 100, 10, NULL),
								('gabinete', 350.50, 100, 10, NULL),
								('teclado',20.50, 100, 10, NULL),
								('processador', 250.90, 100, 10, NULL),
								('placa de rede',120.20, 100, 10, NULL);
	SELECT * FROM tbHardware;
	-- FIM --
	
-- Inserçãp de Dados Tabela tbVendas --
insert into tbVendas values (1,'2018-01-10', 8417, 100, 8371),
							 (2,'2018-02-20',1068,0,10860),
							 (2,'2018-02-25',1086,0,10806)
							 ;
	SELECT * FROM tbVendas;
-- Fim -- 

insert into tbItensVenda values (1,1,10, 600.50),
								(2,2,10,3050),
								(2,2,10,3050);
SELECT * FROM tbItensVenda;
--Fim --

-- Apresentando Clientes que compraram Vendas -- 
select * from tbClientes c join tbVendas v on c.IDCLIENTE = v.IDCLIENTE;	

-- FIM -- 

-- Apresentando todos os clientes e suas compras --
select c.IDCLIENTE as IDCLIENTEDaTBClientes,
       v.IDCLIENTE as IDCLIENTEDaTbVendas,
       c.NOME from
       tbClientes c
       left join tbVendas v
       on c.IDCLIENTE = v.IDCLIENTE;
-- FIM	--

-- Adiciona id da Venda --
select c.IDCLIENTE as IDCLIENTEDatbClientes,
       v.IDCLIENTE as IDCLIENTEDatbVendas,
       c.NOME as nomeCliente,
       v.IDVENDA as IDVENDADatbVendas
       from
       tbClientes c
       left join tbVendas v
              on c.IDCLIENTE = v.IDCLIENTE
-- FIM --              
	
	-- Adicona informacoes do item --
	select c.IDCLIENTE as IdClienteDaTblCliente,
       v.IDCLIENTE as IdClienteDaTblVendas,
       c.NOME as nomeCliente,
       v.IDVENDA as IdVendaDaTblVendas,
       i.IDITEM as idItem,
       i.IDHardware as idHardware,
       i.QTDE as qtde,
       i.TOTALITEM as vlrTotItem
       from
       tbClientes c
       left join tbVendas v
              on c.IDCLIENTE = v.IDCLIENTE
       join tbItensVenda as i
              on v.IDVENDA = i.IDVENDA
     -- FIM -- 
     
     -- Mostra quem comprou e o que comrpou --
     select c.IDCLIENTE as IdClienteDaTblCliente,
       v.IDCLIENTE as IdClienteDaTblVendas,
       c.NOME as nomeCliente,
       v.IDVENDA as IdVendaDaTblVendas,
       i.IDItem as idItem,
       i.IDHardware as idHardware
       from
       tbClientes c
       left join tbVendas v
              on c.IDCLIENTE = v.IDCLIENTE
       left join tbItensVenda as i
              on v.IDVENDA = i.IDVENDA
        -- FIM --
        
        -- Id o cliente e o valor --
        select v.IDVENDA as IdVendaDaTblVendas,
       c.NOME as nomeCliente,
       sum(i.TOTALITEM) as VlrDaVenda
       from
       tbClientes c
       join tbVendas v
              on c.IDCLIENTE = v.IDCLIENTE
       join tbItensVenda as i
              on v.IDVENDA = i.IDVENDA
       group by v.IDVENDA, c.NOME
           -- fim --  	
           
           -- Basicão de variaveis --
           --Declarando uma variavel --
           DECLARE @MyCounter int;
           
           -- Inicializando uma variavel --
           SET @MyCounter = 0;
           SELECT @MyCounter
           SET @MyCounter = 1;
           SELECT @MyCounter
           -- Fim --
           
           /* CHARINDEX - https://docs.microsoft.com/pt-br/sql/t-sql/functions/charindex-transact-sql
           Exemplo: CHARINDEX (expressionToFind ,expressionToSearch [ , start_location])
           */
           
           DECLARE @document varchar(64);
           SELECT @document = 'Reflectors are vital safety' + ' componets of your bicycle.';
           
           -- Função CHARINDEX --
           SELECT CHARINDEX('bicycle' , @document);
           SELECT CHARINDEX('are' , @document);
           SELECT CHARINDEX('ARE' , @document);
           SELECT CHARINDEX('Ref' , @document);
           SELECT CHARINDEX('ect' , @document);
        	-- fim --
        	
        	-- FUNÇÃO CONCAT -- 
        	-- SELECT CONCAT ('Happy', 'Birthday' , 11, '/', '25' ) AS Result; --
        	-- FIM --
        	
        	-- FUNÇÃO TRIM --
        	/* LTRIM - Retorna uma expressão de caractere depois de remover espaços em branco à esquerda.
        	Documentação em: https://docs.microsoft.com/pt-br/sql/t-sql/functions/ltrim-transact-sql
        	Exemplo:
        	*/ SELECT LTRIM(' Five spaces are at the beginning of this string.') FROM sys.databases;
        	-- FIM --
        	
        	/* REPLACE - SUBSTITUI TODAS AS OCRRENCIAS DE UM VALOR DA CADEIA DE CARACTERES ESPECIFICADO POR OUTRO VALOR DE CADEIA DE CARACTERES
        	https://docs.microsoft.com/pt-br/sql/t-sql/functions/replace-transact-sql
        	Exemplo: */
        	SELECT REPLACE('abcdefguicde','cde','xxx');
        	-- FIM --
        	
        	
        									 							 										
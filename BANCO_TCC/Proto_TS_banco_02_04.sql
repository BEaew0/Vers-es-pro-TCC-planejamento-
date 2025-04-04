-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS BANCO_TESOURO_AZUL;
USE BANCO_TESOURO_AZUL;

-- Tabela TB_TIPO_ASSINATURA
CREATE TABLE IF NOT EXISTS TB_TIPO_ASSINATURA (
    ID_TIPO_ASSINATURA INT AUTO_INCREMENT PRIMARY KEY,
    DESC_TIPO_ASSINATURA VARCHAR(20) NOT NULL UNIQUE
)engine = InnoDB;

 -- inserindo já os valores fixos
insert into TB_TIPO_ASSINATURA (DESC_TIPO_ASSINATURA) values("normal") , ("assinante");

-- Tabela TB_ASSINATURA
CREATE TABLE IF NOT EXISTS TB_ASSINATURA (
    ID_ASSINATURA INT AUTO_INCREMENT PRIMARY KEY,
    DESC_ASSINATURA VARCHAR(50) NOT NULL UNIQUE,
    VALOR_ASSINATURA DECIMAL(5,2) NOT NULL,
    VALIDADE_ASSINATURA DATE,
    ID_TIPO_ASSINATURA_FK INT NOT NULL,
    FOREIGN KEY (ID_TIPO_ASSINATURA_FK) REFERENCES TB_TIPO_ASSINATURA (ID_TIPO_ASSINATURA)
)engine= InnoDB;

-- Tabela TB_USUARIO
CREATE TABLE IF NOT EXISTS TB_USUARIO (
    ID_USUARIO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_USUARIO VARCHAR(80) NOT NULL UNIQUE,
    EMAIL_USUARIO VARCHAR(35) NOT NULL UNIQUE CHECK (EMAIL_USUARIO LIKE '%@%'),
    DATA_NASC_USUARIO DATE NOT NULL,
    CPF_USUARIO CHAR(11) NOT NULL UNIQUE,
    CNPJ_USUARIO CHAR(14),
    SENHA_USUARIO VARCHAR(255) NOT NULL CHECK (LENGTH(SENHA_USUARIO) BETWEEN 8 AND 20),
    FOTO_USUARIO LONGBLOB,
    ID_ASSINATURA_FK INT NOT NULL,
    FOREIGN KEY (ID_ASSINATURA_FK) REFERENCES TB_ASSINATURA(ID_ASSINATURA)
)engine = InnoDB;

-- Tabela TB_PRODUTO
CREATE TABLE IF NOT EXISTS TB_PRODUTO (
    ID_PRODUTO INT AUTO_INCREMENT PRIMARY KEY,
    ID_USUARIO_FK INT NOT NULL,
    COD_PRODUTO VARCHAR(80) NOT NULL UNIQUE,
    NOME_PRODUTO VARCHAR(20) NOT NULL UNIQUE,
    TIPO_PRODUTO VARCHAR(40) NOT NULL,
    DATA_VALIDADE DATE NULL,
    IMG_PRODUTO LONGBLOB,
    FOREIGN KEY (ID_USUARIO_FK) REFERENCES TB_USUARIO(ID_USUARIO)
)engine = InnoDB;

-- Tabela TB_FORNECEDOR
CREATE TABLE IF NOT EXISTS TB_FORNECEDOR (
    ID_FORNECEDOR INT AUTO_INCREMENT PRIMARY KEY,
    NOME_FORNECEDOR VARCHAR(40) NOT NULL UNIQUE,
    CNPJ_FORNECEDOR CHAR(20) NOT NULL UNIQUE,
    EMAIL_FORNECEDOR VARCHAR(35) NOT NULL CHECK (EMAIL_FORNECEDOR LIKE '%@%'),
    TEL_FORNECEDOR CHAR(9) UNIQUE,
    CEL_FORNECEDOR CHAR(15) NOT NULL UNIQUE,
    ENDERECO_FORNECEDOR VARCHAR(50) NOT NULL
)engine = InnoDB;

-- Tabela TB_PEDIDO_COMPRA
CREATE TABLE IF NOT EXISTS TB_PEDIDO_COMPRA (
    ID_PEDIDO_COMPRA INT AUTO_INCREMENT PRIMARY KEY,
    ID_FORNECEDOR_FK INT NOT NULL,
    DATA_PEDIDO_COMPRA DATE NOT NULL,
    QTD_PEDIDO_COMPRA DECIMAL(5,2) NOT NULL,
    LOTE_PEDIDO_COMPRA VARCHAR(13) NOT NULL UNIQUE,
    VALOR_PEDIDO_COMPRA DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (ID_FORNECEDOR_FK) REFERENCES TB_FORNECEDOR(ID_FORNECEDOR)
)engine = InnoDB;

-- Tabela TB_PEDIDO_VENDA
CREATE TABLE IF NOT EXISTS TB_PEDIDO_VENDA (
    ID_VENDA INT AUTO_INCREMENT PRIMARY KEY,
    ID_USUARIO_FK INT NOT NULL,
    PRODUTO_VENDA VARCHAR(30) NOT NULL,
    DATA_VENDA DATE NOT NULL,
    VALOR_VENDA DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (ID_USUARIO_FK) REFERENCES TB_USUARIO(ID_USUARIO)
)engine = InnoDB;

-- Tabela TB_ITEM_COMPRA
CREATE TABLE IF NOT EXISTS TB_ITEM_COMPRA (
    ID_ITEM_COMPRA INT AUTO_INCREMENT PRIMARY KEY,
    ID_PRODUTO_FK INT NOT NULL,
    ID_COMPRA_FK INT NOT NULL,
    QTD_ITEM_COMPRA NUMERIC(5,1) NOT NULL,
    LOTE_ITEM_COMPRA CHAR(13) NOT NULL,
    N_ITEM_COMPRA INT NOT NULL,
    VALOR_ITEM_COMPRA NUMERIC(5,1) NOT NULL,
    FOREIGN KEY (ID_PRODUTO_FK) REFERENCES TB_PRODUTO(ID_PRODUTO),
    FOREIGN KEY (ID_COMPRA_FK) REFERENCES TB_PEDIDO_COMPRA(ID_PEDIDO_COMPRA)
)engine = InnoDB;

-- Tabela TB_ITEM_VENDA
CREATE TABLE IF NOT EXISTS TB_ITEM_VENDA (
    ID_ITEM_VENDA INT AUTO_INCREMENT PRIMARY KEY,
    ID_PRODUTO_FK INT NOT NULL,
    ID_VENDA_FK INT NOT NULL,
    QTD_ITEM_VENDA NUMERIC(5,1) NOT NULL,
    N_ITEM_VENDA INT NOT NULL,
    VALOR_ITEM_VENDA NUMERIC(5,1) NOT NULL,
    FOREIGN KEY (ID_PRODUTO_FK) REFERENCES TB_PRODUTO(ID_PRODUTO),
    FOREIGN KEY (ID_VENDA_FK) REFERENCES TB_PEDIDO_VENDA(ID_VENDA)
)engine = InnoDB;

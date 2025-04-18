-- Criação do banco de dados
CREATE DATABASE BANCO_TESOURO_AZUL;
USE BANCO_TESOURO_AZUL;



-- Tabela TB_TIPO_ASSINATURA
CREATE TABLE TB_TIPO_ASSINATURA (
    ID_TIPO INT AUTO_INCREMENT PRIMARY KEY,
    DESC_TIPO VARCHAR(20) NOT NULL UNIQUE
)Engine=InnoDB;

-- Tabela TB_ASSINATURA
CREATE TABLE TB_ASSINATURA (
    ID_ASSINATURA INT AUTO_INCREMENT PRIMARY KEY,
    DESC_ASSINATURA VARCHAR(50) NOT NULL UNIQUE,
    VALOR_ASSINATURA DECIMAL(5,2) NOT NULL,
    STATUS ENUM('ATIVA', 'PENDENTE', 'EXPIRADA', 'CANCELADA') DEFAULT 'PENDENTE',
    DATA_ATIVACAO DATETIME,
    DATA_EXPIRACAO   DATETIME,
    TIPO_ASSINATURA_FK INT NOT NULL,
    FOREIGN KEY (TIPO_ASSINATURA_FK) REFERENCES TB_TIPO_ASSINATURA(ID_TIPO),
    CONSTRAINT CHK_DATAS_VALIDAS CHECK (DATA_EXPIRACAO >= DATA_ATIVACAO)
)Engine=InnoDB;

-- Tabela TB_USUARIO
CREATE TABLE TB_USUARIO (
    ID_USUARIO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_USUARIO VARCHAR(80) NOT NULL UNIQUE,
    EMAIL_USUARIO VARCHAR(20) NOT NULL CHECK (EMAIL_USUARIO LIKE '%@%'),
    DATA_NASC_USUARIO DATE NOT NULL,
    CPF_USUARIO CHAR(11) NOT NULL UNIQUE,
    CNPJ_USUARIO CHAR(14),
    ID_ASSINATURA_FK INT NOT NULL,
    SENHA_USUARIO VARCHAR(255) NOT NULL CHECK (LENGTH(SENHA_USUARIO) BETWEEN 8 AND 20),
    FOTO_USUARIO TEXT,
    FOREIGN KEY (ID_ASSINATURA_FK) REFERENCES TB_ASSINATURA(ID_ASSINATURA)
)engine=InnoDB;

-- Tabela TB_FORNECEDOR
CREATE TABLE TB_FORNECEDOR (
    ID_FORNECEDOR INT AUTO_INCREMENT PRIMARY KEY,
    NOME_FORNECEDOR VARCHAR(40) NOT NULL UNIQUE,
    CNPJ_FORNECEDOR CHAR(20) NOT NULL UNIQUE,
    EMAIL_FORNECEDOR VARCHAR(35) NOT NULL CHECK (EMAIL_FORNECEDOR LIKE '%@%'),
    TEL_FORNECEDOR CHAR(9) UNIQUE,
    CEL_FORNECEDOR CHAR(15) NOT NULL UNIQUE,
    ENDERECO_FORNECEDOR VARCHAR(50) NOT NULL
)engine=InnoDB;;

-- Tabela TB_PRODUTO
CREATE TABLE TB_PRODUTO (
    ID_PRODUTO INT AUTO_INCREMENT PRIMARY KEY,
    ID_USUARIO_FK INT NOT NULL,
    COD_PRODUTO VARCHAR(80) NOT NULL UNIQUE,
    NOME_PRODUTO VARCHAR(20) NOT NULL UNIQUE,
    TIPO_PRODUTO VARCHAR(40) NOT NULL,
    DATA_VAL_PRODUTO DATE,
    IMG_PRODUTO TEXT,
    FOREIGN KEY (ID_USUARIO_FK) REFERENCES TB_USUARIO(ID_USUARIO)
)engine=InnoDB;;

-- Tabela TB_PEDIDO_COMPRA
CREATE TABLE TB_PEDIDO_COMPRA (
    ID_COMPRA INT AUTO_INCREMENT PRIMARY KEY,
    ID_USUARIO VARCHAR(14) NOT NULL,
    ID_FORNECEDOR CHAR(14) NOT NULL,
    DATA_COMPRA DATE NOT NULL,
    QTD_COMPRA DECIMAL(5,2) NOT NULL,
    COD_LOTE_COMPRA VARCHAR(13) NOT NULL UNIQUE,
    NOME_PRODUTO_PEDIDO VARCHAR(50) NOT NULL,
    VALOR_PEDIDO DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES TB_USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_FORNECEDOR) REFERENCES TB_FORNECEDOR(ID_FORNECEDOR)
)engine=InnoDB;;

-- Tabela TB_PEDIDO_VENDA
CREATE TABLE TB_PEDIDO_VENDA (
    ID_VENDA INT AUTO_INCREMENT PRIMARY KEY,
    DATA_VENDA DATE NOT NULL,
    VALOR_VENDA NUMERIC(7,2) NOT NULL
)engine=InnoDB;;

-- Tabela TB_ITEM_COMPRA
CREATE TABLE TB_ITEM_COMPRA (
    ID_ITEM_COMPRA INT AUTO_INCREMENT PRIMARY KEY,
    ID_PRODUTO INT NOT NULL,
    ID_COMPRA INT NOT NULL,
    LOTE_VENDA VARCHAR(255),
    QUANTIDADE_ITEM NUMERIC(5,2) NOT NULL,
    N_ITEM_COMPRA INT NOT NULL,
    FOREIGN KEY (ID_PRODUTO) REFERENCES TB_PRODUTO(ID_PRODUTO),
    FOREIGN KEY (ID_COMPRA) REFERENCES TB_PEDIDO_COMPRA(ID_COMPRA)
)engine=InnoDB;;

-- Tabela TB_ITEM_VENDA
CREATE TABLE TB_ITEM_VENDA (
    ID_ITEM_VENDA INT AUTO_INCREMENT PRIMARY KEY,
    ID_PRODUTO INT NOT NULL,
    ID_VENDA INT NOT NULL,
    LOTE_VENDA VARCHAR(255),
    QTS_ITEM_VENDA NUMERIC(5,2) NOT NULL,
    N_ITEM_VENDA INT NOT NULL,
    FOREIGN KEY (ID_PRODUTO) REFERENCES TB_PRODUTO(ID_PRODUTO),
    FOREIGN KEY (ID_VENDA) REFERENCES TB_PEDIDO_VENDA(ID_VENDA)
)engine=InnoDB;;


-- Criando índices para melhorar performance

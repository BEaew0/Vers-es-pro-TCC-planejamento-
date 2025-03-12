create database sistema_tesouro_azul;
use sistema_tesouro_azul;

CREATE TABLE TB_USUARIO_CADASTRO (
    ID_USUARIO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_USUARIO VARCHAR(35) NOT NULL,
    EMAIL_USUARIO VARCHAR(100) NOT NULL,
    DTA_NASC_USUARIO DATE NOT NULL,
    CPF_USUARIO CHAR(11) NOT NULL,
    CNPJ_USUARIO CHAR(14) NULL,
    SENHA_USUARIO VARCHAR(255) NOT NULL,
    FOTO_USUARIO TEXT NOT NULL,
    
    CONSTRAINT CHK_SENHA_LENGHT CHECK (LENGTH(SENHA_USUARIO) BETWEEN 8 AND 255),
    CONSTRAINT UNQ_EMAIL UNIQUE (EMAIL_USUARIO),
    CONSTRAINT UNQ_CPF UNIQUE (CPF_USUARIO),
    CONSTRAINT UNQ_CNJP UNIQUE (CNPJ_USUARIO)
);	

CREATE TABLE TB_ADMINISTRADOR_CADASTRO(
    ID_ADM INT AUTO_INCREMENT PRIMARY KEY,
    NOME_ADM VARCHAR (35) NOT NULL,
    EMAIL_ADM VARCHAR (100) NOT NULL,
    SENHA_ADM VARCHAR(255) NOT NULL,
    CONSTRAINT CHK_SENHA_LENGHT CHECK (LENGTH(SENHA_ADM) BETWEEN 8 AND 255),
	CONSTRAINT UNQ_EMAIL UNIQUE (EMAIL_ADM)
    
);


CREATE TABLE TB_CAD_PRODUTO(
	ID_PRODUTO INT PRIMARY KEY AUTO_INCREMENT,
    ID_USUARIO_FK INT,
    COD_PRODUTO CHAR(13) NOT NULL,
    NOME_PRODUTO VARCHAR(60) NOT NULL,
    MARCA_PRODUTO VARCHAR(20) NOT NULL,
    TIPO_PRODUTO VARCHAR(40) NOT NULL,
    DTA_VALIDADE_PRODUTO DATE NULL,
    IMG_PRODUTO TEXT NOT NULL

);



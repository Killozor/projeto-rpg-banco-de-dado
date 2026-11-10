/*
    Projeto: Jogo de RPG Online
    Banco de dados: banco_de_dados_t04df
    SGBD: Microsoft SQL Server

    Estrutura baseada no diagrama entidade-relacionamento fornecido.
    Observacoes:
    - Os tipos e tamanhos dos campos foram definidos por criterio tecnico,
      pois o diagrama informa os campos, mas nao seus tipos.
    - Senha deve armazenar um hash seguro, nunca a senha em texto puro.
    - CLASSES_HABILIDADES utiliza chave primaria composta.
*/

IF DB_ID(N'banco_de_dados_t04df') IS NULL
BEGIN
    CREATE DATABASE banco_de_dados_t04df;
END;
GO

USE banco_de_dados_t04df;
GO

-- 1. Tabela de usuarios
CREATE TABLE USUARIOS (
    UsuarioId INT IDENTITY(1,1) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Senha NVARCHAR(255) NOT NULL,

    CONSTRAINT PK_USUARIOS PRIMARY KEY (UsuarioId),
    CONSTRAINT UQ_USUARIOS_Email UNIQUE (Email)
);
GO

-- 2. Tabela de classes
CREATE TABLE CLASSES (
    ClasseId INT IDENTITY(1,1) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,
    Descricao NVARCHAR(500) NULL,

    CONSTRAINT PK_CLASSES PRIMARY KEY (ClasseId)
);
GO

-- 3. Tabela de habilidades
CREATE TABLE HABILIDADES (
    HabilidadeId INT IDENTITY(1,1) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_HABILIDADES PRIMARY KEY (HabilidadeId)
);
GO

-- 4. Tabela de personagens
CREATE TABLE PERSONAGENS (
    PersonagemId INT IDENTITY(1,1) NOT NULL,
    NomePersonagem NVARCHAR(100) NOT NULL,
    UsuarioId INT NOT NULL,
    ClasseId INT NOT NULL,

    CONSTRAINT PK_PERSONAGENS PRIMARY KEY (PersonagemId),
    CONSTRAINT FK_PERSONAGENS_USUARIOS
        FOREIGN KEY (UsuarioId) REFERENCES USUARIOS (UsuarioId),
    CONSTRAINT FK_PERSONAGENS_CLASSES
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId)
);
GO

-- 5. Tabela associativa entre classes e habilidades
CREATE TABLE CLASSES_HABILIDADES (
    ClasseId INT NOT NULL,
    HabilidadeId INT NOT NULL,

    CONSTRAINT PK_CLASSES_HABILIDADES
        PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId),

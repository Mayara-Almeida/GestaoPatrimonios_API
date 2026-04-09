-- CRIANDO BANCO
CREATE DATABASE GestaoPatrimonios;
GO

USE GestaoPatrimonios;
GO

-- CRIANDO TABELAS

CREATE TABLE Area (
	AreaID   UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeArea VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE TipoUsuario( --> Coordenador ou Responsável
	TipoUsuarioID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeTipo		VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE Cargo( 
	CargoID		UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeCargo	VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE TipoPatrimonio(
	TipoPatrimonioID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeTipo			VARCHAR(100) UNIQUE NOT NULL
);
GO

CREATE TABLE StatusPatrimonio( --> Inativo, Ativo, Transferido
	StatusPatrimonioID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeStatus		   VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE StatusTransferencia( --> Pendente de aprovação, Aprovado e Recusado
	StatusTransferenciaID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeStatus				VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE TipoAlteracao( --> Modificação e Transferência
	TipoAlteracaoID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeTipo		VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE Cidade(
	CidadeID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeCidade	VARCHAR(50) NOT NULL,
	Estado		VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Localizacao(
	LocalizacaoID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeLocal		VARCHAR(100) NOT NULL,
	LocalSAP		INT,
	DescricaoSAP	VARCHAR(100),
	Ativo			BIT DEFAULT 1,
	AreaID			UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_Localizacao_Area 
		FOREIGN KEY(AreaID) REFERENCES Area(AreaID) 
);
GO

CREATE TABLE Bairro(
	BairroID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NomeBairro	VARCHAR(50) NOT NULL,
	CidadeID	UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_Bairro_Cidade
		FOREIGN KEY(CidadeID) REFERENCES Cidade(CidadeID) 
);
GO

CREATE TABLE Endereco(
	EnderecoID	UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	Logradouro	VARCHAR(100) NOT NULL,
	Numero		INT,
	Complemento	VARCHAR(20),
	CEP			VARCHAR(10),
	BairroID	UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_Endereco_Bairro
		FOREIGN KEY(BairroID) REFERENCES Bairro(BairroID)
);
GO

CREATE TABLE Usuario(
	UsuarioID			UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	NIF					VARCHAR(7) UNIQUE NOT NULL,
	Nome				VARCHAR(150) NOT NULL,
	RG					VARCHAR(15) UNIQUE,
	CPF					VARCHAR(11) UNIQUE NOT NULL,
	CarteiraTrabalho	VARCHAR(14)	UNIQUE NOT NULL,
	Senha				VARBINARY(32) NOT NULL,			
	Email				VARCHAR(150) UNIQUE NOT NULL,
	Ativo				BIT DEFAULT 1,
	EnderecoID			UNIQUEIDENTIFIER NOT NULL,
	CargoID				UNIQUEIDENTIFIER NOT NULL,
	TipoUsuarioID		UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_Usuario_Endereco
		FOREIGN KEY(EnderecoID) REFERENCES Endereco(EnderecoID),

	CONSTRAINT FK_Usuario_Cargo
		FOREIGN KEY(CargoID) REFERENCES Cargo(CargoID),

	CONSTRAINT FK_Usuario_TipoUsuario
		FOREIGN KEY(TipoUsuarioID) REFERENCES TipoUsuario(TipoUsuarioID)
);
GO

CREATE TABLE Patrimonio(
	PatrimonioID		UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	Denominacao			VARCHAR(MAX) NOT NULL,
	NumeroPatrimonio	VARCHAR(30) UNIQUE NOT NULL,
	Valor				DECIMAL(10,2),
	Imagem				VARCHAR(MAX),
	LocalizacaoID		UNIQUEIDENTIFIER NOT NULL,
	TipoPatrimonioID	UNIQUEIDENTIFIER NOT NULL,
	StatusPatrimonioID	UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_Patrimonio_Localizacao
		FOREIGN KEY(LocalizacaoID) REFERENCES Localizacao(LocalizacaoID),

	CONSTRAINT FK_Patrimonio_TipoPatrimonio
		FOREIGN KEY(TipoPatrimonioID) REFERENCES TipoPatrimonio(TipoPatrimonioID),

	CONSTRAINT FK_Patrimonio_StatusPatrimonio
		FOREIGN KEY(StatusPatrimonioID) REFERENCES StatusPatrimonio(StatusPatrimonioID )
);
GO

CREATE TABLE LogPatrimonio(
	LogPatrimonioID		UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	DataTransferencia	DATETIME2(0) NOT NULL,
	TipoAlteracaoID		UNIQUEIDENTIFIER NOT NULL,
	StatusPatrimonioID  UNIQUEIDENTIFIER NOT NULL,
	PatrimonioID		UNIQUEIDENTIFIER NOT NULL,
	UsuarioID			UNIQUEIDENTIFIER NOT NULL,
	LocalizacaoID		UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_LogPatrimonio_TipoAlteracao
		FOREIGN KEY(TipoAlteracaoID) REFERENCES TipoAlteracao(TipoAlteracaoID),

	CONSTRAINT FK_LogPatrimonio_StatusPatrimonio
		FOREIGN KEY(StatusPatrimonioID) REFERENCES StatusPatrimonio(StatusPatrimonioID),

	CONSTRAINT FK_LogPatrimonio_Patrimonio
		FOREIGN KEY(PatrimonioID) REFERENCES Patrimonio(PatrimonioID),

	CONSTRAINT FK_LogPatrimonio_Usuario
		FOREIGN KEY(UsuarioID) REFERENCES Usuario(UsuarioID),

	CONSTRAINT FK_LogPatrimonio_Localizacao
		FOREIGN KEY(LocalizacaoID) REFERENCES Localizacao(LocalizacaoID)
);
GO

CREATE TABLE SolicitacaoTransferencia(
	TransferenciaID			UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	DataCriacaoSolicitacao	DATETIME2(0) NOT NULL,
	DataResposta			DATETIME2(0), --Permite nulo pois ao gerar a solicitação a resposta é nula
	Justificativa			VARCHAR(MAX) NOT NULL,
	StatusTransferenciaID	UNIQUEIDENTIFIER NOT NULL,
	UsuarioIDSolicitante	UNIQUEIDENTIFIER NOT NULL,
	UsuarioIDAprovacao		UNIQUEIDENTIFIER, --Permite nulo pois ao gerar a solicitação o usuário que aprova ainda não existe
	PatrimonioID			UNIQUEIDENTIFIER NOT NULL,
	LocalizacaoID			UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT FK_SolicitacaoTransferencia_StatusTransferencia
		FOREIGN KEY(StatusTransferenciaID) REFERENCES StatusTransferencia(StatusTransferenciaID),

	CONSTRAINT FK_SolicitacaoTransferencia_UsuarioSolicitacao
		FOREIGN KEY(UsuarioIDSolicitante) REFERENCES Usuario(UsuarioID),

	CONSTRAINT FK_SolicitacaoTransferencia_UsuarioAprovacao
		FOREIGN KEY(UsuarioIDAprovacao) REFERENCES Usuario(UsuarioID),

	CONSTRAINT FK_SolicitacaoTransferencia_Patrimonio
		FOREIGN KEY(PatrimonioID) REFERENCES Patrimonio(PatrimonioID),

	CONSTRAINT FK_SolicitacaoTransferencia_Localizacao
		FOREIGN KEY(LocalizacaoID) REFERENCES Localizacao(LocalizacaoID)
);
GO

CREATE TABLE LocalUsuario(
	LocalizacaoID	UNIQUEIDENTIFIER,
	UsuarioID		UNIQUEIDENTIFIER,

	CONSTRAINT PK_LocalUsuario PRIMARY KEY(LocalizacaoID, UsuarioID),

	CONSTRAINT FK_LocalUsuario_Localizacao
		FOREIGN KEY(LocalizacaoID) REFERENCES Localizacao(LocalizacaoID),

	CONSTRAINT FK_LocalUsuario_Usuario
		FOREIGN KEY(UsuarioID) REFERENCES Usuario(UsuarioID)
);
GO

-- CRIANDO TRIGGERS

-- Trigger para soft delete de usuário - Inativar usuário
CREATE TRIGGER trg_Usuario_SoftDelete
ON Usuario
INSTEAD OF DELETE --"Ao invés de deletar"
AS
BEGIN
	UPDATE Usuario
		SET Ativo = 0 -- Inativa
		WHERE UsuarioID IN (SELECT UsuarioID FROM deleted); -- Busca o id do usuário que foi deletado
END
GO

-- Trigger para soft delete de localização - Inativar localização
CREATE TRIGGER trg_Localizacao_SoftDelete
ON Localizacao
INSTEAD OF DELETE 
AS
BEGIN
	UPDATE Localizacao
		SET Ativo = 0
		WHERE LocalizacaoID IN (SELECT LocalizacaoID FROM deleted);
END
GO

-- Trigger para soft delete de patrimônio - Inativar patrimônio
CREATE TRIGGER trg_Patrimonio_SoftDelete
ON Patrimonio
INSTEAD OF DELETE 
AS
BEGIN
	UPDATE Patrimonio
		SET StatusPatrimonioID = 
			(SELECT StatusPatrimonioID
				FROM StatusPatrimonio
				WHERE NomeStatus = 'Inativo') -- Vai deixar como inativo
		WHERE PatrimonioID IN (SELECT PatrimonioID FROM deleted);
		
END
GO

-- INSERINDO VALORES

INSERT INTO Area (NomeArea) VALUES
('Bloco A - Térreo'),
('Bloco A - 1° Andar')
GO 

INSERT INTO TipoUsuario (NomeTipo) VALUES
('Responsável'),
('Coordenador')
GO

INSERT INTO Cargo (NomeCargo) VALUES
('Diretor'),
('Instrutor de Formação Profissional II')
GO

INSERT INTO TipoPatrimonio (NomeTipo) VALUES
('Mesa'),
('Notebook')
GO

INSERT INTO StatusPatrimonio (NomeStatus) VALUES
('Inativo'),
('Ativo'),
('Transferido'),
('Em manutenção')
GO

INSERT INTO StatusTransferencia (NomeStatus) VALUES
('Pendente de aprovação'),
('Aprovado'),
('Recusado')
GO

INSERT INTO TipoAlteracao (NomeTipo) VALUES
('Atualização de dados'),
('Transfêrencia')
GO

INSERT INTO Cidade (NomeCidade, Estado) VALUES
('São Caetano do Sul', 'São Paulo'),
('Diadema', 'São Paulo')
GO

INSERT INTO Localizacao (NomeLocal, LocalSAP, DescricaoSAP, AreaID) VALUES
('Manutenção', NULL, NULL, (SELECT AreaID FROM Area WHERE NomeArea = 'Bloco A - Térreo'))
GO

INSERT INTO Bairro (NomeBairro, CidadeID) VALUES
('Centro', (SELECT CidadeID FROM Cidade WHERE NomeCidade = 'São Caetano do Sul'))
GO

ALTER TABLE Usuario
ADD PrimeiroAcesso BIT NOT NULL DEFAULT 1;
GO

ALTER TABLE Patrimonio DROP CONSTRAINT FK_Patrimonio_TipoPatrimonio;
GO

DROP TABLE TipoPatrimonio;
GO

ALTER TABLE Patrimonio DROP COLUMN TipoPatrimonioID;
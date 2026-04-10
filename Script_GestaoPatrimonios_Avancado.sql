USE [master]
GO
/****** Object:  Database [GestaoPatrimonios]    Script Date: 09/04/2026 23:51:45 ******/
CREATE DATABASE [GestaoPatrimonios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GestaoPatrimonios', FILENAME = N'C:\Users\araya\GestaoPatrimonios.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GestaoPatrimonios_log', FILENAME = N'C:\Users\araya\GestaoPatrimonios_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GestaoPatrimonios] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GestaoPatrimonios].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GestaoPatrimonios] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET ARITHABORT OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GestaoPatrimonios] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GestaoPatrimonios] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GestaoPatrimonios] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GestaoPatrimonios] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GestaoPatrimonios] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GestaoPatrimonios] SET  MULTI_USER 
GO
ALTER DATABASE [GestaoPatrimonios] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GestaoPatrimonios] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GestaoPatrimonios] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GestaoPatrimonios] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GestaoPatrimonios] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [GestaoPatrimonios] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GestaoPatrimonios] SET QUERY_STORE = ON
GO
ALTER DATABASE [GestaoPatrimonios] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GestaoPatrimonios]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[AreaID] [uniqueidentifier] NOT NULL,
	[NomeArea] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bairro]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bairro](
	[BairroID] [uniqueidentifier] NOT NULL,
	[NomeBairro] [varchar](50) NOT NULL,
	[CidadeID] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BairroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargo](
	[CargoID] [uniqueidentifier] NOT NULL,
	[NomeCargo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CargoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cidade]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cidade](
	[CidadeID] [uniqueidentifier] NOT NULL,
	[NomeCidade] [varchar](50) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CidadeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Endereco]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Endereco](
	[EnderecoID] [uniqueidentifier] NOT NULL,
	[Logradouro] [varchar](100) NOT NULL,
	[Numero] [int] NULL,
	[Complemento] [varchar](20) NULL,
	[CEP] [varchar](10) NULL,
	[BairroID] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EnderecoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Localizacao]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localizacao](
	[LocalizacaoID] [uniqueidentifier] NOT NULL,
	[NomeLocal] [varchar](100) NOT NULL,
	[LocalSAP] [int] NULL,
	[DescricaoSAP] [varchar](100) NULL,
	[Ativo] [bit] NULL,
	[AreaID] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LocalizacaoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocalUsuario]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalUsuario](
	[LocalizacaoID] [uniqueidentifier] NOT NULL,
	[UsuarioID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_LocalUsuario] PRIMARY KEY CLUSTERED 
(
	[LocalizacaoID] ASC,
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogPatrimonio]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogPatrimonio](
	[LogPatrimonioID] [uniqueidentifier] NOT NULL,
	[DataTransferencia] [datetime2](0) NOT NULL,
	[TipoAlteracaoID] [uniqueidentifier] NOT NULL,
	[StatusPatrimonioID] [uniqueidentifier] NOT NULL,
	[PatrimonioID] [uniqueidentifier] NOT NULL,
	[UsuarioID] [uniqueidentifier] NOT NULL,
	[LocalizacaoID] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogPatrimonioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patrimonio]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patrimonio](
	[PatrimonioID] [uniqueidentifier] NOT NULL,
	[Denominacao] [varchar](max) NOT NULL,
	[NumeroPatrimonio] [varchar](30) NOT NULL,
	[Valor] [decimal](10, 2) NULL,
	[Imagem] [varchar](max) NULL,
	[LocalizacaoID] [uniqueidentifier] NOT NULL,
	[StatusPatrimonioID] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PatrimonioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolicitacaoTransferencia]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitacaoTransferencia](
	[TransferenciaID] [uniqueidentifier] NOT NULL,
	[DataCriacaoSolicitacao] [datetime2](0) NOT NULL,
	[DataResposta] [datetime2](0) NULL,
	[Justificativa] [varchar](max) NOT NULL,
	[StatusTransferenciaID] [uniqueidentifier] NOT NULL,
	[UsuarioIDSolicitante] [uniqueidentifier] NOT NULL,
	[UsuarioIDAprovacao] [uniqueidentifier] NULL,
	[PatrimonioID] [uniqueidentifier] NOT NULL,
	[LocalizacaoID] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TransferenciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusPatrimonio]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusPatrimonio](
	[StatusPatrimonioID] [uniqueidentifier] NOT NULL,
	[NomeStatus] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusPatrimonioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTransferencia]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTransferencia](
	[StatusTransferenciaID] [uniqueidentifier] NOT NULL,
	[NomeStatus] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusTransferenciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoAlteracao]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoAlteracao](
	[TipoAlteracaoID] [uniqueidentifier] NOT NULL,
	[NomeTipo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoAlteracaoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuario](
	[TipoUsuarioID] [uniqueidentifier] NOT NULL,
	[NomeTipo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoUsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 09/04/2026 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[UsuarioID] [uniqueidentifier] NOT NULL,
	[NIF] [varchar](7) NOT NULL,
	[Nome] [varchar](150) NOT NULL,
	[RG] [varchar](15) NULL,
	[CPF] [varchar](11) NOT NULL,
	[CarteiraTrabalho] [varchar](14) NOT NULL,
	[Senha] [varbinary](32) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Ativo] [bit] NULL,
	[EnderecoID] [uniqueidentifier] NOT NULL,
	[CargoID] [uniqueidentifier] NOT NULL,
	[TipoUsuarioID] [uniqueidentifier] NOT NULL,
	[PrimeiroAcesso] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Area] ([AreaID], [NomeArea]) VALUES (N'1b9e0b07-d479-46f8-b2d4-d2e3e2285598', N'Bloco A - 1° Andar')
GO
INSERT [dbo].[Area] ([AreaID], [NomeArea]) VALUES (N'c95469b0-58f6-4f0e-88a7-d57e4b4b465d', N'Bloco A - Térreo')
GO
INSERT [dbo].[Bairro] ([BairroID], [NomeBairro], [CidadeID]) VALUES (N'27d7c92f-dc61-4c9b-83b5-362afd5661c5', N'Centro', N'0f333891-41f9-419d-be97-9128e22acabf')
GO
INSERT [dbo].[Bairro] ([BairroID], [NomeBairro], [CidadeID]) VALUES (N'e526143b-a7b6-4904-bf02-d32aff272a24', N'Pilar Velho', N'23caaf0f-14c0-4904-8f26-43048b4d7d3e')
GO
INSERT [dbo].[Cargo] ([CargoID], [NomeCargo]) VALUES (N'3f656d2e-ab28-4b33-af4f-77893f37c0c6', N'Diretor')
GO
INSERT [dbo].[Cargo] ([CargoID], [NomeCargo]) VALUES (N'8111558f-9004-4053-b947-07bcb5aafcb3', N'Instrutor de Formação Profissional II')
GO
INSERT [dbo].[Cidade] ([CidadeID], [NomeCidade], [Estado]) VALUES (N'a747c727-053b-42a5-a998-2e0ea7129501', N'Diadema', N'São Paulo')
GO
INSERT [dbo].[Cidade] ([CidadeID], [NomeCidade], [Estado]) VALUES (N'23caaf0f-14c0-4904-8f26-43048b4d7d3e', N'Ribeirão Pires', N'São Paulo')
GO
INSERT [dbo].[Cidade] ([CidadeID], [NomeCidade], [Estado]) VALUES (N'0f333891-41f9-419d-be97-9128e22acabf', N'São Caetano do Sul', N'São Paulo')
GO
INSERT [dbo].[Endereco] ([EnderecoID], [Logradouro], [Numero], [Complemento], [CEP], [BairroID]) VALUES (N'a48fde78-e7c1-451c-8847-2ecbdc88494e', N'Rua das Goiabeiras', 16, NULL, N'09432-530', N'e526143b-a7b6-4904-bf02-d32aff272a24')
GO
INSERT [dbo].[Localizacao] ([LocalizacaoID], [NomeLocal], [LocalSAP], [DescricaoSAP], [Ativo], [AreaID]) VALUES (N'87594218-acf8-405d-a555-795bc1dcae62', N'Manutenção', NULL, NULL, 1, N'c95469b0-58f6-4f0e-88a7-d57e4b4b465d')
GO
INSERT [dbo].[Patrimonio] ([PatrimonioID], [Denominacao], [NumeroPatrimonio], [Valor], [Imagem], [LocalizacaoID], [StatusPatrimonioID]) VALUES (N'59f63d89-b438-441a-9db5-6a5581e0562c', N'Cadeira', N'4564321', CAST(148.25 AS Decimal(10, 2)), NULL, N'87594218-acf8-405d-a555-795bc1dcae62', N'62b9c334-0426-454f-a481-1ac114ffb160')
GO
INSERT [dbo].[Patrimonio] ([PatrimonioID], [Denominacao], [NumeroPatrimonio], [Valor], [Imagem], [LocalizacaoID], [StatusPatrimonioID]) VALUES (N'7529a554-59b6-4867-9937-9822cc5ea1b4', N'Cadeira', N'123456', CAST(125.25 AS Decimal(10, 2)), NULL, N'87594218-acf8-405d-a555-795bc1dcae62', N'62b9c334-0426-454f-a481-1ac114ffb160')
GO
INSERT [dbo].[Patrimonio] ([PatrimonioID], [Denominacao], [NumeroPatrimonio], [Valor], [Imagem], [LocalizacaoID], [StatusPatrimonioID]) VALUES (N'2f9c7ab8-40e2-4e6e-9d5b-c63fc33b03d1', N'Cadeira', N'456321', CAST(148.25 AS Decimal(10, 2)), NULL, N'87594218-acf8-405d-a555-795bc1dcae62', N'dfc8f1f2-d3ea-4ad2-b879-2b5b56ec2c4a')
GO
INSERT [dbo].[StatusPatrimonio] ([StatusPatrimonioID], [NomeStatus]) VALUES (N'62b9c334-0426-454f-a481-1ac114ffb160', N'Ativo')
GO
INSERT [dbo].[StatusPatrimonio] ([StatusPatrimonioID], [NomeStatus]) VALUES (N'dfc8f1f2-d3ea-4ad2-b879-2b5b56ec2c4a', N'Em manutenção')
GO
INSERT [dbo].[StatusPatrimonio] ([StatusPatrimonioID], [NomeStatus]) VALUES (N'fd89bf7a-0a72-4115-a26a-5fd46d7a5375', N'Inativo')
GO
INSERT [dbo].[StatusPatrimonio] ([StatusPatrimonioID], [NomeStatus]) VALUES (N'e13b5d80-8b25-42c0-b5c3-cdd6ae4e66e0', N'Transferido')
GO
INSERT [dbo].[StatusTransferencia] ([StatusTransferenciaID], [NomeStatus]) VALUES (N'18996ade-b2eb-45af-8e7f-d730266897c8', N'Aprovado')
GO
INSERT [dbo].[StatusTransferencia] ([StatusTransferenciaID], [NomeStatus]) VALUES (N'3c3b87c1-21b4-4c93-9f21-e8722dc9dd6c', N'Pendente de aprovação')
GO
INSERT [dbo].[StatusTransferencia] ([StatusTransferenciaID], [NomeStatus]) VALUES (N'f9497ade-657c-4d9f-8e99-19760b6aa003', N'Recusado')
GO
INSERT [dbo].[TipoAlteracao] ([TipoAlteracaoID], [NomeTipo]) VALUES (N'4b10bf07-e56c-4412-9432-89f5fb814c31', N'Atualização de dados')
GO
INSERT [dbo].[TipoAlteracao] ([TipoAlteracaoID], [NomeTipo]) VALUES (N'e5fe94fe-33ed-41c0-a9a5-3d0996e93185', N'Transfêrencia')
GO
INSERT [dbo].[TipoUsuario] ([TipoUsuarioID], [NomeTipo]) VALUES (N'7096ae2c-c551-44ad-9413-4974f30d2975', N'Coordenador')
GO
INSERT [dbo].[TipoUsuario] ([TipoUsuarioID], [NomeTipo]) VALUES (N'1a0ec45b-8dd6-4aff-be81-5d3e9ae8bca9', N'Responsável')
GO
INSERT [dbo].[Usuario] ([UsuarioID], [NIF], [Nome], [RG], [CPF], [CarteiraTrabalho], [Senha], [Email], [Ativo], [EnderecoID], [CargoID], [TipoUsuarioID], [PrimeiroAcesso]) VALUES (N'82ab8154-73a6-457a-989b-71620faa6f58', N'123456', N'Mayara', NULL, N'14568566325', N'24568566545', 0x8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92, N'mayara@gmail.com', 1, N'a48fde78-e7c1-451c-8847-2ecbdc88494e', N'8111558f-9004-4053-b947-07bcb5aafcb3', N'1a0ec45b-8dd6-4aff-be81-5d3e9ae8bca9', 0)
GO
INSERT [dbo].[Usuario] ([UsuarioID], [NIF], [Nome], [RG], [CPF], [CarteiraTrabalho], [Senha], [Email], [Ativo], [EnderecoID], [CargoID], [TipoUsuarioID], [PrimeiroAcesso]) VALUES (N'f8b5f7b8-5077-43f4-a593-79ffa231d6fa', N'123457', N'Eduardo Bernal', N'1456895621', N'14568567325', N'24568566575', 0x54B688A517F7654563A6C64D945A3670880A4C602EC67A065BBEBBCD2B22EDD5, N'eduardo@gmail.com', 0, N'a48fde78-e7c1-451c-8847-2ecbdc88494e', N'8111558f-9004-4053-b947-07bcb5aafcb3', N'1a0ec45b-8dd6-4aff-be81-5d3e9ae8bca9', 0)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Area__9A7797600CDB1141]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[NomeArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Cargo__4D9FD7DE3D66044B]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Cargo] ADD UNIQUE NONCLUSTERED 
(
	[NomeCargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Patrimon__3BC8B35D5E4FB462]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Patrimonio] ADD UNIQUE NONCLUSTERED 
(
	[NumeroPatrimonio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__StatusPa__C5C60F1AFFA2C01A]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[StatusPatrimonio] ADD UNIQUE NONCLUSTERED 
(
	[NomeStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__StatusTr__C5C60F1AAFFD2841]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[StatusTransferencia] ADD UNIQUE NONCLUSTERED 
(
	[NomeStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoAlte__7859A10A04D31226]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[TipoAlteracao] ADD UNIQUE NONCLUSTERED 
(
	[NomeTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoUsua__7859A10A1DE1B95A]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[TipoUsuario] ADD UNIQUE NONCLUSTERED 
(
	[NomeTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__321537C857083192]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[RG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__6E25BCA22A6BE159]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[CarteiraTrabalho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__A9D10534E0E31067]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__C1F89731F47C0C78]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[CPF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__C7DEC3300B21ED2F]    Script Date: 09/04/2026 23:51:46 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[NIF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT (newid()) FOR [AreaID]
GO
ALTER TABLE [dbo].[Bairro] ADD  DEFAULT (newid()) FOR [BairroID]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT (newid()) FOR [CargoID]
GO
ALTER TABLE [dbo].[Cidade] ADD  DEFAULT (newid()) FOR [CidadeID]
GO
ALTER TABLE [dbo].[Endereco] ADD  DEFAULT (newid()) FOR [EnderecoID]
GO
ALTER TABLE [dbo].[Localizacao] ADD  DEFAULT (newid()) FOR [LocalizacaoID]
GO
ALTER TABLE [dbo].[Localizacao] ADD  DEFAULT ((1)) FOR [Ativo]
GO
ALTER TABLE [dbo].[LogPatrimonio] ADD  DEFAULT (newid()) FOR [LogPatrimonioID]
GO
ALTER TABLE [dbo].[Patrimonio] ADD  DEFAULT (newid()) FOR [PatrimonioID]
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia] ADD  DEFAULT (newid()) FOR [TransferenciaID]
GO
ALTER TABLE [dbo].[StatusPatrimonio] ADD  DEFAULT (newid()) FOR [StatusPatrimonioID]
GO
ALTER TABLE [dbo].[StatusTransferencia] ADD  DEFAULT (newid()) FOR [StatusTransferenciaID]
GO
ALTER TABLE [dbo].[TipoAlteracao] ADD  DEFAULT (newid()) FOR [TipoAlteracaoID]
GO
ALTER TABLE [dbo].[TipoUsuario] ADD  DEFAULT (newid()) FOR [TipoUsuarioID]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (newid()) FOR [UsuarioID]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((1)) FOR [Ativo]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((1)) FOR [PrimeiroAcesso]
GO
ALTER TABLE [dbo].[Bairro]  WITH CHECK ADD  CONSTRAINT [FK_Bairro_Cidade] FOREIGN KEY([CidadeID])
REFERENCES [dbo].[Cidade] ([CidadeID])
GO
ALTER TABLE [dbo].[Bairro] CHECK CONSTRAINT [FK_Bairro_Cidade]
GO
ALTER TABLE [dbo].[Endereco]  WITH CHECK ADD  CONSTRAINT [FK_Endereco_Bairro] FOREIGN KEY([BairroID])
REFERENCES [dbo].[Bairro] ([BairroID])
GO
ALTER TABLE [dbo].[Endereco] CHECK CONSTRAINT [FK_Endereco_Bairro]
GO
ALTER TABLE [dbo].[Localizacao]  WITH CHECK ADD  CONSTRAINT [FK_Localizacao_Area] FOREIGN KEY([AreaID])
REFERENCES [dbo].[Area] ([AreaID])
GO
ALTER TABLE [dbo].[Localizacao] CHECK CONSTRAINT [FK_Localizacao_Area]
GO
ALTER TABLE [dbo].[LocalUsuario]  WITH CHECK ADD  CONSTRAINT [FK_LocalUsuario_Localizacao] FOREIGN KEY([LocalizacaoID])
REFERENCES [dbo].[Localizacao] ([LocalizacaoID])
GO
ALTER TABLE [dbo].[LocalUsuario] CHECK CONSTRAINT [FK_LocalUsuario_Localizacao]
GO
ALTER TABLE [dbo].[LocalUsuario]  WITH CHECK ADD  CONSTRAINT [FK_LocalUsuario_Usuario] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[LocalUsuario] CHECK CONSTRAINT [FK_LocalUsuario_Usuario]
GO
ALTER TABLE [dbo].[LogPatrimonio]  WITH CHECK ADD  CONSTRAINT [FK_LogPatrimonio_Localizacao] FOREIGN KEY([LocalizacaoID])
REFERENCES [dbo].[Localizacao] ([LocalizacaoID])
GO
ALTER TABLE [dbo].[LogPatrimonio] CHECK CONSTRAINT [FK_LogPatrimonio_Localizacao]
GO
ALTER TABLE [dbo].[LogPatrimonio]  WITH CHECK ADD  CONSTRAINT [FK_LogPatrimonio_Patrimonio] FOREIGN KEY([PatrimonioID])
REFERENCES [dbo].[Patrimonio] ([PatrimonioID])
GO
ALTER TABLE [dbo].[LogPatrimonio] CHECK CONSTRAINT [FK_LogPatrimonio_Patrimonio]
GO
ALTER TABLE [dbo].[LogPatrimonio]  WITH CHECK ADD  CONSTRAINT [FK_LogPatrimonio_StatusPatrimonio] FOREIGN KEY([StatusPatrimonioID])
REFERENCES [dbo].[StatusPatrimonio] ([StatusPatrimonioID])
GO
ALTER TABLE [dbo].[LogPatrimonio] CHECK CONSTRAINT [FK_LogPatrimonio_StatusPatrimonio]
GO
ALTER TABLE [dbo].[LogPatrimonio]  WITH CHECK ADD  CONSTRAINT [FK_LogPatrimonio_TipoAlteracao] FOREIGN KEY([TipoAlteracaoID])
REFERENCES [dbo].[TipoAlteracao] ([TipoAlteracaoID])
GO
ALTER TABLE [dbo].[LogPatrimonio] CHECK CONSTRAINT [FK_LogPatrimonio_TipoAlteracao]
GO
ALTER TABLE [dbo].[LogPatrimonio]  WITH CHECK ADD  CONSTRAINT [FK_LogPatrimonio_Usuario] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[LogPatrimonio] CHECK CONSTRAINT [FK_LogPatrimonio_Usuario]
GO
ALTER TABLE [dbo].[Patrimonio]  WITH CHECK ADD  CONSTRAINT [FK_Patrimonio_Localizacao] FOREIGN KEY([LocalizacaoID])
REFERENCES [dbo].[Localizacao] ([LocalizacaoID])
GO
ALTER TABLE [dbo].[Patrimonio] CHECK CONSTRAINT [FK_Patrimonio_Localizacao]
GO
ALTER TABLE [dbo].[Patrimonio]  WITH CHECK ADD  CONSTRAINT [FK_Patrimonio_StatusPatrimonio] FOREIGN KEY([StatusPatrimonioID])
REFERENCES [dbo].[StatusPatrimonio] ([StatusPatrimonioID])
GO
ALTER TABLE [dbo].[Patrimonio] CHECK CONSTRAINT [FK_Patrimonio_StatusPatrimonio]
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia]  WITH CHECK ADD  CONSTRAINT [FK_SolicitacaoTransferencia_Localizacao] FOREIGN KEY([LocalizacaoID])
REFERENCES [dbo].[Localizacao] ([LocalizacaoID])
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia] CHECK CONSTRAINT [FK_SolicitacaoTransferencia_Localizacao]
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia]  WITH CHECK ADD  CONSTRAINT [FK_SolicitacaoTransferencia_Patrimonio] FOREIGN KEY([PatrimonioID])
REFERENCES [dbo].[Patrimonio] ([PatrimonioID])
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia] CHECK CONSTRAINT [FK_SolicitacaoTransferencia_Patrimonio]
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia]  WITH CHECK ADD  CONSTRAINT [FK_SolicitacaoTransferencia_StatusTransferencia] FOREIGN KEY([StatusTransferenciaID])
REFERENCES [dbo].[StatusTransferencia] ([StatusTransferenciaID])
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia] CHECK CONSTRAINT [FK_SolicitacaoTransferencia_StatusTransferencia]
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia]  WITH CHECK ADD  CONSTRAINT [FK_SolicitacaoTransferencia_UsuarioAprovacao] FOREIGN KEY([UsuarioIDAprovacao])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia] CHECK CONSTRAINT [FK_SolicitacaoTransferencia_UsuarioAprovacao]
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia]  WITH CHECK ADD  CONSTRAINT [FK_SolicitacaoTransferencia_UsuarioSolicitacao] FOREIGN KEY([UsuarioIDSolicitante])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[SolicitacaoTransferencia] CHECK CONSTRAINT [FK_SolicitacaoTransferencia_UsuarioSolicitacao]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Cargo] FOREIGN KEY([CargoID])
REFERENCES [dbo].[Cargo] ([CargoID])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Cargo]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Endereco] FOREIGN KEY([EnderecoID])
REFERENCES [dbo].[Endereco] ([EnderecoID])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Endereco]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_TipoUsuario] FOREIGN KEY([TipoUsuarioID])
REFERENCES [dbo].[TipoUsuario] ([TipoUsuarioID])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_TipoUsuario]
GO
USE [master]
GO
ALTER DATABASE [GestaoPatrimonios] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [ROOMIE]    Script Date: 17/05/2026 21:19:29 ******/
CREATE DATABASE [ROOMIE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ROOMIE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ROOMIE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ROOMIE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ROOMIE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ROOMIE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ROOMIE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ROOMIE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ROOMIE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ROOMIE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ROOMIE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ROOMIE] SET ARITHABORT OFF 
GO
ALTER DATABASE [ROOMIE] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ROOMIE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ROOMIE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ROOMIE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ROOMIE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ROOMIE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ROOMIE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ROOMIE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ROOMIE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ROOMIE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ROOMIE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ROOMIE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ROOMIE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ROOMIE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ROOMIE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ROOMIE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ROOMIE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ROOMIE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ROOMIE] SET  MULTI_USER 
GO
ALTER DATABASE [ROOMIE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ROOMIE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ROOMIE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ROOMIE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ROOMIE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ROOMIE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ROOMIE] SET QUERY_STORE = ON
GO
ALTER DATABASE [ROOMIE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ROOMIE]
GO
/****** Object:  Table [dbo].[CITY]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CITY](
	[CityID] [smallint] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](50) NOT NULL,
	[ProvinceID] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONTRACT]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTRACT](
	[ContractID] [int] IDENTITY(1,1) NOT NULL,
	[SignatureDate] [date] NOT NULL,
	[TenantDni] [char](9) NOT NULL,
	[RoomNumber] [tinyint] NOT NULL,
	[PropertyAddress] [varchar](150) NOT NULL,
	[PropertyCityID] [smallint] NOT NULL,
	[PricePerMonth] [smallmoney] NOT NULL,
	[StartingDate] [date] NOT NULL,
	[EndingDate] [date] NOT NULL,
	[Status] [char](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContractID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FURNITURE]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FURNITURE](
	[FurnitureID] [smallint] IDENTITY(1,1) NOT NULL,
	[FurnitureName] [char](20) NOT NULL,
	[FurnitureDescription] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[FurnitureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INSTITUTION]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INSTITUTION](
	[InstitutionID] [smallint] IDENTITY(1,1) NOT NULL,
	[InstitutionName] [varchar](50) NOT NULL,
	[CityID] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InstitutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OWNER]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OWNER](
	[Dni] [char](9) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROPERTY]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROPERTY](
	[Address] [varchar](150) NOT NULL,
	[CityID] [smallint] NOT NULL,
	[OwnerDni] [char](9) NOT NULL,
	[Status] [char](9) NULL,
	[Surface] [decimal](4, 1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Address] ASC,
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROPERTY_INSITUTION]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROPERTY_INSITUTION](
	[InstitutionID] [smallint] NOT NULL,
	[PropertyAddress] [varchar](150) NOT NULL,
	[PropertyCityID] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InstitutionID] ASC,
	[PropertyAddress] ASC,
	[PropertyCityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVINCE]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVINCE](
	[ProvinceID] [char](2) NOT NULL,
	[ProvinceName] [char](26) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REPORT]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPORT](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportDate] [datetime] NOT NULL,
	[UserDni] [char](9) NOT NULL,
	[RoomNumber] [tinyint] NOT NULL,
	[PropertyAddress] [varchar](150) NOT NULL,
	[PropertyCityID] [smallint] NOT NULL,
	[Issue] [char](20) NOT NULL,
	[Details] [varchar](300) NOT NULL,
	[Status] [char](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROOM]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROOM](
	[RoomNumber] [tinyint] IDENTITY(1,1) NOT NULL,
	[PropertyAddress] [varchar](150) NOT NULL,
	[PropertyCityID] [smallint] NOT NULL,
	[Type] [char](15) NOT NULL,
	[Surface] [decimal](3, 1) NOT NULL,
	[Status] [char](12) NULL,
	[PricePerMonth] [smallmoney] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomNumber] ASC,
	[PropertyAddress] ASC,
	[PropertyCityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROOM_FURNITURE]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROOM_FURNITURE](
	[FurnitureID] [smallint] NOT NULL,
	[PropertyAddress] [varchar](150) NOT NULL,
	[PropertyCityID] [smallint] NOT NULL,
	[RoomNumber] [tinyint] NOT NULL,
	[Quantity] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[FurnitureID] ASC,
	[PropertyAddress] ASC,
	[PropertyCityID] ASC,
	[RoomNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TENANT]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TENANT](
	[Dni] [char](9) NOT NULL,
	[StudentLicense] [char](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[Dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 17/05/2026 21:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[Dni] [char](9) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Surnames] [varchar](40) NOT NULL,
	[Birthday] [date] NOT NULL,
	[PhoneNumber] [char](9) NOT NULL,
	[Email] [varchar](60) NOT NULL,
	[Password] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CITY] ON 
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (1, N'San Vicente del Raspeig', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (2, N'Elche', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (3, N'Torrevieja', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (4, N'Orihuela', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (5, N'Benidorm', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (6, N'Alcoy', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (7, N'Elda', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (8, N'Denia', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (9, N'Villajoyosa', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (10, N'Santa Pola', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (11, N'Villena', N'A ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (12, N'Torrent', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (13, N'Gandia', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (14, N'Paterna', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (15, N'Sagunto', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (16, N'Alzira', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (17, N'Mislata', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (18, N'Burjassot', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (19, N'Ontinyent', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (20, N'Xàtiva', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (21, N'Chirivella', N'V ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (22, N'Hospitalet de Llobregat', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (23, N'Badalona', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (24, N'Terrassa', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (25, N'Sabadell', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (26, N'Mataró', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (27, N'Santa Coloma de Gramenet', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (28, N'Cornellà de Llobregat', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (29, N'Sant Cugat del Vallès', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (30, N'Manresa', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (31, N'Granollers', N'B ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (32, N'Móstoles', N'M ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (33, N'Alcalá de Henares', N'M ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (34, N'Fuenlabrada', N'M ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (35, N'Leganés', N'M ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (36, N'Getafe', N'M ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (37, N'Dos Hermanas', N'SE')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (38, N'Alcalá de Guadaíra', N'SE')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (39, N'Utrera', N'SE')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (40, N'Mairena del Aljarafe', N'SE')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (41, N'Écija', N'SE')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (42, N'Gijón', N'O ')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (43, N'Vigo', N'PO')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (44, N'Marbella', N'MA')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (45, N'Cartagena', N'MU')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (46, N'Jerez de la Frontera', N'CA')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (47, N'Barakaldo', N'BI')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (48, N'Talavera de la Reina', N'TO')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (49, N'Ponferrada', N'LE')
GO
INSERT [dbo].[CITY] ([CityID], [CityName], [ProvinceID]) VALUES (50, N'Algeciras', N'CA')
GO
SET IDENTITY_INSERT [dbo].[CITY] OFF
GO
SET IDENTITY_INSERT [dbo].[CONTRACT] ON 
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (1, CAST(N'2025-01-14' AS Date), N'72349581B', 1, N'Calle Mayor 12', 1, 35000.0000, CAST(N'2025-01-15' AS Date), CAST(N'2025-10-14' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (2, CAST(N'2025-01-29' AS Date), N'91368025L', 2, N'Calle Mayor 12', 1, 40000.0000, CAST(N'2025-01-30' AS Date), CAST(N'2025-10-29' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (3, CAST(N'2025-02-11' AS Date), N'24691358P', 3, N'Calle Mayor 12', 1, 30000.0000, CAST(N'2025-02-12' AS Date), CAST(N'2025-11-11' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (4, CAST(N'2025-02-25' AS Date), N'80257914K', 4, N'Avenida de la Libertad 45', 2, 50000.0000, CAST(N'2025-02-26' AS Date), CAST(N'2025-11-25' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (5, CAST(N'2025-03-08' AS Date), N'68035792I', 5, N'Avenida de la Libertad 45', 2, 45000.0000, CAST(N'2025-03-09' AS Date), CAST(N'2025-12-08' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (6, CAST(N'2025-03-19' AS Date), N'58271634E', 6, N'Calle del Mar 3', 3, 28000.0000, CAST(N'2025-03-20' AS Date), CAST(N'2025-12-19' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (7, CAST(N'2025-04-04' AS Date), N'13579246T', 7, N'Calle del Mar 3', 3, 31000.0000, CAST(N'2025-04-05' AS Date), CAST(N'2026-01-04' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (8, CAST(N'2025-04-22' AS Date), N'02479136X', 8, N'Plaza de la Constitución 1', 4, 60000.0000, CAST(N'2025-04-23' AS Date), CAST(N'2026-01-22' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (9, CAST(N'2025-05-03' AS Date), N'80257914V', 9, N'Plaza de la Constitución 1', 4, 58000.0000, CAST(N'2025-05-04' AS Date), CAST(N'2026-02-03' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (10, CAST(N'2025-05-17' AS Date), N'76543210S', 10, N'Plaza de la Constitución 1', 4, 45000.0000, CAST(N'2025-05-18' AS Date), CAST(N'2026-02-17' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (11, CAST(N'2025-05-30' AS Date), N'34567890K', 11, N'Calle San José 22', 5, 34000.0000, CAST(N'2025-05-31' AS Date), CAST(N'2026-02-28' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (12, CAST(N'2025-06-14' AS Date), N'23456789Q', 12, N'Calle San José 22', 5, 34000.0000, CAST(N'2025-06-15' AS Date), CAST(N'2026-03-14' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (13, CAST(N'2025-07-02' AS Date), N'67890123L', 13, N'Avenida Mediterráneo 88', 6, 39000.0000, CAST(N'2025-07-03' AS Date), CAST(N'2026-04-02' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (14, CAST(N'2025-07-26' AS Date), N'80257914A', 14, N'Avenida Mediterráneo 88', 6, 32000.0000, CAST(N'2025-07-27' AS Date), CAST(N'2026-04-26' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (15, CAST(N'2025-08-11' AS Date), N'89012345P', 15, N'Calle Nueva 15', 7, 42000.0000, CAST(N'2025-08-12' AS Date), CAST(N'2026-05-11' AS Date), N'Ended  ')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (16, CAST(N'2025-08-29' AS Date), N'13580247Y', 16, N'Calle Nueva 15', 7, 41000.0000, CAST(N'2025-08-30' AS Date), CAST(N'2026-05-29' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (17, CAST(N'2025-09-15' AS Date), N'10582736C', 17, N'Calle de la Paz 5', 8, 29000.0000, CAST(N'2025-09-16' AS Date), CAST(N'2026-06-15' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (18, CAST(N'2025-10-05' AS Date), N'13580247D', 18, N'Calle de la Paz 5', 8, 27000.0000, CAST(N'2025-10-06' AS Date), CAST(N'2026-07-05' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (19, CAST(N'2025-10-21' AS Date), N'02479136C', 19, N'Avenida de Madrid 101', 9, 65000.0000, CAST(N'2025-10-22' AS Date), CAST(N'2026-07-21' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (20, CAST(N'2025-11-12' AS Date), N'46813570R', 20, N'Avenida de Madrid 101', 9, 55000.0000, CAST(N'2025-11-13' AS Date), CAST(N'2026-08-12' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (21, CAST(N'2025-12-03' AS Date), N'57924681X', 21, N'Avenida de Madrid 101', 9, 45000.0000, CAST(N'2025-12-04' AS Date), CAST(N'2026-09-03' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (22, CAST(N'2025-12-27' AS Date), N'35702469F', 22, N'Calle del Sol 7', 10, 36000.0000, CAST(N'2025-12-28' AS Date), CAST(N'2026-09-27' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (23, CAST(N'2026-01-09' AS Date), N'57924681S', 23, N'Calle del Sol 7', 10, 35000.0000, CAST(N'2026-01-10' AS Date), CAST(N'2026-10-09' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (24, CAST(N'2026-02-02' AS Date), N'12345098H', 24, N'Plaza Mayor 10', 11, 48000.0000, CAST(N'2026-02-03' AS Date), CAST(N'2026-11-02' AS Date), N'Ongoing')
GO
INSERT [dbo].[CONTRACT] ([ContractID], [SignatureDate], [TenantDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [PricePerMonth], [StartingDate], [EndingDate], [Status]) VALUES (25, CAST(N'2026-02-20' AS Date), N'90123456J', 25, N'Plaza Mayor 10', 11, 46000.0000, CAST(N'2026-02-21' AS Date), CAST(N'2026-11-20' AS Date), N'Ongoing')
GO
SET IDENTITY_INSERT [dbo].[CONTRACT] OFF
GO
SET IDENTITY_INSERT [dbo].[FURNITURE] ON 
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (1, N'Bedroom desk        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (2, N'Bed                 ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (3, N'Armchair            ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (4, N'Nightstand          ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (5, N'Desktop             ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (6, N'Simple shelf        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (7, N'Display shelf       ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (8, N'Standing lamp       ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (9, N'Office chair        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (10, N'Rolling cart        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (11, N'Coffee table        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (12, N'Dining room table   ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (13, N'Sofa                ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (14, N'Television          ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (15, N'Wardrobe            ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (16, N'Dining room chair   ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (17, N'Rug                 ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (18, N'Ceiling lamp        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (19, N'Display case        ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (20, N'Cupboard            ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (21, N'Pillow              ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (22, N'Ceiling fan         ', NULL)
GO
INSERT [dbo].[FURNITURE] ([FurnitureID], [FurnitureName], [FurnitureDescription]) VALUES (23, N'Cabinet             ', NULL)
GO
SET IDENTITY_INSERT [dbo].[FURNITURE] OFF
GO
SET IDENTITY_INSERT [dbo].[INSTITUTION] ON 
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (1, N'Universidad de Alicante', 1)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (2, N'Universidad de Elche', 2)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (3, N'Universidad de Torrevieja', 3)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (4, N'Universidad de Orihuela', 4)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (5, N'Universidad de Benidorm', 5)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (6, N'Universidad de Alcoy', 6)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (7, N'Universidad de Elda', 7)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (8, N'Universidad de Denia', 8)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (9, N'Universidad de Villajoyosa', 9)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (10, N'Universidad de Santa Pola', 10)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (11, N'Universidad de Villena', 11)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (12, N'Universidad de Valencia', 12)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (13, N'Universidad de Gandia', 13)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (14, N'Universidad de Paterna', 14)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (15, N'Universidad de Sagunto', 15)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (16, N'Universidad de Alzira', 16)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (17, N'Universidad de Mislata', 17)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (18, N'Universidad de Burjassot', 18)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (19, N'Universidad de Ontiynent', 19)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (20, N'Universidad de Xátiva', 20)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (21, N'Universidad de Chirivella', 21)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (22, N'Universidad de Barcelona', 22)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (23, N'Universidad de Badalona', 23)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (24, N'Universidad de Terrasa', 24)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (25, N'Universidad de Sabadell', 25)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (26, N'Universidad de Mataró', 26)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (27, N'Universidad de Santa Coloma', 27)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (28, N'Universidad de Llobregat', 28)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (29, N'Universidad del Vallés ', 29)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (30, N'Universidad de Madrid', 32)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (31, N'Universidad de Sevilla', 37)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (32, N'Universidad de Asturias', 42)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (33, N'Universidad de Galicia', 43)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (34, N'Universidad de Marbella', 44)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (35, N'Universidad de Murcia', 45)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (36, N'Universidad de Toledo', 48)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (37, N'Universidad de Manresa', 30)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (38, N'Universidad de Granollers', 31)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (39, N'Universidad de Alcalá de Henares', 33)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (40, N'Universidad de Fuenlabrada', 34)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (41, N'Universidad de Leganés', 35)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (42, N'Universidad de Getafe', 36)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (43, N'Universidad de Dos Hermanas', 38)
GO
INSERT [dbo].[INSTITUTION] ([InstitutionID], [InstitutionName], [CityID]) VALUES (44, N'Universidad de Alcalá de Guadaíra', 39)
GO
SET IDENTITY_INSERT [dbo].[INSTITUTION] OFF
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'02479136M')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'13580247N')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'21098765M')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'24681357U')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'24691358E')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'24691358Z')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'29384756F')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'35702469Q')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'35792468V')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'39485726D')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'45678901N')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'46813570G')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'46813579W')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'48291037X')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'54321098R')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'56473829I')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'57924681H')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'68035792T')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'68035792Y')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'79146803J')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'79146803U')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'79146803Z')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'84756123G')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'91368025B')
GO
INSERT [dbo].[OWNER] ([Dni]) VALUES (N'91368025W')
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida de Andalucía 55', 38, N'91368025B', N'Confirmed', CAST(103.4 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida de Francia 12', 13, N'46813579W', N'Pending  ', CAST(92.4 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida de la Constitución 40', 32, N'79146803U', N'Pending  ', CAST(84.2 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida de la Libertad 45', 2, N'13580247N', N'Pending  ', CAST(110.5 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida de los Chopos 21', 17, N'57924681H', N'Pending  ', CAST(99.3 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida de Madrid 101', 9, N'35792468V', N'Pending  ', CAST(130.2 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Avenida Mediterráneo 88', 6, N'24691358Z', N'Confirmed', CAST(78.3 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle de Alcalá 200', 33, N'79146803Z', N'Confirmed', CAST(118.6 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle de la Iglesia 2', 14, N'48291037X', N'Confirmed', CAST(81.0 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle de la Luna 11', 20, N'79146803J', N'Confirmed', CAST(140.5 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle de la Paz 5', 8, N'35702469Q', N'Confirmed', CAST(55.4 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle de la Victoria 14', 37, N'84756123G', N'Denied   ', CAST(91.1 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle de las Flores 9', 18, N'68035792T', N'Confirmed', CAST(112.8 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle del Mar 3', 3, N'21098765M', N'Denied   ', CAST(65.2 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle del Sol 7', 10, N'39485726D', N'Confirmed', CAST(88.9 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle Mayor 12', 1, N'02479136M', N'Confirmed', CAST(85.0 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle Nueva 15', 7, N'29384756F', N'Denied   ', CAST(102.1 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle Real 50', 16, N'56473829I', N'Confirmed', CAST(68.5 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle San José 22', 5, N'24691358E', N'Pending  ', CAST(95.8 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle Sierpes 10', 39, N'91368025W', N'Pending  ', CAST(62.9 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Calle Valencia 4', 12, N'46813570G', N'Confirmed', CAST(70.6 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Paseo de la Estación 33', 15, N'54321098R', N'Denied   ', CAST(105.7 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Plaza de España 5', 19, N'68035792Y', N'Denied   ', CAST(77.0 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Plaza de la Constitución 1', 4, N'24681357U', N'Confirmed', CAST(120.0 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY] ([Address], [CityID], [OwnerDni], [Status], [Surface]) VALUES (N'Plaza Mayor 10', 11, N'45678901N', N'Denied   ', CAST(115.0 AS Decimal(4, 1)))
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (1, N'Calle Mayor 12', 1)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (2, N'Avenida de la Libertad 45', 2)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (3, N'Calle del Mar 3', 3)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (4, N'Plaza de la Constitución 1', 4)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (5, N'Calle San José 22', 5)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (6, N'Avenida Mediterráneo 88', 6)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (7, N'Calle Nueva 15', 7)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (8, N'Calle de la Paz 5', 8)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (9, N'Avenida de Madrid 101', 9)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (10, N'Calle del Sol 7', 10)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (11, N'Plaza Mayor 10', 11)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (12, N'Calle Valencia 4', 12)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (13, N'Avenida de Francia 12', 13)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (14, N'Calle de la Iglesia 2', 14)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (15, N'Paseo de la Estación 33', 15)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (16, N'Calle Real 50', 16)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (17, N'Avenida de los Chopos 21', 17)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (18, N'Calle de las Flores 9', 18)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (19, N'Plaza de España 5', 19)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (20, N'Calle de la Luna 11', 20)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (31, N'Calle de la Victoria 14', 37)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (39, N'Calle de Alcalá 200', 33)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (42, N'Avenida de la Constitución 40', 32)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (43, N'Avenida de Andalucía 55', 38)
GO
INSERT [dbo].[PROPERTY_INSITUTION] ([InstitutionID], [PropertyAddress], [PropertyCityID]) VALUES (44, N'Calle Sierpes 10', 39)
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'AB', N'Albacete                  ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'A ', N'Alicante                  ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'AL', N'Almería                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'O ', N'Asturias                  ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'VI', N'Ávala                     ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'AV', N'Ávila                     ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'BA', N'Badajoz                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'B ', N'Barcelona                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'BU', N'Burgos                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CC', N'Cáceres                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CA', N'Cádiz                     ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'S ', N'Cantabria                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CS', N'Castellón                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CE', N'Ceuta                     ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CR', N'Ciudad Real               ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CO', N'Córdoba                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'CU', N'Cuenca                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'GI', N'Girona                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'GR', N'Granada                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'GU', N'Guadalajara               ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'SS', N'Guipúzcua                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'H ', N'Huelva                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'IB', N'Islas Baleares            ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'J ', N'Jaén                      ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'C ', N'La Coruña                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'LO', N'La Rioja                  ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'GC', N'Las Palmas de Gran Canaria')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'LE', N'León                      ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'L ', N'Lérida                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'LU', N'Lugo                      ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'M ', N'Madrid                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'MA', N'Málaga                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'ML', N'Melilla                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'MU', N'Murcia                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'NA', N'Navarra                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'OU', N'Ourense                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'P ', N'Palencia                  ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'PO', N'Pontevedra                ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'SA', N'Salamanca                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'TF', N'Santa Cruz de Tenerife    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'SG', N'Segovia                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'SE', N'Sevilla                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'SO', N'Soria                     ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'T ', N'Tarragona                 ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'TE', N'Teruel                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'TO', N'Toledo                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'V ', N'Valencia                  ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'VA', N'Valladolid                ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'BI', N'Vizcaya                   ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'ZA', N'Zamora                    ')
GO
INSERT [dbo].[PROVINCE] ([ProvinceID], [ProvinceName]) VALUES (N'Z ', N'Zaragoza                  ')
GO
SET IDENTITY_INSERT [dbo].[REPORT] ON 
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (1, CAST(N'2025-02-15T00:00:00.000' AS DateTime), N'72349581B', 1, N'Calle Mayor 12', 1, N'Cama rota           ', N'Se ha roto la cabecera de la cama', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (2, CAST(N'2025-02-28T00:00:00.000' AS DateTime), N'91368025L', 2, N'Calle Mayor 12', 1, N'Mesita de noche coja', N'Se ha roto una pata de la mesita de noche', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (3, CAST(N'2025-02-15T00:00:00.000' AS DateTime), N'24691358P', 3, N'Calle Mayor 12', 1, N'Luz rota            ', N'La luz de mi habitación no funciona', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (4, CAST(N'2025-03-02T00:00:00.000' AS DateTime), N'80257914K', 4, N'Avenida de la Libertad 45', 2, N'Nevera rota         ', N'La nevera no mantiene el frío', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (5, CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'68035792I', 5, N'Avenida de la Libertad 45', 2, N'Escritorio cojo     ', N'El escritorio de mi habitación se tambalea', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (6, CAST(N'2025-03-21T00:00:00.000' AS DateTime), N'58271634E', 6, N'Calle del Mar 3', 3, N'Lavavajillas roto   ', N'El lavavajillas no limpia bien', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (7, CAST(N'2025-05-05T00:00:00.000' AS DateTime), N'13579246T', 7, N'Calle del Mar 3', 3, N'Cama rota           ', N'El colchón de mi cama es incómodo', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (8, CAST(N'2025-06-01T00:00:00.000' AS DateTime), N'02479136X', 8, N'Plaza de la Constitución 1', 4, N'Luz pasillo         ', N'La luz del pasillo parpadea al encenderla', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (9, CAST(N'2025-05-30T00:00:00.000' AS DateTime), N'80257914V', 9, N'Plaza de la Constitución 1', 4, N'Persiana rota       ', N'La persiana de mi habitación no baja', N'Checked')
GO
INSERT [dbo].[REPORT] ([ReportID], [ReportDate], [UserDni], [RoomNumber], [PropertyAddress], [PropertyCityID], [Issue], [Details], [Status]) VALUES (10, CAST(N'2025-10-10T00:00:00.000' AS DateTime), N'76543210S', 10, N'Plaza de la Constitución 1', 4, N'Espejo roto         ', N'El espejo del baño se ha roto al verme la cara', N'Checked')
GO
SET IDENTITY_INSERT [dbo].[REPORT] OFF
GO
SET IDENTITY_INSERT [dbo].[ROOM] ON 
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (1, N'Calle Mayor 12', 1, N'Bedroom        ', CAST(12.5 AS Decimal(3, 1)), N'Available   ', 350.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (2, N'Calle Mayor 12', 1, N'Bedroom        ', CAST(15.0 AS Decimal(3, 1)), N'Rented      ', 400.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (3, N'Calle Mayor 12', 1, N'Bedroom        ', CAST(10.2 AS Decimal(3, 1)), N'Available   ', 300.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (4, N'Avenida de la Libertad 45', 2, N'Bedroom        ', CAST(18.5 AS Decimal(3, 1)), N'Rented      ', 500.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (5, N'Avenida de la Libertad 45', 2, N'Bedroom        ', CAST(14.0 AS Decimal(3, 1)), N'Available   ', 450.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (6, N'Calle del Mar 3', 3, N'Bedroom        ', CAST(11.0 AS Decimal(3, 1)), N'Shared Space', 280.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (7, N'Calle del Mar 3', 3, N'Bedroom        ', CAST(12.0 AS Decimal(3, 1)), N'Available   ', 310.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (8, N'Plaza de la Constitución 1', 4, N'Bedroom        ', CAST(20.0 AS Decimal(3, 1)), N'Rented      ', 600.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (9, N'Plaza de la Constitución 1', 4, N'Bedroom        ', CAST(19.5 AS Decimal(3, 1)), N'Available   ', 580.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (10, N'Plaza de la Constitución 1', 4, N'Bedroom        ', CAST(15.0 AS Decimal(3, 1)), N'Rented      ', 450.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (11, N'Calle San José 22', 5, N'Bedroom        ', CAST(13.2 AS Decimal(3, 1)), N'Available   ', 340.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (12, N'Calle San José 22', 5, N'Bedroom        ', CAST(12.8 AS Decimal(3, 1)), N'Rented      ', 340.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (13, N'Avenida Mediterráneo 88', 6, N'Bedroom        ', CAST(14.5 AS Decimal(3, 1)), N'Available   ', 390.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (14, N'Avenida Mediterráneo 88', 6, N'Bedroom        ', CAST(11.5 AS Decimal(3, 1)), N'Shared Space', 320.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (15, N'Calle Nueva 15', 7, N'Bedroom        ', CAST(16.0 AS Decimal(3, 1)), N'Rented      ', 420.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (16, N'Calle Nueva 15', 7, N'Bedroom        ', CAST(15.5 AS Decimal(3, 1)), N'Available   ', 410.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (17, N'Calle de la Paz 5', 8, N'Bedroom        ', CAST(10.0 AS Decimal(3, 1)), N'Available   ', 290.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (18, N'Calle de la Paz 5', 8, N'Bedroom        ', CAST(9.5 AS Decimal(3, 1)), N'Rented      ', 270.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (19, N'Avenida de Madrid 101', 9, N'Bedroom        ', CAST(22.0 AS Decimal(3, 1)), N'Available   ', 650.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (20, N'Avenida de Madrid 101', 9, N'Bedroom        ', CAST(18.0 AS Decimal(3, 1)), N'Rented      ', 550.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (21, N'Avenida de Madrid 101', 9, N'Bedroom        ', CAST(15.0 AS Decimal(3, 1)), N'Available   ', 450.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (22, N'Calle del Sol 7', 10, N'Bedroom        ', CAST(14.0 AS Decimal(3, 1)), N'Shared Space', 360.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (23, N'Calle del Sol 7', 10, N'Bedroom        ', CAST(13.5 AS Decimal(3, 1)), N'Available   ', 350.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (24, N'Plaza Mayor 10', 11, N'Bedroom        ', CAST(17.5 AS Decimal(3, 1)), N'Rented      ', 480.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (25, N'Plaza Mayor 10', 11, N'Bedroom        ', CAST(16.5 AS Decimal(3, 1)), N'Available   ', 460.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (26, N'Calle Valencia 4', 12, N'Bedroom        ', CAST(12.0 AS Decimal(3, 1)), N'Available   ', 310.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (27, N'Calle Valencia 4', 12, N'Bedroom        ', CAST(11.5 AS Decimal(3, 1)), N'Rented      ', 300.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (28, N'Avenida de Francia 12', 13, N'Bedroom        ', CAST(15.5 AS Decimal(3, 1)), N'Available   ', 420.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (29, N'Avenida de Francia 12', 13, N'Bedroom        ', CAST(14.0 AS Decimal(3, 1)), N'Shared Space', 380.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (30, N'Calle de la Iglesia 2', 14, N'Bedroom        ', CAST(13.0 AS Decimal(3, 1)), N'Rented      ', 340.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (31, N'Calle de la Iglesia 2', 14, N'Bedroom        ', CAST(12.5 AS Decimal(3, 1)), N'Available   ', 330.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (32, N'Paseo de la Estación 33', 15, N'Bedroom        ', CAST(19.0 AS Decimal(3, 1)), N'Available   ', 520.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (33, N'Paseo de la Estación 33', 15, N'Bedroom        ', CAST(18.0 AS Decimal(3, 1)), N'Rented      ', 500.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (34, N'Calle Real 50', 16, N'Bedroom        ', CAST(11.5 AS Decimal(3, 1)), N'Available   ', 295.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (35, N'Calle Real 50', 16, N'Bedroom        ', CAST(10.8 AS Decimal(3, 1)), N'Rented      ', 280.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (36, N'Avenida de los Chopos 21', 17, N'Bedroom        ', CAST(14.8 AS Decimal(3, 1)), N'Shared Space', 375.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (37, N'Avenida de los Chopos 21', 17, N'Bedroom        ', CAST(13.0 AS Decimal(3, 1)), N'Available   ', 350.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (38, N'Calle de las Flores 9', 18, N'Bedroom        ', CAST(16.5 AS Decimal(3, 1)), N'Rented      ', 440.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (39, N'Calle de las Flores 9', 18, N'Bedroom        ', CAST(15.5 AS Decimal(3, 1)), N'Available   ', 420.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (40, N'Plaza de España 5', 19, N'Bedroom        ', CAST(21.0 AS Decimal(3, 1)), N'Available   ', 590.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (41, N'Plaza de España 5', 19, N'Bedroom        ', CAST(19.0 AS Decimal(3, 1)), N'Rented      ', 540.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (42, N'Calle de la Luna 11', 20, N'Bedroom        ', CAST(13.5 AS Decimal(3, 1)), N'Available   ', 360.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (43, N'Calle de la Luna 11', 20, N'Bedroom        ', CAST(12.0 AS Decimal(3, 1)), N'Shared Space', 330.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (44, N'Avenida de la Constitución 40', 32, N'Bedroom        ', CAST(15.0 AS Decimal(3, 1)), N'Rented      ', 410.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (45, N'Avenida de la Constitución 40', 32, N'Bedroom        ', CAST(14.5 AS Decimal(3, 1)), N'Available   ', 400.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (46, N'Avenida de la Constitución 40', 32, N'Bedroom        ', CAST(13.0 AS Decimal(3, 1)), N'Rented      ', 380.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (47, N'Calle de Alcalá 200', 33, N'Bedroom        ', CAST(25.0 AS Decimal(3, 1)), N'Available   ', 750.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (48, N'Calle de Alcalá 200', 33, N'Bedroom        ', CAST(22.5 AS Decimal(3, 1)), N'Rented      ', 700.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (49, N'Calle de Alcalá 200', 33, N'Bedroom        ', CAST(20.0 AS Decimal(3, 1)), N'Available   ', 650.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (50, N'Calle de la Victoria 14', 37, N'Bedroom        ', CAST(16.0 AS Decimal(3, 1)), N'Shared Space', 430.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (51, N'Calle de la Victoria 14', 37, N'Bedroom        ', CAST(15.5 AS Decimal(3, 1)), N'Available   ', 420.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (52, N'Calle de la Victoria 14', 37, N'Bedroom        ', CAST(14.0 AS Decimal(3, 1)), N'Rented      ', 400.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (53, N'Avenida de Andalucía 55', 38, N'Bedroom        ', CAST(18.0 AS Decimal(3, 1)), N'Available   ', 490.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (54, N'Avenida de Andalucía 55', 38, N'Bedroom        ', CAST(17.5 AS Decimal(3, 1)), N'Rented      ', 480.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (55, N'Avenida de Andalucía 55', 38, N'Bedroom        ', CAST(16.0 AS Decimal(3, 1)), N'Available   ', 450.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (56, N'Calle Sierpes 10', 39, N'Bedroom        ', CAST(14.5 AS Decimal(3, 1)), N'Rented      ', 380.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (57, N'Calle Sierpes 10', 39, N'Bedroom        ', CAST(13.5 AS Decimal(3, 1)), N'Available   ', 360.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (58, N'Calle Sierpes 10', 39, N'Bedroom        ', CAST(12.0 AS Decimal(3, 1)), N'Shared Space', 340.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (59, N'Calle Mayor 12', 1, N'Bedroom        ', CAST(11.0 AS Decimal(3, 1)), N'Available   ', 300.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (60, N'Avenida de la Libertad 45', 2, N'Bedroom        ', CAST(12.5 AS Decimal(3, 1)), N'Available   ', 350.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (61, N'Calle del Mar 3', 3, N'Bedroom        ', CAST(10.5 AS Decimal(3, 1)), N'Rented      ', 290.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (62, N'Calle San José 22', 5, N'Bedroom        ', CAST(11.8 AS Decimal(3, 1)), N'Available   ', 310.0000)
GO
INSERT [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID], [Type], [Surface], [Status], [PricePerMonth]) VALUES (63, N'Avenida Mediterráneo 88', 6, N'Bedroom        ', CAST(13.0 AS Decimal(3, 1)), N'Available   ', 340.0000)
GO
SET IDENTITY_INSERT [dbo].[ROOM] OFF
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (1, N'Avenida de la Libertad 45', 2, 4, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (1, N'Avenida de Madrid 101', 9, 19, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (1, N'Avenida Mediterráneo 88', 6, 13, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (1, N'Calle de las Flores 9', 18, 38, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (1, N'Calle Valencia 4', 12, 26, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (1, N'Paseo de la Estación 33', 15, 33, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de Francia 12', 13, 28, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de Francia 12', 13, 29, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de la Libertad 45', 2, 4, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de la Libertad 45', 2, 5, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de los Chopos 21', 17, 36, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de los Chopos 21', 17, 37, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de Madrid 101', 9, 19, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de Madrid 101', 9, 20, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida de Madrid 101', 9, 21, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida Mediterráneo 88', 6, 13, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Avenida Mediterráneo 88', 6, 14, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle de la Iglesia 2', 14, 30, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle de la Iglesia 2', 14, 31, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle de la Paz 5', 8, 17, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle de la Paz 5', 8, 18, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle de las Flores 9', 18, 38, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle de las Flores 9', 18, 39, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle del Mar 3', 3, 6, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle del Mar 3', 3, 7, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Mayor 12', 1, 1, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Mayor 12', 1, 2, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Mayor 12', 1, 3, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Nueva 15', 7, 15, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Nueva 15', 7, 16, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Real 50', 16, 34, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Real 50', 16, 35, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle San José 22', 5, 11, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle San José 22', 5, 12, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Valencia 4', 12, 26, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Calle Valencia 4', 12, 27, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Paseo de la Estación 33', 15, 32, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Paseo de la Estación 33', 15, 33, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Plaza de España 5', 19, 40, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Plaza de la Constitución 1', 4, 8, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Plaza de la Constitución 1', 4, 9, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Plaza de la Constitución 1', 4, 10, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Plaza Mayor 10', 11, 24, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (2, N'Plaza Mayor 10', 11, 25, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Avenida de Francia 12', 13, 28, 2)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Avenida de Madrid 101', 9, 20, 2)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle de la Iglesia 2', 14, 31, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle de las Flores 9', 18, 39, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle del Mar 3', 3, 7, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle Mayor 12', 1, 2, 2)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle Nueva 15', 7, 16, 2)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle Real 50', 16, 35, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Calle San José 22', 5, 11, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (4, N'Plaza Mayor 10', 11, 24, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (8, N'Calle de la Paz 5', 8, 17, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (8, N'Calle del Mar 3', 3, 6, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Avenida de Francia 12', 13, 29, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Avenida de la Libertad 45', 2, 5, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Avenida de los Chopos 21', 17, 36, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Calle de la Paz 5', 8, 18, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Calle Mayor 12', 1, 1, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Calle Nueva 15', 7, 15, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Calle San José 22', 5, 12, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Paseo de la Estación 33', 15, 32, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Plaza de España 5', 19, 40, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Plaza de la Constitución 1', 4, 8, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (15, N'Plaza Mayor 10', 11, 25, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (18, N'Avenida Mediterráneo 88', 6, 14, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (18, N'Calle Real 50', 16, 34, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (18, N'Calle Valencia 4', 12, 27, 1)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (21, N'Avenida de los Chopos 21', 17, 37, 2)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (21, N'Plaza de la Constitución 1', 4, 9, 2)
GO
INSERT [dbo].[ROOM_FURNITURE] ([FurnitureID], [PropertyAddress], [PropertyCityID], [RoomNumber], [Quantity]) VALUES (22, N'Calle de la Iglesia 2', 14, 30, 1)
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'72349581B', N'10293847')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'91368025L', N'11009922')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'24691358P', N'11447700')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'80257914K', N'12345678')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'68035792I', N'22558877')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'58271634E', N'22660033')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'13579246T', N'22884477')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'02479136X', N'33698521')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'80257914V', N'33991177')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'76543210S', N'44112233')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'34567890K', N'44227755')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'23456789Q', N'44771100')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'67890123L', N'55214789')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'80257914A', N'55882244')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'89012345P', N'66339988')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'13580247Y', N'66442299')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'10582736C', N'66883311')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'13580247D', N'77331144')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'02479136C', N'77412589')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'46813570R', N'84920311')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'57924681X', N'88115522')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'35702469F', N'88552211')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'57924681S', N'99228855')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'12345098H', N'99551144')
GO
INSERT [dbo].[TENANT] ([Dni], [StudentLicense]) VALUES (N'90123456J', N'99663322')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'02479136C', N'Noa', N'Gutiérrez Reyes', CAST(N'1995-09-16' AS Date), N'644998877', N'noa.gr@email.com', N'nG2_land')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'02479136M', N'Nerea', N'Beltrán Flores', CAST(N'1985-04-11' AS Date), N'611223399', N'nerea.bf@email.com', N'nB5_look')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'02479136X', N'Rocío', N'Merino Cabrera', CAST(N'1991-10-09' AS Date), N'644778822', N'rocio.mc@email.com', N'rM7_life')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'10582736C', N'Mateo', N'López Sánchez', CAST(N'1988-11-05' AS Date), N'689574123', N'mateo.ls@email.com', N'mL5#safe')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'12345098H', N'Valentina', N'Muñoz Jiménez', CAST(N'1991-02-08' AS Date), N'699001122', N'valen.mj@email.com', N'vM6_key1')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'13579246T', N'Iker', N'Cortes Castillo', CAST(N'1981-09-10' AS Date), N'699223344', N'iker.cc@email.com', N'iC4*star')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'13580247D', N'Mario', N'Pastor Soler', CAST(N'1980-02-05' AS Date), N'688112233', N'mario.ps@email.com', N'mP5*fire')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'13580247N', N'Gonzalo', N'Galán Jurado', CAST(N'1992-06-28' AS Date), N'633554433', N'gonzalo.gj@email.com', N'gG1*park')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'13580247Y', N'Ismael', N'Velasco Solís', CAST(N'1984-12-25' AS Date), N'688223311', N'ismael.vs@email.com', N'iV2*love')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'21098765M', N'Daniel', N'Gil Blanco', CAST(N'1986-01-15' AS Date), N'611998877', N'daniel.gb@email.com', N'dG4*point')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'23456789Q', N'Emma', N'Morales Nuñez', CAST(N'1997-11-13' AS Date), N'677443322', N'emma.mn@email.com', N'eM2#user')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'24681357U', N'Carla', N'Rubio Santos', CAST(N'1990-12-02' AS Date), N'622778899', N'carla.rs@email.com', N'cR6.link')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'24691358E', N'Inés', N'Gallardo Aguilar', CAST(N'1988-11-21' AS Date), N'611443322', N'ines.ga@email.com', N'iG8.cool')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'24691358P', N'Ainhoa', N'Conde Quintana', CAST(N'1987-09-14' AS Date), N'677112288', N'ainhoa.cq@email.com', N'aC4.hill')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'24691358Z', N'Nuria', N'Pallarés León', CAST(N'1995-04-13' AS Date), N'611445500', N'nuria.pl@email.com', N'nP5.home')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'29384756F', N'Elena', N'Rodríguez Díaz', CAST(N'2000-07-19' AS Date), N'633445566', N'elena.rd@email.com', N'eR8=pass')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'34567890K', N'Leo', N'Delgado Torres', CAST(N'1994-04-03' AS Date), N'688776655', N'leo.dt@email.com', N'lD9+fast')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'35702469F', N'Bruno', N'Escribano Lara', CAST(N'1993-03-12' AS Date), N'666221100', N'bruno.el@email.com', N'bE1#city')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'35702469Q', N'Rodrigo', N'Casado Rivas', CAST(N'1994-02-23' AS Date), N'622998800', N'rodrigo.cr@email.com', N'rC8#lake')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'35792468V', N'Marcos', N'Pascual Lozano', CAST(N'1998-03-18' AS Date), N'600334455', N'marcos.pl@email.com', N'mP9#jump')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'39485726D', N'Sofía', N'Pérez Gómez', CAST(N'1995-01-30' AS Date), N'600112233', N'sofia.perez@email.com', N'sP1+data')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'45678901N', N'Sara', N'Ramírez Castro', CAST(N'1993-05-09' AS Date), N'633221100', N'sara.rc@email.com', N'sR3.work')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'46813570G', N'Candela', N'Pardo Arenas', CAST(N'1986-07-24' AS Date), N'600887766', N'candela.pa@email.com', N'cP6=open')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'46813570R', N'Miriam', N'Vila Blasco', CAST(N'1981-11-07' AS Date), N'644445566', N'miriam.vb@email.com', N'mV2=rain')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'46813579W', N'Clara', N'Vega Herrera', CAST(N'1985-05-26' AS Date), N'644112233', N'clara.vh@email.com', N'cV2=nice')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'48291037X', N'Hugo', N'García Fernández', CAST(N'1985-05-12' AS Date), N'610293847', N'hugo.garcia@email.com', N'hG9_pass')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'54321098R', N'Adrián', N'Ortega Medina', CAST(N'1984-02-04' AS Date), N'611001199', N'adrian.om@email.com', N'aO8+gold')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'56473829I', N'Lucas', N'Álvarez Romero', CAST(N'1987-06-17' AS Date), N'622334455', N'lucas.alv@email.com', N'lA2.best')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'57924681H', N'Jorge', N'Lorenzo Franco', CAST(N'1997-05-31' AS Date), N'633990011', N'jorge.lf@email.com', N'jL4_step')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'57924681S', N'Rafael', N'Bravo Vico', CAST(N'1996-05-20' AS Date), N'688001144', N'rafael.bv@email.com', N'rB6_song')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'57924681X', N'Javier', N'Méndez Esteban', CAST(N'1992-07-07' AS Date), N'688445566', N'javier.me@email.com', N'jM3_flow')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'58271634E', N'Martín', N'González Cano', CAST(N'1980-03-14' AS Date), N'677889900', N'martin.gonz@email.com', N'mG4.secure')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'67890123L', N'Julia', N'Vázquez Ramos', CAST(N'1982-10-27' AS Date), N'644556677', N'julia.vr@email.com', N'jV1_admin')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'68035792I', N'Alicia', N'Montero Mora', CAST(N'1984-10-06' AS Date), N'677002233', N'alicia.mm@email.com', N'aM3*road')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'68035792T', N'Esther', N'Egea Fuentes', CAST(N'1989-08-12' AS Date), N'611667722', N'esther.ef@email.com', N'eE3*mind')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'68035792Y', N'Marta', N'Hidalgo Marcos', CAST(N'1987-10-14' AS Date), N'611556677', N'marta.hm@email.com', N'mH7*peak')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'72349581B', N'Lucía', N'Martínez Ruiz', CAST(N'1992-08-22' AS Date), N'654321098', N'lucia.mtz@email.com', N'lM2*root')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'76543210S', N'Lola', N'Garrido León', CAST(N'1996-06-28' AS Date), N'655889911', N'lola.gl@email.com', N'lG1_blue')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'79146803J', N'David', N'Iglesias Luna', CAST(N'1990-12-15' AS Date), N'622556677', N'david.il@email.com', N'dI9.west')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'79146803U', N'Oliver', N'Manso Serra', CAST(N'1983-01-04' AS Date), N'633889955', N'oliver.ms@email.com', N'oM9.kind')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'79146803Z', N'Diego', N'Ibañez Nieto', CAST(N'1994-01-29' AS Date), N'633778899', N'diego.in@email.com', N'dI1.up77')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'80257914A', N'Paula', N'Vicente Ferrer', CAST(N'1983-04-01' AS Date), N'677221100', N'paula.vf@email.com', N'pV4#door')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'80257914K', N'Irene', N'Giménez Izquierdo', CAST(N'1982-08-02' AS Date), N'644332211', N'irene.gi@email.com', N'iG2#east')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'80257914V', N'Berta', N'Cano Santiago', CAST(N'1998-03-26' AS Date), N'677334411', N'berta.cs@email.com', N'bC1#hope')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'84756123G', N'Alejandro', N'Hernández Moreno', CAST(N'1983-09-25' AS Date), N'611223344', N'alex.hm@email.com', N'aH3-word')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'89012345P', N'Pablo', N'Molina Ortiz', CAST(N'1989-08-21' AS Date), N'666554433', N'pablo.mo@email.com', N'pM5-test')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'90123456J', N'Alba', N'Suárez Navarro', CAST(N'1999-12-11' AS Date), N'655667788', N'alba.sn@email.com', N'aS7#code')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'91368025B', N'Álvaro', N'Crespo Diez', CAST(N'1991-06-23' AS Date), N'622001122', N'alvaro.cd@email.com', N'aC9+wind')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'91368025L', N'Samuel', N'Sanz Marín', CAST(N'1999-01-19' AS Date), N'688667788', N'samuel.sm@email.com', N'sS7+near')
GO
INSERT [dbo].[USER] ([Dni], [Name], [Surnames], [Birthday], [PhoneNumber], [Email], [Password]) VALUES (N'91368025W', N'Marcos', N'Benítez Acosta', CAST(N'1980-07-17' AS Date), N'622110099', N'marcos.ba@email.com', N'mB4+soul')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CONTRACT__948EE2AA964B1250]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[CONTRACT] ADD UNIQUE NONCLUSTERED 
(
	[TenantDni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__FURNITUR__3365F5BBC523B20F]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[FURNITURE] ADD UNIQUE NONCLUSTERED 
(
	[FurnitureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PROPERTY__B41FE412CEC86781]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[PROPERTY] ADD UNIQUE NONCLUSTERED 
(
	[OwnerDni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PROVINCE__B27F237245B1C2E5]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[PROVINCE] ADD UNIQUE NONCLUSTERED 
(
	[ProvinceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__REPORT__2F83177EBA33C90A]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[REPORT] ADD UNIQUE NONCLUSTERED 
(
	[UserDni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TENANT__CC0E2FB6522B7D20]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[TENANT] ADD UNIQUE NONCLUSTERED 
(
	[StudentLicense] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__USER__85FB4E38C6C73B15]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[USER] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__USER__A9D105340A1DCFFC]    Script Date: 17/05/2026 21:19:30 ******/
ALTER TABLE [dbo].[USER] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CONTRACT] ADD  DEFAULT ('Ongoing') FOR [Status]
GO
ALTER TABLE [dbo].[PROPERTY] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[REPORT] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[ROOM_FURNITURE] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[CITY]  WITH CHECK ADD FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[PROVINCE] ([ProvinceID])
GO
ALTER TABLE [dbo].[CONTRACT]  WITH CHECK ADD FOREIGN KEY([RoomNumber], [PropertyAddress], [PropertyCityID])
REFERENCES [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID])
GO
ALTER TABLE [dbo].[CONTRACT]  WITH CHECK ADD FOREIGN KEY([TenantDni])
REFERENCES [dbo].[TENANT] ([Dni])
GO
ALTER TABLE [dbo].[INSTITUTION]  WITH CHECK ADD FOREIGN KEY([CityID])
REFERENCES [dbo].[CITY] ([CityID])
GO
ALTER TABLE [dbo].[OWNER]  WITH CHECK ADD FOREIGN KEY([Dni])
REFERENCES [dbo].[USER] ([Dni])
GO
ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD FOREIGN KEY([CityID])
REFERENCES [dbo].[CITY] ([CityID])
GO
ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD FOREIGN KEY([OwnerDni])
REFERENCES [dbo].[OWNER] ([Dni])
GO
ALTER TABLE [dbo].[PROPERTY_INSITUTION]  WITH CHECK ADD FOREIGN KEY([InstitutionID])
REFERENCES [dbo].[INSTITUTION] ([InstitutionID])
GO
ALTER TABLE [dbo].[PROPERTY_INSITUTION]  WITH CHECK ADD FOREIGN KEY([PropertyAddress], [PropertyCityID])
REFERENCES [dbo].[PROPERTY] ([Address], [CityID])
GO
ALTER TABLE [dbo].[REPORT]  WITH CHECK ADD FOREIGN KEY([RoomNumber], [PropertyAddress], [PropertyCityID])
REFERENCES [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID])
GO
ALTER TABLE [dbo].[REPORT]  WITH CHECK ADD FOREIGN KEY([UserDni])
REFERENCES [dbo].[USER] ([Dni])
GO
ALTER TABLE [dbo].[ROOM]  WITH CHECK ADD FOREIGN KEY([PropertyAddress], [PropertyCityID])
REFERENCES [dbo].[PROPERTY] ([Address], [CityID])
GO
ALTER TABLE [dbo].[ROOM_FURNITURE]  WITH CHECK ADD FOREIGN KEY([FurnitureID])
REFERENCES [dbo].[FURNITURE] ([FurnitureID])
GO
ALTER TABLE [dbo].[ROOM_FURNITURE]  WITH CHECK ADD FOREIGN KEY([RoomNumber], [PropertyAddress], [PropertyCityID])
REFERENCES [dbo].[ROOM] ([RoomNumber], [PropertyAddress], [PropertyCityID])
GO
ALTER TABLE [dbo].[TENANT]  WITH CHECK ADD FOREIGN KEY([Dni])
REFERENCES [dbo].[USER] ([Dni])
GO
ALTER TABLE [dbo].[CONTRACT]  WITH CHECK ADD CHECK  ((datediff(day,[StartingDate],[EndingDate])>(0)))
GO
ALTER TABLE [dbo].[CONTRACT]  WITH CHECK ADD CHECK  (([Status]='Ended' OR [Status]='Ongoing'))
GO
ALTER TABLE [dbo].[CONTRACT]  WITH CHECK ADD CHECK  (([TenantDni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
GO
ALTER TABLE [dbo].[OWNER]  WITH CHECK ADD CHECK  (([Dni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
GO
ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD CHECK  (([OwnerDni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
GO
ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD CHECK  (([Status]='Denied' OR [Status]='Confirmed' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[REPORT]  WITH CHECK ADD CHECK  (([Status]='Checked' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[REPORT]  WITH CHECK ADD CHECK  (([UserDni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
GO
ALTER TABLE [dbo].[ROOM]  WITH CHECK ADD CHECK  (([Status]='Shared Space' OR [Status]='Rented' OR [Status]='Available'))
GO
ALTER TABLE [dbo].[ROOM]  WITH CHECK ADD CHECK  (([Type]='Storage Room' OR [Type]='Dinning Room' OR [Type]='Bedroom' OR [Type]='Hall' OR [Type]='Bathroom' OR [Type]='Balcony' OR [Type]='Living Room' OR [Type]='Kitchen'))
GO
ALTER TABLE [dbo].[ROOM_FURNITURE]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[TENANT]  WITH CHECK ADD CHECK  (([Dni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
GO
ALTER TABLE [dbo].[TENANT]  WITH CHECK ADD CHECK  (([StudentLicense] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD CHECK  (([Dni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD CHECK  (([Password] like '%[A-Z]%' AND [Password] like '%[a-z]%' AND [Password] like '%[0-9]%' AND [Password] like '%[-.+_#*=]%'))
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD CHECK  (([PhoneNumber] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
USE [master]
GO
ALTER DATABASE [ROOMIE] SET  READ_WRITE 
GO

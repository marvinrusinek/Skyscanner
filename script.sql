USE [master]
GO
/****** Object:  Database [FlightDB]    Script Date: 05/15/2011 11:45:37 ******/
CREATE DATABASE [FlightDB] ON  PRIMARY 
( NAME = N'FlightDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\FlightDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FlightDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\FlightDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FlightDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FlightDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FlightDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [FlightDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [FlightDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [FlightDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [FlightDB] SET ARITHABORT OFF
GO
ALTER DATABASE [FlightDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [FlightDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [FlightDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [FlightDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [FlightDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [FlightDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [FlightDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [FlightDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [FlightDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [FlightDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [FlightDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [FlightDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [FlightDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [FlightDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [FlightDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [FlightDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [FlightDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [FlightDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [FlightDB] SET  READ_WRITE
GO
ALTER DATABASE [FlightDB] SET RECOVERY FULL
GO
ALTER DATABASE [FlightDB] SET  MULTI_USER
GO
ALTER DATABASE [FlightDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [FlightDB] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'FlightDB', N'ON'
GO
USE [FlightDB]
GO
/****** Object:  Table [dbo].[flightuserlogininfo]    Script Date: 05/15/2011 11:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[flightuserlogininfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](20) NOT NULL,
	[mname] [varchar](20) NOT NULL,
	[lname] [varchar](20) NOT NULL,
	[username] [varchar](20) NOT NULL,
	[email] [varchar](30) NOT NULL,
	[password] [varchar](30) NOT NULL,
 CONSTRAINT [PK_flightuser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[flightuserinfo]    Script Date: 05/15/2011 11:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[flightuserinfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gender] [varchar](10) NOT NULL,
	[phonenum] [varchar](30) NOT NULL,
	[dob] [varchar](20) NOT NULL,
	[emer_fname] [varchar](20) NOT NULL,
	[emer_lname] [varchar](20) NOT NULL,
	[emer_phonenum] [varchar](30) NOT NULL,
 CONSTRAINT [PK_flightuserinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[flightpreferences]    Script Date: 05/15/2011 11:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[flightpreferences](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](20) NOT NULL,
	[mname] [varchar](20) NOT NULL,
	[lname] [varchar](20) NOT NULL,
	[seat] [varchar](20) NOT NULL,
	[meal] [varchar](30) NOT NULL,
	[assistance] [varchar](50) NOT NULL,
 CONSTRAINT [PK_flightpreferences] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[flightorder]    Script Date: 05/15/2011 11:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[flightorder](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[totalprice] [varchar](20) NOT NULL,
	[cctype] [varchar](30) NOT NULL,
	[ccnumber] [varchar](16) NOT NULL,
	[ccsecuritycode] [varchar](3) NOT NULL,
	[ccexpdate] [varchar](20) NOT NULL,
	[ccholdername] [varchar](50) NOT NULL,
	[streetaddr] [varchar](50) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[zipcode] [varchar](20) NOT NULL,
	[country] [varchar](50) NOT NULL,
	[phonenum] [varchar](30) NOT NULL,
 CONSTRAINT [PK_flightorder] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[flightinfo]    Script Date: 05/15/2011 11:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[flightinfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[flightnum] [varchar](10) NOT NULL,
	[airline] [varchar](20) NOT NULL,
	[origin] [varchar](20) NOT NULL,
	[departdate] [varchar](20) NOT NULL,
	[departtime] [varchar](10) NOT NULL,
	[destination] [varchar](20) NOT NULL,
	[arrivaldate] [varchar](20) NOT NULL,
	[arrivaltime] [varchar](10) NOT NULL,
	[stops] [varchar](2) NOT NULL,
	[duration] [varchar](20) NOT NULL,
	[returndate] [varchar](20) NOT NULL,
	[returntime] [varchar](10) NOT NULL,
	[cabintype] [varchar](20) NOT NULL,
	[price] [varchar](20) NOT NULL,
 CONSTRAINT [PK_flightinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[flightconfirmation]    Script Date: 05/15/2011 11:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[flightconfirmation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[confnum] [varchar](6) NOT NULL,
 CONSTRAINT [PK_flightconfirmation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_flightuserlogininfo]    Script Date: 05/15/2011 11:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Template generated from Template Explorer using:
CREATE PROCEDURE [dbo].[sp_insert_flightuserlogininfo]
	(@fname varchar(20),
	@mname varchar(20),
	@lname varchar(20),
	@username varchar(20),
	@email varchar(30),
	@password varchar(30))
AS BEGIN
	INSERT INTO FlightDB.dbo.flightuserlogininfo(fname, mname, lname, username, email, password)	
	VALUES (@fname, @mname, @lname, @username, @email, @password)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_flightuserinfo]    Script Date: 05/15/2011 11:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_flightuserinfo]
	(@gender varchar(10),
	@phonenum varchar(30),
	@dob varchar(20),
	@emer_fname varchar(20),
	@emer_lname varchar(20),
	@emer_phonenum varchar(30))
AS BEGIN
	INSERT INTO FlightDB.dbo.flightuserinfo(gender, phonenum, dob, emer_fname, emer_lname, emer_phonenum)	
	VALUES (@gender, @phonenum, @dob, @emer_fname, @emer_lname, @emer_phonenum)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_flightpreferences]    Script Date: 05/15/2011 11:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_flightpreferences]
	(@fname varchar(20),
	@mname varchar(20),
	@lname varchar(20),
	@seat varchar(20),
	@meal varchar(30),
	@assistance varchar(50))
AS BEGIN
	INSERT INTO FlightDB.dbo.flightpreferences(fname, mname, lname, seat, meal, assistance)	
	VALUES (@fname, @mname, @lname, @seat, @meal, @assistance)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_flightorder]    Script Date: 05/15/2011 11:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_flightorder]
	(@totalprice varchar(20),
	@cctype varchar(30),
	@ccnumber varchar(16),
	@ccsecuritycode varchar(3),
	@ccexpdate varchar(20),
	@ccholdername varchar(50),
	@streetaddr varchar(50),
	@city varchar(20),
	@state varchar(2),
	@zipcode varchar(20),
	@country varchar(50),
	@phonenum varchar(30))
AS BEGIN
	INSERT INTO FlightDB.dbo.flightorder(totalprice, cctype, ccnumber, ccsecuritycode, 
	ccexpdate, ccholdername, streetaddr, city, state, zipcode, country, phonenum)	
	VALUES (@totalprice, @cctype, @ccnumber, @ccsecuritycode, @ccexpdate, @ccholdername, 
	@streetaddr, @city, @state, @zipcode, @country, @phonenum)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_flightinfo]    Script Date: 05/15/2011 11:45:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_flightinfo]
	(@flightnum varchar(10),
	@airline varchar(20),
	@origin varchar(20),
	@departdate varchar(20),
	@departtime varchar(10),
	@destination varchar(20),
	@arrivaldate varchar(20),
	@arrivaltime varchar(10),
	@stops varchar(2),
	@duration varchar(20),
	@returndate varchar(20),
	@returntime varchar(10),
	@cabintype varchar(20),
	@price varchar(20))
AS BEGIN
	INSERT INTO FlightDB.dbo.flightinfo(flightnum, airline, origin, departdate, departtime, 
	destination, arrivaldate, arrivaltime, stops, duration, returndate, returntime,
	cabintype, price)	
	VALUES (@flightnum, @airline, @origin, @departdate, @departtime, @destination, 
	@arrivaldate, @arrivaltime, @stops, @duration, @returndate, @returntime, @cabintype,
	@price)
END
GO

USE [SCSA]
GO
/****** Object:  Table [dbo].[GLB_USUARIOS]    Script Date: 02/28/2015 10:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
ALTER TABLE dbo.CONF_USUARIO DROP CONSTRAINT FK_CONF_USUARIO_GLB_USUARIOS; 
GO

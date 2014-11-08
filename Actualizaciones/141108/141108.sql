ALTER TABLE GLB_EMPLEADOS
	ADD DS_CORREO VARCHAR(75) NOT NULL;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'CORREO ELECTRÓNICO DE EMPLEADO TEG' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'GLB_EMPLEADOS', 
	@level2type=N'COLUMN',@level2name=N'DS_CORREO'
GO


ALTER TABLE GLB_SOLICITANTES
	ADD DS_CORREO VARCHAR(75) NULL;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'CORREO ELECTRÓNICO DE SOLICITANTE EXTERNO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'GLB_SOLICITANTES', 
	@level2type=N'COLUMN',@level2name=N'DS_CORREO'
GO

ALTER TABLE AGD_PUNTOS_AGENDA
	ADD CD_EJERCICIO VARCHAR(4) NOT NULL,
	CD_PERIODO VARCHAR(2) NOT NULL,
	FE_FECH_SOLIC DATE NOT NULL,
	DS_JUSTIFICA VARCHAR(1000) NULL,
	CD_TIPO_CORRESP CHAR(1)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE AÑO EN QUE SE CREA EL REGISTRO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_PUNTOS_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'CD_EJERCICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE MES EN QUE SE CREA EL REGISTRO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_PUNTOS_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'CD_PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'FECHA DE SOLICITUD O RECEPCIÓN DE CORRESPONDENCIA' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_PUNTOS_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'FE_FECH_SOLIC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'JUSTIFICACIÓN O DESCRIPCIÓN EXTENSA DE LA SOLICITUD O CORRESPONDENCIA' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_PUNTOS_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'DS_JUSTIFICA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE TIPO DE CORRESPONDENCIA (A - Soporte de Acta, C - Correspondencia Normal)' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_PUNTOS_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'CD_TIPO_CORRESP'
GO


-- ***

ALTER TABLE AGD_ENCA_CONVOCATORIA
	ADD CD_EJERCICIO VARCHAR(4) NOT NULL,
	CD_PERIODO VARCHAR(2) NOT NULL
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE AÑO EN QUE SE CREA EL REGISTRO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_ENCA_CONVOCATORIA', 
	@level2type=N'COLUMN',@level2name=N'CD_EJERCICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE MES EN QUE SE CREA EL REGISTRO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_ENCA_CONVOCATORIA', 
	@level2type=N'COLUMN',@level2name=N'CD_PERIODO'


ALTER TABLE GLB_MIEMBROS_PLENO
	ADD CD_SUPLENTE_DE INT NULL,
	FE_MIEMBRO_HASTA DATE NULL
GO


ALTER TABLE GLB_MIEMBROS_PLENO  WITH CHECK 
	ADD  CONSTRAINT FK_GLB_MIEMBROS_PLENO_GLB_MIEMBROS_PLENO FOREIGN KEY(CD_SUPLENTE_DE)
REFERENCES GLB_MIEMBROS_PLENO (CD_MIEMBRO_PLENO)
GO


ALTER TABLE AGD_ENCA_AGENDA
	ADD CD_EJERCICIO VARCHAR(4) NOT NULL,
	CD_PERIODO VARCHAR(2) NOT NULL
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE AÑO EN QUE SE CREA EL REGISTRO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_ENCA_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'CD_EJERCICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'INDICADOR DE MES EN QUE SE CREA EL REGISTRO' , 
	@level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
	@level1name=N'AGD_ENCA_AGENDA', 
	@level2type=N'COLUMN',@level2name=N'CD_PERIODO'
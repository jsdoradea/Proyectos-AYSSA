USE [SCSA]
GO
/****** Object:  UserDefinedFunction [dbo].[N_Mes]    Script Date: 03/18/2015 20:09:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[N_Mes] 
(
	-- Add the parameters for the function here
	@MES int
)
RETURNS Varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @nmes varchar(3), @numMes int

	-- Add the T-SQL statements to compute the return value here
	SET @numMes = (@MES)
	
	if @numMes = 1
begin
	set @nmes = 'ENE'
end
else if @numMes = 2
begin
	set @nmes = 'FEB'
end
else if @numMes = 3
begin
	set @nmes = 'MAR'
end
else if @numMes = 4
begin
	set @nmes = 'ABR'
end
else if @numMes = 5
begin
	set @nmes = 'MAY'
end
else if @numMes = 6
begin
	set @nmes = 'JUN'
end
else if @numMes = 7
begin
	set @nmes = 'JUL'
end
else if @numMes = 8
begin
	set @nmes = 'AGO'
end
else if @numMes = 9
begin
	set @nmes = 'SEP'
end
else if @numMes = 10
begin
	set @nmes = 'OCT'
end
else if @numMes = 11
begin
	set @nmes = 'NOV'
end
else if @numMes = 12
begin
	set @nmes = 'DIC'
end

	-- Return the result of the function
	RETURN @nmes

END
GO
/****** Object:  StoredProcedure [dbo].[Iniciar_MES_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Iniciar_MES_SP] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @FECHA_HOY datetime, @ANIO int, @MES int, @NomMes varchar(3), @EXISTE INT
	
	SET @FECHA_HOY = GETDATE()
	SET @ANIO = (SELECT YEAR(@FECHA_HOY))
	SET @MES = (SELECT MONTH(@FECHA_HOY))
	SET @NomMes = (SELECT dbo.N_Mes(@MES))
	SET @EXISTE = 0
	SET @EXISTE = (SELECT COUNT(CD_CIERRE) FROM dbo.GLB_CIERRE_PERIODO WHERE CD_PERIODO = @MES and CD_EJERICIO= @ANIO and DS_PERIODO = @NomMes)
	
	IF @EXISTE = 0
	BEGIN
		INSERT INTO dbo.GLB_CIERRE_PERIODO (CD_PERIODO, CD_EJERICIO, DS_PERIODO) VALUES (@MES, @ANIO, @NomMes)
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[envio_convocatoria_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[envio_convocatoria_SP] 
	-- Add the parameters for the stored procedure here
	@USUARIO int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRY 
		--Carga de Información
		DECLARE @URL_LOGO varchar(200), @DETALLE_ENVIO varchar(max), @HTML_INI varchar(500), @HTML_FIN varchar(50), @ENCABEZADO varchar(max), @TIPO_ENVIO VARCHAR(MAX), @BODY VARCHAR(MAX)
		DECLARE @ADJUNTO varchar(500), @TITULO varchar(200), @TITULO_CORREO VARCHAR(200), @MENSAJE varchar(max), @DATOS_AGENDA varchar(max)
		
		SET @TITULO_CORREO = 'Convocatoria a Sesión ' + (SELECT DISTINCT TIPO_SESION FROM dbo.TMP_CONVOCATORIA) + ' N° ' + (SELECT DISTINCT DS_REFERENCIA FROM dbo.TMP_CONVOCATORIA)
		SET @ADJUNTO = 'C:\inetpub\wwwroot\SICSA\Content\Images\TEG_Correo.png'
		SELECT @HTML_INI='<HTML>
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						</head>
						<body>'
						
		SELECT @HTML_FIN='</body>
						  </html>'
						  
		SET @URL_LOGO = '<img src="TEG_Correo.png" style="width:125px;height:100px;" />'
		SET @TITULO = '<h1>CONVOCATORIA ' + (SELECT DISTINCT DS_REFERENCIA FROM dbo.TMP_CONVOCATORIA) + '</H1><H2>TRIBUNAL DE ETICA GUBERNAMENTAL</H2>'
		SET @ENCABEZADO = '<div id="Convocatoria" style="width:100%;text-align:center;">' + @URL_LOGO + @TITULO + '</div>'
		SET @MENSAJE = '<table style="width:100%;"><tr><td style="width:50px"><strong>Para:</strong></td><td>Señores miembros del Pleno del Tribunal de Ética Gubernamental</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td style="width:50px"><strong>De:</strong></td><td>' + (SELECT DISTINCT USUARIO FROM dbo.TMP_CONVOCATORIA) + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td style="width:50px"><strong>Asunto:</strong></td><td>' + @TITULO_CORREO + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td style="width:50px"><strong>Fecha:</strong></td><td>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),FECHA_MEMO,106), ' ','/') FROM dbo.TMP_CONVOCATORIA) + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2"><hr /></td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">Con instrucciones de la Presidencia del TEG, por este medio convoco atentamente a ustedes para celebrar Sesión ' + (SELECT DISTINCT TIPO_SESION FROM dbo.TMP_CONVOCATORIA) + ' N° ' + (SELECT DISTINCT DS_REFERENCIA FROM dbo.TMP_CONVOCATORIA) + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">&nbsp;</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td>Fecha:</td><td>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),FECHA_CONVOCATORIA,106), ' ','/') FROM dbo.TMP_CONVOCATORIA) + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td>Hora:</td><td>' + (select DISTINCT convert(varchar,HORA_CONVOCATORIA , 8) FROM dbo.TMP_CONVOCATORIA)  + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td>Lugar:</td><td>' + (select DISTINCT DS_LUGAR FROM dbo.TMP_CONVOCATORIA)  + '</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">&nbsp;</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">Adjunto agenda correspondiente.</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">&nbsp;</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">Respetuosamente,</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2">&nbsp;</td></tr>'
		SET @MENSAJE = @MENSAJE + '<tr><td colspan="2"><hr /></td></tr>'
		SET @MENSAJE = @MENSAJE + '</table>'
		
		SET @DATOS_AGENDA = '<div id="Agenda" style="width:100%;text-align:center;">'
		SET @DATOS_AGENDA = @DATOS_AGENDA + '<h1>AGENDA DE SESION </h1>'
		SET @DATOS_AGENDA = @DATOS_AGENDA + '<h2>' + (SELECT DISTINCT TIPO_SESION FROM dbo.TMP_CONVOCATORIA) + ' N° ' + (SELECT DISTINCT DS_REFERENCIA FROM dbo.TMP_CONVOCATORIA) + '</h2>'
		SET @DATOS_AGENDA = @DATOS_AGENDA + '</div>'
		SET @DATOS_AGENDA = @DATOS_AGENDA + '<table style="width:100%;">'
		
		DECLARE @NPUNTO int
		DECLARE @PUNTOS VARCHAR(500)
	
		DECLARE NPUNTO CURSOR for SELECT ORDEN FROM dbo.TMP_AGENDA
		DECLARE PUNTOS CURSOR for SELECT PUNTO FROM dbo.TMP_AGENDA
		
		OPEN NPUNTO
		OPEN PUNTOS

		FETCH NEXT FROM NPUNTO INTO @NPUNTO
		FETCH NEXT FROM PUNTOS INTO @PUNTOS
		
		WHILE @@FETCH_STATUS = 0
		BEGIN

		
			SET @DATOS_AGENDA = @DATOS_AGENDA + '<TR><TD>' + CAST(@NPUNTO as varchar(50)) + '</TD><TD>' + @PUNTOS + '</TD></TR>'
			
			FETCH NEXT FROM NPUNTO INTO @NPUNTO
			FETCH NEXT FROM PUNTOS INTO @PUNTOS
		END

		CLOSE NPUNTO
		CLOSE PUNTOS
		
		DEALLOCATE NPUNTO
		DEALLOCATE PUNTOS
		
		SET @DATOS_AGENDA = @DATOS_AGENDA + '</TABLE>'
		
		SET @BODY= @HTML_INI+ @ENCABEZADO + @MENSAJE + @DATOS_AGENDA + @HTML_FIN
		SET @TIPO_ENVIO = @TITULO_CORREO 
		
		DECLARE @EMPLEADO VARCHAR(500), @CONTEO_EMP INT, @CORREOS VARCHAR(MAX)
		SET @CONTEO_EMP=0
		SET @EMPLEADO = ''
		SET @CORREOS = ''
		
		--Obtener Correos de destinatarios
		DECLARE correos CURSOR for SELECT EMPLEADO FROM dbo.TMP_CONVOCATORIA
		OPEN correos
		fetch next from correos into @EMPLEADO
		while @@FETCH_STATUS = 0
		begin
			SET @CONTEO_EMP = (SELECT COUNT(DS_CORREO) FROM dbo.GLB_EMPLEADOS WHERE (DS_NOMBRE_EMPLEADO + ' ' + DS_APELLIDO_EMPLEADO) = @EMPLEADO )
			IF @CONTEO_EMP >0
			BEGIN
				SET @CORREOS = @CORREOS + (SELECT TOP 1 DS_CORREO FROM dbo.GLB_EMPLEADOS WHERE (DS_NOMBRE_EMPLEADO + ' ' + DS_APELLIDO_EMPLEADO) = @EMPLEADO ) + '; '
			END
			fetch next from correos into @EMPLEADO
		end
		close correos
		deallocate correos
		
		--Adjuntar copia de correo a Usuario que envía el correo
		SET @CORREOS = @CORREOS + (SELECT a.DS_CORREO FROM dbo.GLB_EMPLEADOS a 	INNER JOIN dbo.CONF_USUARIO b ON b.CD_EMPLEADO = a.CD_EMPLEADO WHERE b.id_usuario = @USUARIO)
		
		DECLARE @mailid NUMERIC(20,0)
		
		
		if (@CORREOS is not null) and (ISNULL(@BODY,'')<>'')	
		begin  		
			EXECUTE [msdb].[dbo].[sp_send_dbmail]  		
			@profile_name = 'TEG-SICSA'  		
			,@recipients  = @CORREOS  		
			,@body        = @BODY  	
			,@BODY_FORMAT ='HTML'	
			,@subject     = @TIPO_ENVIO 
			,@file_attachments = @ADJUNTO	
			,@mailitem_id = @mailid OUTPUT  		
		end 

	END TRY 

	BEGIN CATCH  		
		DECLARE  		
		@ErrorNumber    int           ,  		
		@ErrorSeverity  int           ,  		
		@ErrorState     int           ,  		
		@ErrorProcedure nvarchar(126) ,  		
		@ErrorLine      int              		

		SELECT @ErrorNumber=ERROR_NUMBER(),  		
		@ErrorSeverity=ERROR_SEVERITY(),  		
		@ErrorState=ERROR_STATE(),  		
		@ErrorProcedure=ERROR_PROCEDURE(),  		
		@ErrorLine=ERROR_LINE()  		
	END CATCH;  	
END
GO
/****** Object:  StoredProcedure [dbo].[Actualizar_Estados_Acuerdos_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Actualizar_Estados_Acuerdos_SP] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @FE_INI_ACU datetime
	DECLARE @Periodo int
	DECLARE @Fecha_hoy datetime
	DECLARE @Fecha_Fin datetime
	DECLARE @CD_ACUERDO int
	DECLARE @DIAS_TOTALES int
	DECLARE @DIAS_TRANSCURRIDOS int
	DECLARE @AVANCE float
	
	SET @Fecha_hoy = GETDATE()
	
	
	DECLARE Acuerdos CURSOR for select CD_ENCA_ACUERDOS from dbo.ACU_ENCA_ACUERDOS
	OPEN Acuerdos
	fetch next from Acuerdos into @CD_ACUERDO
	while @@FETCH_STATUS = 0
	begin
		SET @FE_INI_ACU = (SELECT FE_FECHA_INI FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS = @CD_ACUERDO)
		SET @Periodo = (SELECT PERIODO_DIAS FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS = @CD_ACUERDO)
		SET @Fecha_Fin = (SELECT DATEADD(DAY, @Periodo, @FE_INI_ACU))
		SET @DIAS_TOTALES = (SELECT DATEDIFF(day, @FE_INI_ACU, @Fecha_Fin))
		SET @DIAS_TRANSCURRIDOS = (SELECT DATEDIFF(day, @FE_INI_ACU, @Fecha_hoy))
		SET @AVANCE = (@DIAS_TRANSCURRIDOS/(CASE WHEN @DIAS_TOTALES=0 THEN 1 ELSE @DIAS_TOTALES END))*100
		IF @AVANCE < 80
		BEGIN
			--Verde
			UPDATE dbo.ACU_ENCA_ACUERDOS SET CD_COD_ALERTA = 1 WHERE CD_ENCA_ACUERDOS = @CD_ACUERDO
		END
		ELSE
		BEGIN
			IF  @AVANCE >= 80 and @AVANCE < 100 
			BEGIN
				--Amarillo
				UPDATE dbo.ACU_ENCA_ACUERDOS SET CD_COD_ALERTA = 2 WHERE CD_ENCA_ACUERDOS = @CD_ACUERDO
			END
			ELSE
			BEGIN
				--Rojo
				UPDATE dbo.ACU_ENCA_ACUERDOS SET CD_COD_ALERTA = 3 WHERE CD_ENCA_ACUERDOS = @CD_ACUERDO
			END
		END
		fetch next from Acuerdos into @CD_ACUERDO
	end
	close Acuerdos
	deallocate Acuerdos
END
GO
/****** Object:  StoredProcedure [dbo].[envio_acuerdo_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[envio_acuerdo_SP] 
	-- Add the parameters for the stored procedure here
	@USUARIO int, 
	@CD_ENCA_ACU int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRY 
		--Carga de Información
		DECLARE @URL_LOGO varchar(200), @DETALLE_ENVIO varchar(max), @HTML_INI varchar(500), @HTML_FIN varchar(50), @ENCABEZADO varchar(max), @TIPO_ENVIO VARCHAR(MAX), @BODY VARCHAR(MAX)
		DECLARE @ADJUNTO varchar(500), @TITULO varchar(max), @TITULO_CORREO VARCHAR(200), @MENSAJE varchar(max), @DATOS_AGENDA varchar(max)
		DECLARE @N_ACUERDO varchar(50), @N_PUNTO varchar(50), @NOM_PUNTO varchar(500), @HORA_SESION varchar(200), @FECHA_SESION varchar(200), @TEXTO_ACUERDO varchar(max)
		DECLARE @VOTANTES varchar(max), @FECHA_HOY varchar(500), @NOM_EMPLEADO varchar(500), @CARGO_EMP varchar(500)
		
		SET @N_ACUERDO = (SELECT TOP 1 N_ACUERDO FROM dbo.TMP_ACUERDOS)
		SET @TITULO_CORREO = 'Notificación de Acuerdos: ' + @N_ACUERDO + ' de la Sesión ' + (SELECT DISTINCT DS_REFERENCIA FROM dbo.TMP_ACUERDOS)
		SET @ADJUNTO = 'C:\inetpub\wwwroot\SICSA\Content\Images\TEG_Correo.png'
		SELECT @HTML_INI='<HTML>
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						</head>
						<body>'
						
		SELECT @HTML_FIN='</body>
						  </html>'
						  
		
		
		SET @N_PUNTO = (SELECT TOP 1 N_PUNTO_AGD FROM dbo.TMP_ACUERDOS)
		SET @NOM_PUNTO = (SELECT TOP 1 DS_PUNTO_AGENDA FROM dbo.TMP_ACUERDOS) + ' ' + (SELECT TOP 1 DS_REFERENCIA FROM dbo.TMP_ACUERDOS)
		SET @HORA_SESION = (SELECT TOP 1 HORA FROM dbo.TMP_ACUERDOS)
		SET @FECHA_SESION = (SELECT TOP 1 FECHA FROM dbo.TMP_ACUERDOS)
		SET @TEXTO_ACUERDO = (SELECT TOP 1 DS_ACUERDO_CORTO FROM dbo.TMP_ACUERDOS)
		SET @FECHA_HOY = (SELECT TOP 1 FECHA_HOY FROM dbo.TMP_ACUERDOS)
		SET @VOTANTES = (SELECT TOP 1 VOTANTES FROM dbo.TMP_ACUERDOS)
		SET @NOM_EMPLEADO = (SELECT TOP 1 EMPLEADO FROM dbo.TMP_ACUERDOS)
		SET @CARGO_EMP = (SELECT TOP 1 CARGO FROM dbo.TMP_ACUERDOS)
		
		SET @URL_LOGO = '<img src="TEG_Correo.png" style="width:125px;height:100px;" />'
		SET @TITULO = '<strong>Acuerdo ' + @N_ACUERDO + '. El Tribunal de Ética Gubernamental en punto ' + @N_PUNTO + '. ' + @NOM_PUNTO + ', celebrada a las ' + @HORA_SESION + ' del día ' + @FECHA_SESION + ', acordó:</strong>'
		SET @ENCABEZADO = '<div id="Acuerdos" style="width:100%;text-align:center;">' + @URL_LOGO + '<br />' + @TITULO + '</div>'
		SET @MENSAJE = '<div id="Acuerdos" style="width:100%;">'
		
		SET @MENSAJE = @MENSAJE + '<p>' + @TEXTO_ACUERDO + '</p></div>'
		
		SET @MENSAJE = @MENSAJE + '<div id="Votantes" style="width:100%">'
		SET @MENSAJE = @MENSAJE + '<p>Pronunciado por ' + @VOTANTES + '. Miembros del Pleno de Ética Gubernamental. San Salvador, ' + @FECHA_HOY + '.</p>'
		SET @MENSAJE = @MENSAJE + '</div>'
		
		SET @MENSAJE = @MENSAJE + '<div id="Responsable" style="width:100%; text-align:center;">'
		SET @MENSAJE = @MENSAJE + @NOM_EMPLEADO + '<br />'
		SET @MENSAJE = @MENSAJE + @CARGO_EMP
		SET @MENSAJE = @MENSAJE + '</div>'
		
		SET @BODY= @HTML_INI+ @ENCABEZADO + @MENSAJE + @HTML_FIN
		SET @TIPO_ENVIO = @TITULO_CORREO 
		
		DECLARE @EMPLEADO VARCHAR(500), @CONTEO_EMP INT, @CORREOS VARCHAR(MAX)
		SET @CONTEO_EMP=0
		SET @EMPLEADO = ''
		SET @CORREOS = ''
		
		--Obtener Correos de destinatarios (Responsable y Emisor)
		DECLARE @EMISOR varchar(500), @CD_RESPONSABLE int,  @RESPONSABLE varchar(500)
		SET @EMISOR = (SELECT DS_CORREO FROM dbo.GLB_EMPLEADOS a INNER JOIN  dbo.CONF_USUARIO b on b.CD_EMPLEADO = a.CD_EMPLEADO WHERE b.id_usuario=@USUARIO)
		SET @CD_RESPONSABLE = (SELECT CD_RESPONSABLE FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS = @CD_ENCA_ACU)
		SET @RESPONSABLE = (SELECT DS_CORREO FROM dbo.GLB_EMPLEADOS WHERE CD_EMPLEADO = @CD_RESPONSABLE)
		
		
		--Adjuntar copia de correo a Usuario que envía el correo
		SET @CORREOS = @RESPONSABLE + ';' + @EMISOR
		
		DECLARE @mailid NUMERIC(20,0)
		
		
		if (@CORREOS is not null) and (ISNULL(@BODY,'')<>'')	
		begin  		
			EXECUTE [msdb].[dbo].[sp_send_dbmail]  		
			@profile_name = 'TEG-SICSA'  		
			,@recipients  = @CORREOS  		
			,@body        = @BODY  	
			,@BODY_FORMAT ='HTML'	
			,@subject     = @TIPO_ENVIO 
			,@file_attachments = @ADJUNTO	
			,@mailitem_id = @mailid OUTPUT  		
		end 

	END TRY 

	BEGIN CATCH  		
		DECLARE  		
		@ErrorNumber    int           ,  		
		@ErrorSeverity  int           ,  		
		@ErrorState     int           ,  		
		@ErrorProcedure nvarchar(126) ,  		
		@ErrorLine      int              		

		SELECT @ErrorNumber=ERROR_NUMBER(),  		
		@ErrorSeverity=ERROR_SEVERITY(),  		
		@ErrorState=ERROR_STATE(),  		
		@ErrorProcedure=ERROR_PROCEDURE(),  		
		@ErrorLine=ERROR_LINE()  		
	END CATCH;  	
END
GO
/****** Object:  StoredProcedure [dbo].[envio_tareas_plan_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[envio_tareas_plan_SP] 
	-- Add the parameters for the stored procedure here
	@USUARIO int,
	@CD_ACU_ENCA int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRY 
		--Carga de Información
		DECLARE @URL_LOGO varchar(200), @DETALLE_ENVIO varchar(max), @HTML_INI varchar(500), @HTML_FIN varchar(50), @ENCABEZADO varchar(max), @TIPO_ENVIO VARCHAR(MAX), @BODY VARCHAR(MAX)
		DECLARE @ADJUNTO varchar(500), @TITULO varchar(200), @TITULO_CORREO VARCHAR(200), @MENSAJE varchar(max), @DATOS_AGENDA varchar(max)
		
		SET @TITULO_CORREO = 'Notificación de asignación de tarea'
		SET @ADJUNTO = 'C:\inetpub\wwwroot\SICSA\Content\Images\TEG_Correo.png'
		SELECT @HTML_INI='<HTML>
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						</head>
						<body>'
						
		SELECT @HTML_FIN='</body>
						  </html>'
						  
		SET @URL_LOGO = '<img src="TEG_Correo.png" style="width:125px;height:100px;" />'
		SET @TITULO = 'Asignación de tarea en plan de trabajo' 
		SET @ENCABEZADO = '<div id="Encabezado" style="width:100%;text-align:center;">' + @URL_LOGO + '<BR />' + @TITULO + '</div><br />Detalle de Actividades:<br /><br />'
		
		
		DECLARE @CD_TAREA int, @NM_TAREA INT, @DS_TAREA VARCHAR(500), @N_ACUERDO VARCHAR(50), @NOM_ACUERDO VARCHAR(MAX), @CD_RESPONSABLE INT, @RESPONSABLE VARCHAR(500), @FECHA_INI DATETIME, @FECHA_FIN DATETIME, @DIAS_EJEC INT, @DS_CORREO VARCHAR(500)
	
		DECLARE @EMPLEADO VARCHAR(500), @CONTEO_EMP INT, @CORREOS VARCHAR(MAX)
			
		DECLARE TAREAS_C CURSOR for SELECT a.CD_TAREA FROM dbo.ACU_TAREAS_ACUERDOS a 	WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA ORDER BY a.NM_TAREA DESC
		OPEN TAREAS_C
		FETCH NEXT FROM TAREAS_C INTO @CD_TAREA
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NM_TAREA = (SELECT a.NM_TAREA 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @DS_TAREA = (SELECT a.DS_TAREA 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @N_ACUERDO = (SELECT CAST(b.NM_CORR_ACUERDO as varchar(50)) + '-TEG-' + CAST(b.DS_ANIO_ACUERDO as varchar(4)) as N_ACUERDO 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @NOM_ACUERDO = (SELECT b.DS_ACUERDO_COMP 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @CD_RESPONSABLE = (SELECT a.CD_RESPONSABLE 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @RESPONSABLE = (SELECT c.DS_NOMBRE_EMPLEADO + ' ' + c.DS_APELLIDO_EMPLEADO AS RESPONSABLE 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @FECHA_INI = (SELECT a.FE_FECHA_INI 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @FECHA_FIN = (SELECT a.FECHA_FIN 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @DIAS_EJEC = (SELECT a.DIAS_EJECUCION 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
			SET @DS_CORREO = (SELECT c.DS_CORREO 	FROM dbo.ACU_TAREAS_ACUERDOS a INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE INNER JOIN dbo.GLB_SEMAFORO d ON d.id_semaforo = a.ESTADO_TAREA WHERE a.CD_ENCA_ACUERDOS = @CD_ACU_ENCA AND a.CD_TAREA = @CD_TAREA)
		
			SET @MENSAJE = '<TABLE><TR><TD>N° Tarea: </TD><TD>' + CAST(@NM_TAREA AS VARCHAR(50)) + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>Tarea: </TD><TD>' + @DS_TAREA + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>N° Acuerdo: </TD><TD>' + @N_ACUERDO + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>Acuerdo: </TD><TD>' + @NOM_ACUERDO + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>Responsable: </TD><TD>' + @RESPONSABLE + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>Fecha de Inicio: </TD><TD>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),@FECHA_INI,106), ' ','/')) + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>Fecha Fin: </TD><TD>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),@FECHA_FIN,106), ' ','/')) + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '<TR><TD>Dias de Ejecución: </TD><TD>' + CAST(@DIAS_EJEC AS VARCHAR(50)) + '</TD></TR>'
			SET @MENSAJE = @MENSAJE + '</TABLE>' 
			
			SET @BODY= @HTML_INI+ @ENCABEZADO + @MENSAJE  + @HTML_FIN
			SET @TIPO_ENVIO = @TITULO_CORREO 
			
			SET @CORREOS = (SELECT a.DS_CORREO FROM dbo.GLB_EMPLEADOS a 	INNER JOIN dbo.CONF_USUARIO b ON b.CD_EMPLEADO = a.CD_EMPLEADO WHERE b.id_usuario = @USUARIO)
			SET @CORREOS = @CORREOS + ';' + @DS_CORREO

			--SELECT @CORREOS, @BODY
			
			DECLARE @mailid NUMERIC(20,0)
			
			
			if (@CORREOS is not null) and (ISNULL(@BODY,'')<>'')	
			begin  		
				EXECUTE [msdb].[dbo].[sp_send_dbmail]  		
				@profile_name = 'TEG-SICSA'  		
				,@recipients  = @CORREOS  		
				,@body        = @BODY  	
				,@BODY_FORMAT ='HTML'	
				,@subject     = @TIPO_ENVIO 
				,@file_attachments = @ADJUNTO	
				,@mailitem_id = @mailid OUTPUT  		
			end 

			
			FETCH NEXT FROM TAREAS_C INTO @CD_TAREA
		END

		CLOSE TAREAS_C
		DEALLOCATE TAREAS_C
		
	END TRY 

	BEGIN CATCH  		
		DECLARE  		
		@ErrorNumber    int           ,  		
		@ErrorSeverity  int           ,  		
		@ErrorState     int           ,  		
		@ErrorProcedure nvarchar(126) ,  		
		@ErrorLine      int              		

		SELECT @ErrorNumber=ERROR_NUMBER(),  		
		@ErrorSeverity=ERROR_SEVERITY(),  		
		@ErrorState=ERROR_STATE(),  		
		@ErrorProcedure=ERROR_PROCEDURE(),  		
		@ErrorLine=ERROR_LINE()  		
	END CATCH;  	
END
GO
/****** Object:  StoredProcedure [dbo].[Notificar_Alertas_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Notificar_Alertas_SP] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRY 
		--Carga de Información
		DECLARE @URL_LOGO varchar(200), @DETALLE_ENVIO varchar(max), @HTML_INI varchar(500), @HTML_FIN varchar(50), @ENCABEZADO varchar(max), @TIPO_ENVIO VARCHAR(MAX), @BODY VARCHAR(MAX)
		DECLARE @ADJUNTO varchar(500), @TITULO varchar(200), @TITULO_CORREO VARCHAR(200), @MENSAJE varchar(max), @DATOS_AGENDA varchar(max)
		
		EXEC Actualizar_Estados_Acuerdos_SP
		
		SET @TITULO_CORREO = 'Notificación de Códigos de Alerta de Acuerdos TEG'
		SET @ADJUNTO = 'C:\inetpub\wwwroot\SICSA\Content\Images\TEG_Correo.png'
		SELECT @HTML_INI='<HTML>
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						</head>
						<body>'
						
		SELECT @HTML_FIN='</body>
						  </html>'
						  
		SET @URL_LOGO = '<img src="TEG_Correo.png" style="width:125px;height:100px;" />'
		SET @TITULO = '<h1>Estados de Alerta para Acuerdos</H1>'
		SET @ENCABEZADO = '<div id="Encabezado" style="width:100%;text-align:center;">' + @URL_LOGO + '<br />' + @TITULO + '</div>'
		SET @MENSAJE = '<table border="1" style="width:100%;"><tr><td><strong>Correlativo</strong></td><td><strong>Año</strong></td><td><strong>Acuerdo</strong></td><td><strong>Tipo de Acuerdo</strong></td><td><strong>Fecha Inicio</strong></td><td><strong>Fecha Fin</strong></td><td><strong>Días de Ejecución</strong></td><td><strong>Responsable</strong></td><td><strong>Alerta</strong></td></tr>'
		
		
		DECLARE @CD_ENCA_ACU int, @NM_ACUERDO int, @ANIO_ACU int, @ACUERDO varchar(500), @TIPO_ACU varchar(max), @FECHA_INI datetime, @FECHA_FIN datetime, @DIAS int, @CD_RESPONSABLE int, @RESPONSABLE varchar(500), @COD_ALERTA int, @ALERTA varchar(50)
	
		DECLARE ACUERDOS CURSOR for SELECT a.CD_ENCA_ACUERDOS FROM dbo.ACU_ENCA_ACUERDOS a WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA
		
		OPEN ACUERDOS

		FETCH NEXT FROM ACUERDOS INTO @CD_ENCA_ACU
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NM_ACUERDO = (SELECT TOP 1 a.NM_CORR_ACUERDO FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @ANIO_ACU = (SELECT TOP 1 a.DS_ANIO_ACUERDO FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @ACUERDO = (SELECT TOP 1 a.DS_ACUERDO_COMP FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @TIPO_ACU = (SELECT TOP 1  b.DS_TIPO_ACUERDO FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @FECHA_INI = (SELECT TOP 1 a.FE_FECHA_INI FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @FECHA_FIN = (SELECT TOP 1 a.FECHA_FIN FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @DIAS = (SELECT TOP 1 a.PERIODO_DIAS FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @RESPONSABLE = (SELECT TOP 1 c.DS_NOMBRE_EMPLEADO + ' ' + c.DS_APELLIDO_EMPLEADO as RESPONSABLE FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			SET @COD_ALERTA = (SELECT TOP 1 a.CD_COD_ALERTA FROM dbo.ACU_ENCA_ACUERDOS a  INNER JOIN  dbo.ACU_TIPO_ACUERDO b ON b.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO 	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_RESPONSABLE WHERE a.ESTADO_PLAN IS NULL  and a.RESULTADO_VOTACION = 1 and CD_ENCA_ACUERDOS = @CD_ENCA_ACU ORDER BY a.CD_COD_ALERTA desc, a.FECH_CREA)
			
			IF @COD_ALERTA = 3
			BEGIN
				SET @MENSAJE = @MENSAJE + '<TR><TD>' + CAST(@NM_ACUERDO as varchar(50)) + '</TD><TD>' + CAST(@ANIO_ACU as varchar(50)) + '</TD><TD>' + @ACUERDO + '</TD><TD>' + @TIPO_ACU + '</TD><TD>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),@FECHA_INI,106), ' ','/')) + '</TD><TD>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),@FECHA_FIN,106), ' ','/')) + '</TD><TD>' + CAST(@DIAS as varchar(50)) + '</TD><TD>' + @RESPONSABLE + '</TD><TD>ROJO</TD></TR>'
			END
			ELSE
			BEGIN
				IF @COD_ALERTA = 2
				BEGIN
					SET @MENSAJE = @MENSAJE + '<TR><TD>' + CAST(@NM_ACUERDO as varchar(50)) + '</TD><TD>' + CAST(@ANIO_ACU as varchar(50)) + '</TD><TD>' + @ACUERDO + '</TD><TD>' + @TIPO_ACU + '</TD><TD>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),@FECHA_INI,106), ' ','/')) + '</TD><TD>' + (SELECT DISTINCT  REPLACE(CONVERT(VARCHAR(11),@FECHA_FIN,106), ' ','/')) + '</TD><TD>' + CAST(@DIAS as varchar(50)) + '</TD><TD>' + @RESPONSABLE + '</TD><TD>AMARILLO</TD></TR>'
				END	
			END
			
			--SELECT @COD_ALERTA, @MENSAJE
			
			FETCH NEXT FROM ACUERDOS INTO @CD_ENCA_ACU
		END

		CLOSE ACUERDOS
		
		DEALLOCATE ACUERDOS
		
		SET @MENSAJE = @MENSAJE + '</TABLE>'
				
		SET @BODY= @HTML_INI+ @ENCABEZADO + @MENSAJE + @HTML_FIN
		SET @TIPO_ENVIO = @TITULO_CORREO 
		
		DECLARE @DS_CORREO VARCHAR(500), @CONTEO_EMP INT, @CORREOS VARCHAR(MAX)
		SET @CONTEO_EMP=0
		SET @DS_CORREO = ''
		SET @CORREOS = ''
		
		--Obtener Correos de destinatarios
		DECLARE correos CURSOR for SELECT DS_CORREO FROM dbo.GLB_EMPLEADOS WHERE CD_CARGO_INST = 30
		OPEN correos
		fetch next from correos into @DS_CORREO
		while @@FETCH_STATUS = 0
		begin
			SET @CONTEO_EMP = (SELECT COUNT(DS_CORREO) FROM dbo.GLB_EMPLEADOS WHERE (DS_CORREO = @DS_CORREO ))
			IF @CONTEO_EMP >0
			BEGIN
				SET @CORREOS = @CORREOS + (SELECT TOP 1 DS_CORREO FROM dbo.GLB_EMPLEADOS WHERE DS_CORREO = @DS_CORREO ) + '; '
			END
			fetch next from correos into @DS_CORREO
		end
		close correos
		deallocate correos
		
		--Adjuntar copia de correo a Usuario que envía el correo
		--SELECT @CORREOS, @BODY, @TIPO_ENVIO
		
		DECLARE @mailid NUMERIC(20,0)
		
		
		if (@CORREOS is not null) and (ISNULL(@BODY,'')<>'')	
		begin  		
			EXECUTE [msdb].[dbo].[sp_send_dbmail]  		
			@profile_name = 'TEG-SICSA'  		
			,@recipients  = @CORREOS  		
			,@body        = @BODY  	
			,@BODY_FORMAT ='HTML'	
			,@subject     = @TIPO_ENVIO 
			,@file_attachments = @ADJUNTO	
			,@mailitem_id = @mailid OUTPUT  		
		end 

	END TRY 

	BEGIN CATCH  		
		DECLARE  		
		@ErrorNumber    int           ,  		
		@ErrorSeverity  int           ,  		
		@ErrorState     int           ,  		
		@ErrorProcedure nvarchar(126) ,  		
		@ErrorLine      int              		

		SELECT @ErrorNumber=ERROR_NUMBER(),  		
		@ErrorSeverity=ERROR_SEVERITY(),  		
		@ErrorState=ERROR_STATE(),  		
		@ErrorProcedure=ERROR_PROCEDURE(),  		
		@ErrorLine=ERROR_LINE()  		
	END CATCH;  	
END
GO
/****** Object:  StoredProcedure [dbo].[envio_avance_tarea_SP]    Script Date: 03/18/2015 20:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[envio_avance_tarea_SP] 
	-- Add the parameters for the stored procedure here
	@USUARIO int, 
	@CD_TAREA int,
	@ESTADO_TAREA int,
	@JUSTIFICACION varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRY 
		--Carga de Información
		DECLARE @URL_LOGO varchar(200), @DETALLE_ENVIO varchar(max), @HTML_INI varchar(500), @HTML_FIN varchar(50), @ENCABEZADO varchar(max), @TIPO_ENVIO VARCHAR(MAX), @BODY VARCHAR(MAX)
		DECLARE @ADJUNTO varchar(500), @TITULO varchar(max), @TITULO_CORREO VARCHAR(200), @MENSAJE varchar(max), @DATOS_AGENDA varchar(max)
		DECLARE @DS_TAREA varchar(max), @CD_ENCA_ACU int, @FECHA_INI_TAREA datetime, @FECHA_FIN_TAREA datetime, @CD_RESPONSABLE_TAREA int, @CD_RESPONSABLE_PLAN int, @NOM_ACU varchar(50), @EST_TAREA varchar(50)
		
		SET @DS_TAREA = (SELECT DS_TAREA FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA= @CD_TAREA)
		
		SET @TITULO_CORREO = 'Notificación de Estado de Tarea: ' + @DS_TAREA
		SET @ADJUNTO = 'C:\inetpub\wwwroot\SICSA\Content\Images\TEG_Correo.png'
		SELECT @HTML_INI='<HTML>
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						</head>
						<body>'
						
		SELECT @HTML_FIN='</body>
						  </html>'
						  
		
		
		SET @CD_ENCA_ACU = (SELECT CD_ENCA_ACUERDOS FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA= @CD_TAREA)
		SET @FECHA_INI_TAREA = (SELECT FE_FECHA_INI FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA= @CD_TAREA)
		SET @FECHA_FIN_TAREA = (SELECT FECHA_FIN FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA= @CD_TAREA)
		SET @CD_RESPONSABLE_TAREA = (SELECT CD_RESPONSABLE FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA= @CD_TAREA)
		SET @CD_RESPONSABLE_PLAN = (SELECT CD_RESPONSABLE FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS= @CD_ENCA_ACU)
		SET @NOM_ACU = (SELECT CAST(NM_CORR_ACUERDO as varchar(10)) + '-TEG-' + CAST(DS_ANIO_ACUERDO as varchar(4))  as ACUERDO  FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS= @CD_ENCA_ACU)
		IF @ESTADO_TAREA = 1
		BEGIN
			SET @EST_TAREA = 'Pendiente'
		END
		ELSE
		BEGIN
			SET @EST_TAREA = 'Terminada'
		END
		
		
		SET @URL_LOGO = '<img src="TEG_Correo.png" style="width:125px;height:100px;" />'
		SET @TITULO = '<strong>Notifico estado de la Tarea:' + @DS_TAREA + ' que forma parte del acuerdo: ' + @NOM_ACU + '</strong>'
		SET @TITULO = @TITULO + '<br /> Con Fecha de Inicio: ' + (SELECT REPLACE(CONVERT(VARCHAR(11),@FECHA_INI_TAREA,106), ' ','/')) + '<br /> y Fecha de Finalización: ' + (SELECT REPLACE(CONVERT(VARCHAR(11),@FECHA_FIN_TAREA,106), ' ','/'))
		SET @ENCABEZADO = '<div id="Acuerdos" style="width:100%;text-align:center;">' + @URL_LOGO + '<br />' + @TITULO + '</div>'
		SET @MENSAJE = '<div id="Expliacion" style="width:100%;">'
		
		SET @MENSAJE = @MENSAJE + '<p>Esta tarea se encuentra en estado ' + @EST_TAREA + '</p>'
		SET @MENSAJE = @MENSAJE + '<p>Comentario:</p>'
		SET @MENSAJE = @MENSAJE + '<p>' + @JUSTIFICACION + '</p></div>'
	
		SET @MENSAJE = @MENSAJE + '<div id="Despedida" style="width:100%;">'
		SET @MENSAJE = @MENSAJE + 'Att.' + '<br />'
		
		DECLARE @CD_EMP_NOTIF int, @CD_CARGO int, @DS_CARGO varchar(500), @NOM_EMP varchar(500)
		SET @CD_EMP_NOTIF = (SELECT CD_EMPLEADO FROM CONF_USUARIO WHERE id_usuario= @USUARIO)
		SET @CD_CARGO = (SELECT CD_CARGO_INST FROM dbo.GLB_EMPLEADOS WHERE CD_EMPLEADO = @CD_EMP_NOTIF)
		SET @DS_CARGO = (SELECT DS_CARGO_INST FROM dbo.GLB_CARGOS_INSTITUCIONALES WHERE CD_CARGO_INST = @CD_CARGO)
		SET @NOM_EMP = (SELECT DS_NOMBRE_EMPLEADO + ' ' + DS_APELLIDO_EMPLEADO FROM dbo.GLB_EMPLEADOS WHERE CD_EMPLEADO = @CD_EMP_NOTIF)
		
		SET @MENSAJE = @MENSAJE + '<strong>' + @NOM_EMP + '<br />' + @DS_CARGO + '</strong>'
		SET @MENSAJE = @MENSAJE + '</div>'
		
		SET @BODY= @HTML_INI+ @ENCABEZADO + @MENSAJE + @HTML_FIN
		SET @TIPO_ENVIO = @TITULO_CORREO 
		
		DECLARE @EMPLEADO VARCHAR(500), @CONTEO_EMP INT, @CORREOS VARCHAR(MAX)
		SET @CONTEO_EMP=0
		SET @EMPLEADO = ''
		SET @CORREOS = ''
		
		--Obtener Correos de destinatarios (Responsable y Emisor)
		DECLARE @EMISOR varchar(500), @CD_RESPONSABLE int,  @RESPONSABLE varchar(500)
		SET @EMISOR = (SELECT DS_CORREO FROM dbo.GLB_EMPLEADOS a INNER JOIN  dbo.CONF_USUARIO b on b.CD_EMPLEADO = a.CD_EMPLEADO WHERE b.id_usuario=@USUARIO)
		SET @CD_RESPONSABLE = (SELECT CD_RESPONSABLE FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS = @CD_ENCA_ACU)
		SET @RESPONSABLE = (SELECT DS_CORREO FROM dbo.GLB_EMPLEADOS WHERE CD_EMPLEADO = @CD_RESPONSABLE_PLAN)
		
		
		--Adjuntar copia de correo a Usuario que envía el correo
		SET @CORREOS = @RESPONSABLE + ';' + @EMISOR
		
		DECLARE @mailid NUMERIC(20,0)
		
		--SELECT @BODY, @CORREOS
		if (@CORREOS is not null) and (ISNULL(@BODY,'')<>'')	
		begin  		
			EXECUTE [msdb].[dbo].[sp_send_dbmail]  		
			@profile_name = 'TEG-SICSA'  		
			,@recipients  = @CORREOS  		
			,@body        = @BODY  	
			,@BODY_FORMAT ='HTML'	
			,@subject     = @TIPO_ENVIO 
			,@file_attachments = @ADJUNTO	
			,@mailitem_id = @mailid OUTPUT  		
		end 

	END TRY 

	BEGIN CATCH  		
		DECLARE  		
		@ErrorNumber    int           ,  		
		@ErrorSeverity  int           ,  		
		@ErrorState     int           ,  		
		@ErrorProcedure nvarchar(126) ,  		
		@ErrorLine      int              		

		SELECT @ErrorNumber=ERROR_NUMBER(),  		
		@ErrorSeverity=ERROR_SEVERITY(),  		
		@ErrorState=ERROR_STATE(),  		
		@ErrorProcedure=ERROR_PROCEDURE(),  		
		@ErrorLine=ERROR_LINE()  		
	END CATCH;  	
END
GO

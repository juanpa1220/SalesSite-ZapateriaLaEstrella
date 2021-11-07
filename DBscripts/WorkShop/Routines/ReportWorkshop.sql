-- USE [Workshop]
-- GO

/****** Object:  StoredProcedure [dbo].[Report]    Script Date: 11/08/2020 15:11:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report]
 @subsidiary SMALLINT = NULL,
 @idEmployee INT = NULL,
 @product BIGINT = NULL,
 @start_date DATE = NULL,
 @end_date DATE = NULL
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @result TABLE(#subsidiary SMALLINT, subsidiary VARCHAR(50), #employee INT, employee VARCHAR(100),
			#product BIGINT, product VARCHAR(50), quantity INT, amount MONEY)

		IF (@subsidiary IS NULL OR @subsidiary = 1)
            INSERT INTO @result EXEC Subsidiary_Cartago.dbo.Report @idEmployee, @product, @start_date, @end_date
		IF (@subsidiary IS NULL OR @subsidiary = 2)
            INSERT INTO @result EXEC Subsidiary_SanJose.dbo.Report @idEmployee, @product, @start_date, @end_date
		IF (@subsidiary IS NULL OR @subsidiary = 3)
            INSERT INTO @result EXEC Subsidiary_Alajuela.dbo.Report @idEmployee, @product, @start_date, @end_date

		SELECT ISNULL(#subsidiary, 0) AS #Sucursal, ISNULL(subsidiary, 'Todas') AS Sucursal,
		ISNULL(#employee, 0) AS #Empleado, ISNULL(employee, 'Todos') AS Empleado,
		ISNULL(#product, 0) AS #Producto, ISNULL(product, 'Todos') AS Producto,
		SUM(quantity) AS Cantidad, SUM(amount) AS Total
		FROM @result
		GROUP BY ROLLUP((#subsidiary, subsidiary), (#employee, employee), (#product, product))

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END
GO

EXEC Report;

--***********************************************************************************************--

USE [Workshop]
GO

/****** Object:  StoredProcedure [dbo].[GainReport]    Script Date: 11/08/2020 15:11:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GainReport]
 @subsidiary SMALLINT = NULL,
 @product BIGINT = NULL,
 @start_date DATE = NULL,
 @end_date DATE = NULL
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @result TABLE(#subsidiary SMALLINT, subsidiary VARCHAR(50),
			#product BIGINT, product VARCHAR(50), quantity INT, amount MONEY)

		IF (@subsidiary IS NULL OR @subsidiary = 1)
            INSERT INTO @result EXEC Subsidiary_Cartago.dbo.GainReport @product, @start_date, @end_date
		IF (@subsidiary IS NULL OR @subsidiary = 2)
            INSERT INTO @result EXEC Subsidiary_SanJose.dbo.GainReport @product, @start_date, @end_date
		IF (@subsidiary IS NULL OR @subsidiary = 3)
            INSERT INTO @result EXEC Subsidiary_Alajuela.dbo.GainReport @product, @start_date, @end_date

		SELECT ISNULL(#subsidiary, 0) AS #Sucursal, ISNULL(subsidiary, 'Todas') AS Sucursal,
		ISNULL(#product, 0) AS #Producto, ISNULL(product, 'Todos') AS Producto,
		SUM(quantity) AS Cantidad, SUM(amount) AS Total
		FROM @result
		GROUP BY ROLLUP((#subsidiary, subsidiary), (#product, product))

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END
GO




EXEC GainReport @subsidiary = null, @product = null, @start_date = '2020-8-1', @end_date = '2020-8-27';
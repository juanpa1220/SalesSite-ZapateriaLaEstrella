USE [Workshop]
GO

/****** Object:  StoredProcedure [dbo].[GetEmployeeSalary]    Script Date: 14/08/2020 21:51:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetEmployeeSalary]
 @employee int = null,
 @subsidiary smallint = null,
 @start date = null,
 @end date = null
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @result TABLE(idSubsidiary int, subsidiary varchar(100),
			idEmployee int, employee varchar(100), commission int)

		IF (@subsidiary IS NULL OR @subsidiary = 3)
			INSERT INTO @result EXEC Subsidiary_Alajuela.dbo.GetCommission @employee, @start, @end
		IF (@subsidiary IS NULL OR @subsidiary = 1)
			INSERT INTO @result EXEC Subsidiary_Cartago.dbo.GetCommission @employee, @start, @end
		IF (@subsidiary IS NULL OR @subsidiary = 2)
			INSERT INTO @result EXEC Subsidiary_SanJose.dbo.GetCommission @employee, @start, @end

		SELECT r.*, c.baseSalary AS [Salario base], r.Comision + c.baseSalary AS Total FROM
		(
		SELECT idSubsidiary AS #Sucursal, subsidiary AS Sucursal,
			idEmployee AS #Empleado, employee AS Empleado, SUM(commission) AS Comision
		FROM @result
		GROUP BY subsidiary, idSubsidiary, idEmployee, employee
		) r INNER JOIN [Contract] c ON (r.#Empleado = c.idEmployee)

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END

exec GetEmployeeSalary  @employee = null,
 @subsidiary= null,
 @start = null,
 @end = null;
GO


--**************************************************************************************

USE [Workshop]
GO

/****** Object:  StoredProcedure [dbo].[GetCommission]    Script Date: 14/08/2020 21:51:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCommission]
 @employee int = null,
 @subsidiary smallint = null,
 @start date = null,
 @end date = null
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @result TABLE(idSubsidiary int, subsidiary varchar(100),
			idEmployee int, employee varchar(100), commission int)

		IF (@subsidiary IS NULL OR @subsidiary = 1)
			INSERT INTO @result EXEC Subsidiary_Alajuela.dbo.GetCommission @employee, @start, @end
		IF (@subsidiary IS NULL OR @subsidiary = 2)
			INSERT INTO @result EXEC Subsidiary_Cartago.dbo.GetCommission @employee, @start, @end
		IF (@subsidiary IS NULL OR @subsidiary = 3)
			INSERT INTO @result EXEC Subsidiary_SanJose.dbo.GetCommission @employee, @start, @end

		SELECT ISNULL(r.idSubsidiary, 0) AS #Sucursal, ISNULL(r.subsidiary, 'Todas') AS Sucursal,
			ISNULL(r.idEmployee, 0) AS #Empleado, ISNULL(r.[employee], 'Todos') AS Empleado,
			SUM(r.commission) AS Total
		FROM @result r
		GROUP BY ROLLUP ((r.idSubsidiary, r.subsidiary), (r.idEmployee, r.[employee]))

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END

--exec GetCommission
GO

--***********************************************************************************
--
-- USE [Workshop]
-- GO

/****** Object:  StoredProcedure [dbo].[GetStock]    Script Date: 14/08/2020 21:52:42 ******/
-- DROP PROCEDURE [dbo].[GetStock]
-- GO

/****** Object:  StoredProcedure [dbo].[GetStock]    Script Date: 14/08/2020 21:52:42 ******/
-- SET ANSI_NULLS ON
-- GO
--
-- SET QUOTED_IDENTIFIER ON
-- GO
--
-- -- =============================================
-- -- Author:		<Author,,Name>
-- -- Create date: <Create Date,,>
-- -- Description:	<Description,,>
-- -- =============================================
-- CREATE PROCEDURE [dbo].[GetStock]
--  @user bigint
-- AS
-- BEGIN
-- 	BEGIN TRY
-- 		BEGIN TRANSACTION
--
-- 		DECLARE @distance FLOAT, @sql NVARCHAR(MAX), @subsidiary smallint;
-- 		DECLARE @sale TABLE(id_product bigint, sale int)
-- 		DECLARE @user_address GEOGRAPHY, @Lat INT, @Lon INT, @purchase INT;
-- 		DECLARE @geo TABLE(Lo int, La int);
-- 		SET @sql = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call GetLocation(' + CAST(@user AS NVARCHAR(50)) + ')'')';
-- 		INSERT INTO @geo EXEC (@sql);
-- 		SELECT @Lat = La, @Lon = Lo FROM @geo
-- 		SET @user_address = geography::STGeomFromText('POINT(' + CAST(@Lon AS VARCHAR(20)) + ' ' + CAST(@Lat AS VARCHAR(20)) + ')', 4326);
-- 		SELECT TOP 1 @subsidiary = [idSubsidiary], @distance = [address].STDistance(@user_address)
-- 		FROM [dbo].[Subsidiary]
-- 		ORDER BY [address].STDistance(@user_address) ASC;
--
-- 		IF (@subsidiary = 1)
-- 			INSERT INTO @sale SELECT idProduct, salePercentage
-- 			FROM Subsidiary_Alajuela.dbo.Sale WHERE [enable] = 1
--
-- 		Select idProduct, quantity, ISNULL(sale, 0) as sale
-- 		FROM Stock LEFT JOIN @sale ON (Stock.idProduct = id_product)
-- 		WHERE idSubsidiary = @subsidiary
--
--
-- 		COMMIT
-- 	END TRY
-- 	BEGIN CATCH
-- 		SELECT ERROR_MESSAGE()
-- 		ROLLBACK
-- 	END CATCH
-- END
-- GO
--



-- USE [Subsidiary_Alajuela]
-- GO

/****** Object:  StoredProcedure [dbo].[Report]    Script Date: 11/08/2020 15:13:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Report]
 @idEmployee SMALLINT = NULL,
 @product BIGINT = NULL,
 @start_date DATE = NULL,
 @end_date DATE = NULL
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		SELECT 1 AS #Sucursal, 'Sucursal Cartago' AS Sucursal, ISNULL(e.idEmployee, 0) AS #Empleado,
			ISNULL(u.[name] + ' ' + u.lastname, 'Sistema') AS Empleado, p.idProduct AS #Producto,
			p.[name] AS Producto, pp.quantity AS Cantidad, pp.subtotal AS Total
		FROM Purchase _p INNER JOIN PurchaseProduct pp ON (_p.idPurchase = pp.idPurchase)
			INNER JOIN Product p ON (pp.idProduct = p.idProduct)
			LEFT JOIN Employee e ON (_p.idEmployee = e.idEmployee)
			LEFT JOIN [User] u ON (e.[user] = u.idUser)
		WHERE (@idEmployee IS NULL OR e.idEmployee = @idEmployee)
			AND (@product IS NULL OR pp.idProduct = @product)
			AND (@start_date IS NULL OR _p.[date] >= @start_date)
			AND (@end_date IS NULL OR _p.[date] <= @end_date)

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END
GO

--***********************************************************************************************--

-- USE [Subsidiary_Alajuela]
-- GO

/****** Object:  StoredProcedure [dbo].[GainReport]    Script Date: 11/08/2020 15:13:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[GainReport]
 @product BIGINT = NULL,
 @start_date DATE = NULL,
 @end_date DATE = NULL
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		SELECT 1 AS #Sucursal, 'Sucursal San José' AS Sucursal, p.idProduct AS #Producto,
			p.[name] AS Producto, pp.quantity AS Cantidad, pp.subtotal * 0.87 - p.productionCost AS Total
		FROM Purchase _p INNER JOIN PurchaseProduct pp ON (_p.idPurchase = pp.idPurchase)
			INNER JOIN Product p ON (pp.idProduct = p.idProduct)
		WHERE (@product IS NULL OR pp.idProduct = @product)
			AND (@start_date IS NULL OR _p.[date] >= @start_date)
			AND (@end_date IS NULL OR _p.[date] <= @end_date)

		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END
GO



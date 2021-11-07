-- USE [Subsidiary_Alajuela]
-- GO

/****** Object:  StoredProcedure [dbo].[GetCommission]    Script Date: 14/08/2020 21:57:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
    ALTER PROCEDURE [dbo].[GetCommission]
    @user int = null,
        @start date = null,
        @end date = null
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION

                SELECT 3 as Subsidiary, 'Sucursal Alajuela', p.idEmployee, CONCAT([name], ' ' , lastname) as [name], comission
                FROM Employee e LEFT JOIN Purchase p ON (p.idEmployee = e.idEmployee)
                                LEFT JOIN ComissionPurchase c ON (p.idPurchase = c.idPurchase)
                                LEFT JOIN [User] u ON (e.[user] = u.idUser)
                WHERE (@user IS NULL OR @user = p.idEmployee) AND
                    (@start IS NULL OR p.[date] > @start) AND (@end IS NULL or p.[date] < @end)

            COMMIT
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK
        END CATCH
    END
GO

--**************************************************************************--


USE [Subsidiary_Alajuela]
GO

/****** Object:  StoredProcedure [dbo].[RegisterPurchaseProduct]    Script Date: 14/08/2020 21:57:35 ******/
DROP PROCEDURE [dbo].[RegisterPurchaseProduct]
GO

/****** Object:  StoredProcedure [dbo].[RegisterPurchaseProduct]    Script Date: 14/08/2020 21:57:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[RegisterPurchaseProduct]
	@purchase int,
    @products varchar(max),
	@coupon decimal(9,2)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRAN

	DECLARE @params TABLE( _value1 bigint, _value2 int, _value3 int, _value4 int);

	INSERT INTO @params
	SELECT __row._value1, @purchase, __row._value2, [dbo].[GetCost](@coupon, __row._value2, __row._value1) as cost
	FROM STRING_SPLIT(@products, '&') _row CROSS APPLY [dbo].[Split](_row.value, ':') __row

	INSERT INTO [dbo].[PurchaseProduct] ([idProduct], [idPurchase], [quantity], [subtotal])
	SELECT _value1, _value2, _value3, _value4 FROM @params

	DECLARE @id INT;
	SELECT @id = MAX(idComission) + 1 FROM [dbo].ComissionPurchase

	IF (@id IS NULL)
		SET @id = 1;

	IF EXISTS (SELECT * FROM Purchase WHERE idPurchase = @purchase AND idEmployee IS NOT NULL)
		INSERT INTO ComissionPurchase([idComission], [idPurchase], [comission])
		SELECT @id, @purchase, SUM(_value4) * 0.1
		FROM @params

	-- Begin Return Select <- do not remove
	SELECT [idPurchaseProduct], [idProduct], [idPurchase], [quantity], [subtotal]
	FROM   [dbo].[PurchaseProduct]
	-- End Return Select <- do not remove

	COMMIT
GO
--***********************************************************************************************--


/****** Object:  StoredProcedure [dbo].[RegisterPurchaseProduct]    Script Date: 09/08/2020 20:49:23 ******/
-- DROP PROCEDURE [dbo].[RegisterPurchaseProduct]
-- GO

/****** Object:  StoredProcedure [dbo].[RegisterPurchaseProduct]    Script Date: 09/08/2020 20:49:23 ******/
-- USE [Subsidiary_Alajuela]
-- GO

/****** Object:  StoredProcedure [dbo].[RegisterPurchaseProduct]    Script Date: 10/08/2020 13:18:23 ******/
-- DROP PROCEDURE [dbo].[RegisterPurchaseProduct]
-- GO

/** Object:  StoredProcedure [dbo].[RegisterPurchaseProduct]    Script Date: 10/08/2020 18:37:20 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[RegisterPurchaseProduct]
    @purchase int,
        @products varchar(max),
        @coupon decimal(9, 2)
    AS
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRAN
    DECLARE
        @params TABLE
                (
                    _value1 int,
                    _value2 int,
                    _value3 int,
                    _value4 int
                );

    INSERT INTO @params
    SELECT __row._value1, @purchase, __row._value2, [dbo].[GetCost](@coupon, __row._value2, __row._value1) as cost
    FROM STRING_SPLIT(@products, '_') _row
             CROSS APPLY [dbo].[Split](_row.value, ':') __row
    INSERT INTO [dbo].[PurchaseProduct] ([idProduct], [idPurchase], [quantity], [subtotal])
    SELECT _value1, _value2, _value3, _value4
    FROM @params;


    DECLARE
        @value1 int;
    SET @value1 = (SELECT TOP 1_value1
                   FROM @params);

    DECLARE
        @value2 int;
    SET @value2 = (SELECT TOP 1 _value3
                   FROM @params);


    EXEC UpdateStock @value1, @value2;

    -- Begin Return Select <- do not remove
--     SELECT [idPurchaseProduct], [idProduct], [idPurchase], [quantity], [subtotal]
--     FROM   [dbo].[PurchaseProduct]
    -- End Return Select <- do not remove

    COMMIT

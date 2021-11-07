-- USE [Subsidiary_Alajuela]
-- GO

/****** Object:  UserDefinedFunction [dbo].[GetCost]    Script Date: 10/08/2020 13:20:26 ******/
-- DROP FUNCTION [dbo].[GetCost]
-- GO

/****** Object:  UserDefinedFunction [dbo].[GetCost]    Script Date: 10/08/2020 13:20:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
    ALTER FUNCTION [dbo].[GetCost]
    (@coupon decimal(9, 2),
        @quantity int,
        @product bigint)
    RETURNS MONEY
    AS
    BEGIN
        DECLARE @sale decimal(9, 2), @result money;
        SELECT @sale = salePercentage FROM Sale WHERE idProduct = @product AND [enable] = 1
        IF (@sale IS NULL)
            SET @sale = 0;
        SELECT @result = finalCost * @quantity * (1 - @coupon / 100 - @sale / 100 + 0.13)
        FROM Product
        WHERE idProduct = @product

        RETURN @result;
    END

GO
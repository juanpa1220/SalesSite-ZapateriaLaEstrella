/** Object:  StoredProcedure [dbo].[sp_read_stock]    Script Date: 14/08/2020 21:31:33 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[create_sale] @idProduct int, @salePercentage decimal(9, 2), @expirationDate date,
                                @description varchar(100)
AS

    BEGIN TRAN
DECLARE @idSale int;
SELECT @idSale = MAX(idSale) + 1
FROM Sale;
INSERT INTO dbo.Sale(idSale, idProduct, salePercentage, expirationDate, [description], [enable])
VALUES (@idSale, @idProduct, @salePercentage, @expirationDate, @description, 1)
    COMMIT


-- EXEC create_sale @idProduct = 1, @salePercentage = 1.2, @expirationDate = '2020-12-12',
--                                 @description = '';

/** Object:  StoredProcedure [dbo].[sp_read_stock]    Script Date: 14/08/2020 21:31:33 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[create_sale] @idSubsidiary smallint, @idProduct int, @salePercentage decimal(9, 2),
                                @expirationDate date, @description varchar(100)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN
    if (@idSubsidiary = 1)
        EXEC Subsidiary_Cartago.dbo.create_sale @idProduct, @salePercentage, @expirationDate, @description
    if (@idSubsidiary = 2)
        EXEC Subsidiary_SanJose.dbo.create_sale @idProduct, @salePercentage, @expirationDate, @description
    if (@idSubsidiary = 3)
        EXEC Subsidiary_Alajuela.dbo.create_sale @idProduct, @salePercentage, @expirationDate, @description
    COMMIT



--     EXEC create_sale @idSubsidiary = 1, @idProduct = 1, @salePercentage = 1.5,
--          @expirationDate = '2020-12-12', @description = 'test'
USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[sp_read_stock]    Script Date: 14/08/2020 21:31:33 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[get_products]
    @idSubsidiary smallint
    AS
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRAN
    if (@idSubsidiary is null)
        select Subsidiary.name AS Sucursal, p.name AS Nombre, p.finalCost AS Precio
        from Product p
                 inner join Stock s on s.idProduct = p.idProduct
                 inner join Subsidiary on s.idSubsidiary = Subsidiary.idSubsidiary;


    Else
        if (@idSubsidiary = 1)
            EXEC Subsidiary_Alajuela.dbo.get_products
    if (@idSubsidiary = 2)
        EXEC Subsidiary_Cartago.dbo.get_products
    if (@idSubsidiary = 3)
        EXEC Subsidiary_SanJose.dbo.get_products
    COMMIT




    EXEC get_products @idSubsidiary = 1;
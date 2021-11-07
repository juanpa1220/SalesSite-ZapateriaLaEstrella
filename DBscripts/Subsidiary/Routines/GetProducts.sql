/** Object:  StoredProcedure [dbo].[sp_read_stock]    Script Date: 14/08/2020 21:31:33 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[get_products]
    AS
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRAN
    SELECT p.name as 'Nombre', p.finalCost as 'Pecio', ISNULL(s.salePercentage, 0) as 'Descuento'
    FROM Product p
             left join Sale s on p.idProduct = s.idProduct
    COMMIT
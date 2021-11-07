USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[RegisterPurchase]    Script Date: 13/08/2020 12:13:12 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
    ALTER PROCEDURE [dbo].GetStock @user bigint
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @sale TABLE
                              (
                                  id_product bigint,
                                  sale       int
                              );
                DECLARE @distance FLOAT, @sql NVARCHAR(MAX);
                DECLARE @user_address GEOGRAPHY, @Lat float, @Lon float, @subsidiary smallint;
                DECLARE @geo TABLE
                             (
                                 Lo float,
                                 La float
                             );
                SET @sql = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call GetLocation(' +
                           CAST(@user AS NVARCHAR(50)) + ')'')';
                INSERT INTO @geo EXEC (@sql);
                SELECT @Lat = La, @Lon = Lo FROM @geo
                SET @user_address =
                        geography::STGeomFromText('POINT(' + CAST(@Lat AS VARCHAR(max)) + ' ' + CAST(@Lon AS VARCHAR(max)) + ')', 4326);
                SELECT TOP 1 @distance = [address].STDistance(@user_address), @subsidiary = [idSubsidiary]
                FROM [dbo].[Subsidiary]
                ORDER BY [address].STDistance(@user_address);

--                 Select idProduct, quantity FROM Stock WHERE idSubsidiary = @subsidiary;

                IF (@subsidiary = 1)
                    INSERT INTO @sale
                    SELECT idProduct, salePercentage
                    FROM Subsidiary_Cartago.dbo.Sale
                    WHERE [enable] = 1
                IF (@subsidiary = 2)
                    INSERT INTO @sale
                    SELECT idProduct, salePercentage
                    FROM Subsidiary_SanJose.dbo.Sale
                    WHERE [enable] = 1
                IF (@subsidiary = 3)
                    INSERT INTO @sale
                    SELECT idProduct, salePercentage
                    FROM Subsidiary_Alajuela.dbo.Sale
                    WHERE [enable] = 1


                Select idProduct, quantity, ISNULL(sale, 0) as sale
                FROM Stock
                         LEFT JOIN @sale ON (Stock.idProduct = id_product)
                WHERE idSubsidiary = @subsidiary
            COMMIT
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK
        END CATCH
    END


--     EXEC GetStock @user = 24;
ALTER PROCEDURE [dbo].[RegisterScore]
    @subsidiary smallint,
        @comment varchar(100),
        @value tinyint
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @delivery int;

                IF (@subsidiary = 1)
                    SET @delivery = (SELECT max(idDelivery) FROM Subsidiary_Cartago.dbo.Delivery)
                IF (@subsidiary = 2)
                    SET @delivery = (SELECT max(idDelivery) FROM Subsidiary_SanJose.dbo.Delivery)
                IF (@subsidiary = 3)
                    SET @delivery = (SELECT max(idDelivery) FROM Subsidiary_Alajuela.dbo.Delivery)


                IF (@subsidiary = 1)
                    EXEC Subsidiary_Cartago.dbo.RegisterScore @delivery, @comment, @value;
                IF (@subsidiary = 2)
                    EXEC Subsidiary_SanJose.dbo.RegisterScore @delivery, @comment, @value;
                IF (@subsidiary = 3)
                    EXEC Subsidiary_Alajuela.dbo.RegisterScore @delivery, @comment, @value;
            COMMIT
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK
        END CATCH
    END
GO


EXEC RegisterScore @subsidiary= 1, @comment ='comentario', @value= 3;
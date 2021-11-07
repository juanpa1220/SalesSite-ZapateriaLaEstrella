-- USE [Subsidiary_Alajuela]
-- GO

/****** Object:  StoredProcedure [dbo].[RegisterPurchase]    Script Date: 09/08/2020 20:49:09 ******/
-- DROP PROCEDURE [dbo].[RegisterPurchase]
-- GO

/****** Object:  StoredProcedure [dbo].[RegisterPurchase]    Script Date: 09/08/2020 20:49:09 ******/
-- USE [Subsidiary_Alajuela]
-- GO
/** Object:  StoredProcedure [dbo].[RegisterPurchase]    Script Date: 10/08/2020 18:34:56 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RegisterPurchase]
    @user bigint,
        @employee int,
        @detail varchar(100),
        @discount decimal(9, 2),
        @delivery bit
    AS
    BEGIN
        BEGIN TRY
            DECLARE @id INT;
            SELECT @id = MAX(idPurchase) + 1 FROM [dbo].[Purchase]

            IF (@id IS NULL)
                SET @id = 1;

            INSERT INTO [dbo].[Purchase](idPurchase, idUser, [date], idEmployee, tax, detail, discount)
            VALUES (@id, @user, GETDATE(), @employee, 13.0, @detail, @discount)

            IF (@delivery = 1)
                BEGIN
                    DECLARE @idD INT;
                    SELECT @idD = MAX(idDelivery) + 1 FROM [dbo].[Delivery]

                    IF (@idD IS NULL)
                        SET @idD = 1;


                    INSERT INTO Delivery(idDelivery, idPurchase, idStatus, shippingDate, receptionDate, active)
                    VALUES (@idD, @id, 1, GETDATE(), GETDATE(), 1)
                END

            RETURN @id;
        END TRY
        BEGIN CATCH
            SELECT 'Subsidiary' + ERROR_MESSAGE()
        END CATCH
    END











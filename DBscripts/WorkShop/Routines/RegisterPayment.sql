USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[RegisterPayment]    Script Date: 10/08/2020 18:40:19 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RegisterPayment]
    @amount money, @idPaymentMethod bigint, @idSubsidiary smallint
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION payment
                DECLARE @idPurchase int;

                if (@idSubsidiary = 1)
                    SET @idPurchase = (SELECT max(idPurchase) FROM Subsidiary_Cartago.dbo.Purchase);
                if (@idSubsidiary = 2)
                    SET @idPurchase = (SELECT max(idPurchase) FROM Subsidiary_SanJose.dbo.Purchase);
                if (@idSubsidiary = 3)
                    SET @idPurchase = (SELECT max(idPurchase) FROM Subsidiary_Alajuela.dbo.Purchase);

                if (@idSubsidiary = 1)
                    EXEC Subsidiary_Cartago.dbo.RegisterPayment @idPurchase, '', 1, @amount, 1, @idPaymentMethod;
                if (@idSubsidiary = 2)
                    EXEC Subsidiary_SanJose.dbo.RegisterPayment @idPurchase, '', 1, @amount, 1, @idPaymentMethod;
                if (@idSubsidiary = 3)
                    EXEC Subsidiary_Alajuela.dbo.RegisterPayment @idPurchase, '', 1, @amount, 1, @idPaymentMethod;
            COMMIT TRANSACTION payment
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK TRANSACTION payment
        END CATCH
    END;


--     EXEC RegisterPayment @amount = 1000,
--          @idPaymentMethod= 1,
--          @idSubsidiary = 1;


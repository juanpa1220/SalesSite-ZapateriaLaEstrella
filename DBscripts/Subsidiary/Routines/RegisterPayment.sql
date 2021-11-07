SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RegisterPayment]
 @idPurchase int, @result varchar(100), @transaction bigint, @amount money, @idPaymentStatus tinyint,
@idPaymentMethod bigint

AS
BEGIN
	BEGIN TRY


		DECLARE @id INT;
		SELECT @id = MAX(idPayment) + 1 FROM [dbo].[Payment]
		IF (@id IS NULL)
			SET @id = 1;

		INSERT INTO dbo.Payment(idPayment,[date],result,[transaction],amount,idPaymentStatus,idPurchase,
		idPaymentMethod)
		VALUES(@id,GETDATE(),@result,@transaction,@amount,@idPaymentStatus, @idPurchase,@idPaymentMethod)


	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
	END CATCH
END
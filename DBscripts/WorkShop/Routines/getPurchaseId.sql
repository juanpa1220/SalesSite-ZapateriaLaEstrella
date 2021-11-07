ALTER PROCEDURE getPurchaseId
@idSubsidiary smallint
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @idPurchase int
		if (@idSubsidiary=1)
			SELECT MAX(Purchase.idPurchase) AS result FROM Subsidiary_Cartago.dbo.Purchase
		if (@idSubsidiary=2)
			SELECT MAX(Purchase.idPurchase) AS result FROM Subsidiary_SanJose.dbo.Purchase
		if (@idSubsidiary=3)
			SELECT MAX(Purchase.idPurchase) AS result FROM Subsidiary_Alajuela.dbo.Purchase
		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END
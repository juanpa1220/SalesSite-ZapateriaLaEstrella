USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[isAdmin]    Script Date: 11/08/2020 23:34:19 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[isAdmin]  @idUser int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @admin nvarchar(max);
		SET @admin = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call isAdmin('''''+CAST(@idUser as varchar)+''''')'')'
		EXEC (@admin)
		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END


EXEC isAdmin @idUser=1;
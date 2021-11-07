USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[getCategories] **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getCategories]
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION getCategories
            SELECT idCategory AS value, name AS label, description FROM Category;
        COMMIT TRANSACTION getCategories
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK TRANSACTION getCategories
    END CATCH
END
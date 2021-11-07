USE [Workshop]
GO

CREATE PROCEDURE [dbo].[get_cities]
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION cities
            SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, 'select city as value, city as label from city')
        COMMIT TRANSACTION cities
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK TRANSACTION cities
    END CATCH
END
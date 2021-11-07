USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[validate_coupon]    Script Date: 09/08/2020 11:30:12 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[validate_coupon] @idUser bigint,
                                         @coupon varchar(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION validate
            DECLARE @result varchar(MAX);
            SET @result = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call sp_validate_coupon(' +
                          CAST(@idUser as varchar(20)) + ',''''' + @coupon + ''''')'')';
            EXEC (@result);

        COMMIT TRANSACTION validate
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK TRANSACTION validate
    END CATCH
END



--     EXEC validate_coupon @idUser=1, @coupon='coupon123';
USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[GetUserContact]    Script Date: 11/08/2020 22:40:31 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserContact]
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION

                SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, 'call GetUserContact()');

            COMMIT
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK
        END CATCH
    END
USE [Workshop]
GO
/** Object:  StoredProcedure [dbo].[isAdmin]    Script Date: 12/08/2020 22:21:17 **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[get_employees]
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            SELECT *
            FROM OPENQUERY(CUSTOMER_SERVICE,
                           'SELECT u.idUser as `value`, `name` as label FROM `user` u inner join `account` a on u.idUser = a.idUser WHERE a.idType = 3')
        COMMIT
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK
    END CATCH
END


EXEC get_employees ;


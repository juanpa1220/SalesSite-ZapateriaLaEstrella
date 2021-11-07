USE [Workshop]
GO

/** Object:  StoredProcedure [dbo].[LogIn]    Script Date: 08/08/2020 18:52:01 **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LogIn] @username varchar(50),
                               @password varchar(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @sql NVARCHAR(MAX), @result INT;
            SET @sql = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call authenticate(''''' + @username + ''''',''''' +
                       @password + ''''')'')';
            EXEC (@sql);
        COMMIT
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK
    END CATCH
END
GO

-- insert into contact_type values (1, "contact type", "description", 1);
-- insert into user_contact values (1,1,1 )



EXEC [dbo].LogIn @username = 'username', @password = 'password';
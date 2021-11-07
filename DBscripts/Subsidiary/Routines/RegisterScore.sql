SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RegisterScore] @delivery int,
                                       @comment varchar(100),
                                       @value tinyint
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @id INT;
            SELECT @id = MAX(idScore) + 1 FROM [dbo].[Score]

            IF (@id IS NULL)
                SET @id = 1;

            INSERT INTO [dbo].[Score](idScore, idDelivery, comment, [value])
            VALUES (@id, @delivery, @comment, @value)
        COMMIT

        RETURN @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK
    END CATCH
END
GO
CREATE PROCEDURE MakeCall @user BIGINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            IF EXISTS(SELECT * FROM CalledUser WHERE idCalledUser = @user AND [date] = CONVERT(date, GETDATE()))
                INSERT INTO CalledUser(idUser, [date]) VALUES (@user, GETDATE())
            ELSE
                SELECT 0;
            SELECT 1;
        COMMIT
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE()
        ROLLBACK
    END CATCH
END

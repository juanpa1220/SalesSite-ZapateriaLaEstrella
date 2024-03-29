USE [Workshop]
GO
/****** Object:  StoredProcedure [dbo].[sp_read_employee]    Script Date: 13/08/2020 00:51:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_read_employee]
        @subsidiary smallint = null,
        @employee int = null
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @user bigint = null, @sql varchar(100)
                DECLARE @users table
                               (
                                   idu          bigint,
                                   idc          varchar(15),
                                   [name]       varchar(50),
                                   lastname     varchar(50),
                                   bithdate     date,
                                   registration date,
                                   [address]    varchar(30),
                                   [enable]     bit,
                                   active       bit
                               )
                DECLARE @employees table
                                   (
                                       subsidiary varchar(50),
                                       ide        int,
                                       [user]     bigint,
                                       photo      varchar(max)
                                   )

                INSERT INTO @employees
                Select s.[name], e.idEmployee, e.[user], e.photo
                FROM Employee e
                         INNER JOIN Subsidiary s ON (e.idSubsidiary = s.idSubsidiary)
                WHERE (@employee IS NULL OR e.idEmployee = @employee)
                  AND (@subsidiary IS NULL OR e.idSubsidiary = @subsidiary)


                IF (@employee IS NOT NULL)
                    SELECT @user = [user] FROM @employees where ide = @employee

                SET @sql = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call sp_read_user(' +
                           ISNULL(CAST(@user as varchar(10)), 'null') + ')'')'

                INSERT INTO @users
                    EXEC (@sql)

                SELECT u.name AS Nombre, u.lastname AS Apellido, j.name AS Puesto, c.baseSalary AS 'Salario base'
                FROM @users u
                         INNER JOIN @employees e ON (u.idu = e.[user])
                         INNER JOIN Contract c ON (e.ide = c.idEmployee)
                         INNER JOIN Job j ON (c.idJob = j.idJob)
            COMMIT
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK
        END CATCH
    END


        EXEC sp_read_employee @subsidiary=null;

--******************************************************************************************--

    USE [Workshop]
GO

/****** Object:  StoredProcedure [dbo].[sp_update_employee]    Script Date: 13/08/2020 01:21:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_update_employee] @idEmployee bigint,
                                       @idSubsidiary smallint,
                                       @user bigint,
                                       @photo varchar(MAX)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN
        Declare @subsidiary smallint = 0

        SELECT @subsidiary = idSubsidiary FROM Employee WHERE idEmployee = @idEmployee

        UPDATE [dbo].[Employee]
        SET [idSubsidiary] = @idSubsidiary,
            [user]         = @user,
            [photo]        = @photo
        WHERE [idEmployee] = @idEmployee

        IF (@subsidiary = @idSubsidiary)
            BEGIN
                IF (@idSubsidiary = 1)
                    EXEC Subsidiary_Alajuela.dbo.sp_update_employee @idEmployee, @user, @photo;
                IF (@idSubsidiary = 2)
                    EXEC Subsidiary_Cartago.dbo.sp_update_employee @idEmployee, @user, @photo;
                IF (@idSubsidiary = 3)
                    EXEC Subsidiary_SanJose.dbo.sp_update_employee @idEmployee, @user, @photo;
            END
        ELSE
            BEGIN
                IF (@subsidiary = 1)
                    EXEC Subsidiary_Alajuela.dbo.sp_delete_employee @idEmployee;
                IF (@subsidiary = 2)
                    EXEC Subsidiary_Cartago.dbo.sp_delete_employee @idEmployee;
                IF (@subsidiary = 3)
                    EXEC Subsidiary_SanJose.dbo.sp_delete_employee @idEmployee;

                IF (@idSubsidiary = 1)
                    EXEC Subsidiary_Alajuela.dbo.sp_create_employee @idEmployee, @user, @photo;
                IF (@idSubsidiary = 2)
                    EXEC Subsidiary_Cartago.dbo.sp_create_employee @idEmployee, @user, @photo;
                IF (@idSubsidiary = 3)
                    EXEC Subsidiary_SanJose.dbo.sp_create_employee @idEmployee, @user, @photo;
            END
    COMMIT
END
GO

--************************************************************************************************-

ALTER PROCEDURE sp_delete_employee
    @user bigint
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @sql varchar(max)
                SET @sql = 'SELECT * FROM OPENQUERY(CUSTOMER_SERVICE, ''call sp_desactive_user(' +
                           CAST(@user as varchar(20)) + ')'')'
                EXEC (@sql)
            COMMIT
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE()
            ROLLBACK
        END CATCH
    END

--************************************************************************************************--

    CREATE PROC [dbo].[sp_create_employee] @idSubsidiary smallint,
                                           @user bigint,
                                           @photo varbinary(MAX)
    AS
    BEGIN
        SET NOCOUNT ON
        SET XACT_ABORT ON

        BEGIN TRAN
            DECLARE @idEmployee INT;
            SELECT @idEmployee = MAX(idEmployee) + 1 FROM [dbo].Employee

            IF (@idEmployee IS NULL)
                SET @idEmployee = 1;

            INSERT INTO Employee(idEmployee, [idSubsidiary], [user], [photo])
            VALUES (@idEmployee, @idSubsidiary, @user, @photo)

            IF (@idSubsidiary = 1)
                EXEC Subsidiary_Alajuela.dbo.sp_create_employee @idEmployee, @user, @photo;
            IF (@idSubsidiary = 2)
                EXEC Subsidiary_Cartago.dbo.sp_create_employee @idEmployee, @user, @photo;
            IF (@idSubsidiary = 3)
                EXEC Subsidiary_SanJose.dbo.sp_create_employee @idEmployee, @user, @photo;
        COMMIT
    END
GO
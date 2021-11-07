GO

IF OBJECT_ID('[dbo].[sp_read_category]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_category]
    END
GO
CREATE PROC [dbo].[sp_read_category] @idCategory tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idCategory], [name], [description], [enable]
FROM [dbo].[Category]
WHERE ([idCategory] = @idCategory OR @idCategory IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_category]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_category]
    END
GO
CREATE PROC [dbo].[sp_create_category] @idCategory tinyint,
                                       @name nvarchar(50),
                                       @description nvarchar(250),
                                       @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Category] ([idCategory], [name], [description], [enable])
SELECT @idCategory, @name, @description, @enable

    -- Begin Return Select <- do not remove
SELECT [idCategory], [name], [description], [enable]
FROM [dbo].[Category]
WHERE [idCategory] = @idCategory
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_category]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_category]
    END
GO
CREATE PROC [dbo].[sp_update_category] @idCategory tinyint,
                                       @name nvarchar(50),
                                       @description nvarchar(250),
                                       @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Category]
SET [name]        = @name,
    [description] = @description,
    [enable]      = @enable
WHERE [idCategory] = @idCategory

    -- Begin Return Select <- do not remove
SELECT [idCategory], [name], [description], [enable]
FROM [dbo].[Category]
WHERE [idCategory] = @idCategory
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_category]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_category]
    END
GO
CREATE PROC [dbo].[sp_delete_category] @idCategory tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Category]
WHERE [idCategory] = @idCategory
    COMMIT
GO
-----------------------------------------------------------------------------------------
USE [Workshop];
GO

IF OBJECT_ID('[dbo].[sp_read_contract]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_contract]
    END
GO
CREATE PROC [dbo].[sp_read_contract] @idContract int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idContract], [idEmployee], [idJob], [file], [baseSalary], [admissionDate], [paymentDate]
FROM [dbo].[Contract]
WHERE ([idContract] = @idContract OR @idContract IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_contract]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_contract]
    END
GO
CREATE PROC [dbo].[sp_create_contract] @idContract int,
                                       @idEmployee bigint,
                                       @idJob tinyint,
                                       @file varbinary(MAX),
                                       @baseSalary money,
                                       @admissionDate date,
                                       @paymentDate date
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Contract] ([idContract], [idEmployee], [idJob], [file], [baseSalary], [admissionDate], [paymentDate])
SELECT @idContract, @idEmployee, @idJob, @file, @baseSalary, @admissionDate, @paymentDate

    -- Begin Return Select <- do not remove
SELECT [idContract], [idEmployee], [idJob], [file], [baseSalary], [admissionDate], [paymentDate]
FROM [dbo].[Contract]
WHERE [idContract] = @idContract
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_contract]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_contract]
    END
GO
CREATE PROC [dbo].[sp_update_contract] @idContract int,
                                       @idEmployee bigint,
                                       @idJob tinyint,
                                       @file varbinary(MAX),
                                       @baseSalary money,
                                       @admissionDate date,
                                       @paymentDate date
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Contract]
SET [idEmployee]    = @idEmployee,
    [idJob]         = @idJob,
    [file]          = @file,
    [baseSalary]    = @baseSalary,
    [admissionDate] = @admissionDate,
    [paymentDate]   = @paymentDate
WHERE [idContract] = @idContract

    -- Begin Return Select <- do not remove
SELECT [idContract], [idEmployee], [idJob], [file], [baseSalary], [admissionDate], [paymentDate]
FROM [dbo].[Contract]
WHERE [idContract] = @idContract
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_contract]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_contract]
    END
GO
CREATE PROC [dbo].[sp_delete_contract] @idContract int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Contract]
WHERE [idContract] = @idContract
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [Workshop];
GO

IF OBJECT_ID('[dbo].[sp_read_stock]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_stock]
    END
GO
CREATE PROC [dbo].[sp_read_stock] @idStock int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idStock], [idProduct], [idSubsidiary], [quantity]
FROM [dbo].[Stock]
WHERE ([idStock] = @idStock OR @idStock IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_stock]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_stock]
    END
GO
CREATE PROC [dbo].[sp_create_stock] @idStock int,
                                    @idProduct bigint,
                                    @idSubsidiary smallint,
                                    @quantity int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Stock] ([idStock], [idProduct], [idSubsidiary], [quantity])
SELECT @idStock, @idProduct, @idSubsidiary, @quantity

    -- Begin Return Select <- do not remove
SELECT [idStock], [idProduct], [idSubsidiary], [quantity]
FROM [dbo].[Stock]
WHERE [idStock] = @idStock
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_stock]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_stock]
    END
GO
CREATE PROC [dbo].[sp_update_stock] @idStock int,
                                    @idProduct bigint,
                                    @idSubsidiary smallint,
                                    @quantity int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Stock]
SET [idProduct]    = @idProduct,
    [idSubsidiary] = @idSubsidiary,
    [quantity]     = @quantity
WHERE [idStock] = @idStock

    -- Begin Return Select <- do not remove
SELECT [idStock], [idProduct], [idSubsidiary], [quantity]
FROM [dbo].[Stock]
WHERE [idStock] = @idStock
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_stock]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_stock]
    END
GO
CREATE PROC [dbo].[sp_delete_stock] @idStock int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Stock]
WHERE [idStock] = @idStock
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


GO

IF OBJECT_ID('[dbo].[sp_read_product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_product]
    END
GO
CREATE PROC [dbo].[sp_read_product] @idProduct bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idProduct],
       [idCategory],
       [name],
       [description],
       [photo],
       [manufacturingDate],
       [productionCost],
       [finalCost],
       [enable]
FROM [dbo].[Product]
WHERE ([idProduct] = @idProduct OR @idProduct IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_product]
    END
GO
CREATE PROC [dbo].[sp_create_product] @idProduct bigint,
                                      @idCategory tinyint,
                                      @name nvarchar(100),
                                      @description nvarchar(300),
                                      @photo nvarchar(200),
                                      @manufacturingDate date,
                                      @productionCost money,
                                      @finalCost money,
                                      @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Product] ([idProduct], [idCategory], [name], [description], [photo], [manufacturingDate],
                             [productionCost], [finalCost], [enable])
SELECT @idProduct,
       @idCategory,
       @name,
       @description,
       @photo,
       @manufacturingDate,
       @productionCost,
       @finalCost,
       @enable

    -- Begin Return Select <- do not remove
SELECT [idProduct],
       [idCategory],
       [name],
       [description],
       [photo],
       [manufacturingDate],
       [productionCost],
       [finalCost],
       [enable]
FROM [dbo].[Product]
WHERE [idProduct] = @idProduct
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_product]
    END
GO
CREATE PROC [dbo].[sp_update_product] @idProduct bigint,
                                      @idCategory tinyint,
                                      @name nvarchar(100),
                                      @description nvarchar(300),
                                      @photo nvarchar(200),
                                      @manufacturingDate date,
                                      @productionCost money,
                                      @finalCost money,
                                      @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Product]
SET [idCategory]        = @idCategory,
    [name]              = @name,
    [description]       = @description,
    [photo]             = @photo,
    [manufacturingDate] = @manufacturingDate,
    [productionCost]    = @productionCost,
    [finalCost]         = @finalCost,
    [enable]            = @enable
WHERE [idProduct] = @idProduct

    -- Begin Return Select <- do not remove
SELECT [idProduct],
       [idCategory],
       [name],
       [description],
       [photo],
       [manufacturingDate],
       [productionCost],
       [finalCost],
       [enable]
FROM [dbo].[Product]
WHERE [idProduct] = @idProduct
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_product]
    END
GO
CREATE PROC [dbo].[sp_delete_product] @idProduct bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Product]
WHERE [idProduct] = @idProduct
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


GO

IF OBJECT_ID('[dbo].[sp_read_employee]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_employee]
    END
GO
CREATE PROC [dbo].[sp_read_employee] @idEmployee bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idEmployee], [idSubsidiary], [user], [photo]
FROM [dbo].[Employee]
WHERE ([idEmployee] = @idEmployee OR @idEmployee IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_employee]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_employee]
    END
GO
CREATE PROC [dbo].[sp_create_employee] @idEmployee bigint,
                                       @idSubsidiary smallint,
                                       @user bigint,
                                       @photo varbinary(MAX)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Employee] ([idEmployee], [idSubsidiary], [user], [photo])
SELECT @idEmployee, @idSubsidiary, @user, @photo

    -- Begin Return Select <- do not remove
SELECT [idEmployee], [idSubsidiary], [user], [photo]
FROM [dbo].[Employee]
WHERE [idEmployee] = @idEmployee
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_employee]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_employee]
    END
GO
CREATE PROC [dbo].[sp_update_employee] @idEmployee bigint,
                                       @idSubsidiary smallint,
                                       @user bigint,
                                       @photo varbinary(MAX)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Employee]
SET [idSubsidiary] = @idSubsidiary,
    [user]         = @user,
    [photo]        = @photo
WHERE [idEmployee] = @idEmployee

    -- Begin Return Select <- do not remove
SELECT [idEmployee], [idSubsidiary], [user], [photo]
FROM [dbo].[Employee]
WHERE [idEmployee] = @idEmployee
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_employee]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_employee]
    END
GO
CREATE PROC [dbo].[sp_delete_employee] @idEmployee bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Employee]
WHERE [idEmployee] = @idEmployee
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


GO

IF OBJECT_ID('[dbo].[sp_read_job]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_job]
    END
GO
CREATE PROC [dbo].[sp_read_job] @idJob tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idJob], [name], [description], [enable]
FROM [dbo].[Job]
WHERE ([idJob] = @idJob OR @idJob IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_insert_job]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_insert_job]
    END
GO
CREATE PROC [dbo].[sp_insert_job] @idJob tinyint,
                                  @name nvarchar(50),
                                  @description nvarchar(100),
                                  @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Job] ([idJob], [name], [description], [enable])
SELECT @idJob, @name, @description, @enable

    -- Begin Return Select <- do not remove
SELECT [idJob], [name], [description], [enable]
FROM [dbo].[Job]
WHERE [idJob] = @idJob
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_job]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_job]
    END
GO
CREATE PROC [dbo].[sp_update_job] @idJob tinyint,
                                  @name nvarchar(50),
                                  @description nvarchar(100),
                                  @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Job]
SET [name]        = @name,
    [description] = @description,
    [enable]      = @enable
WHERE [idJob] = @idJob

    -- Begin Return Select <- do not remove
SELECT [idJob], [name], [description], [enable]
FROM [dbo].[Job]
WHERE [idJob] = @idJob
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_job]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_job]
    END
GO
CREATE PROC [dbo].[sp_delete_job] @idJob tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Job]
WHERE [idJob] = @idJob
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------





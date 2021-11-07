-- USE [Subsidiary_Alajuela];
-- GO
-- USE [Subsidiary_Cartago];
-- GO
-- USE [Subsidiary_SanJose];
-- GO

IF OBJECT_ID('[dbo].[sp_read_comissionPurchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_comissionPurchase]
    END
GO
CREATE PROC [dbo].[sp_read_comissionPurchase] @idComission int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idComission], [idPurchase], [comission]
FROM [dbo].[ComissionPurchase]
WHERE ([idComission] = @idComission OR @idComission IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_comissionPurchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_comissionPurchase]
    END
GO
CREATE PROC [dbo].[sp_create_comissionPurchase] @idComission int,
                                                @idPurchase int,
                                                @comission decimal(9, 2)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[ComissionPurchase] ([idComission], [idPurchase], [comission])
SELECT @idComission, @idPurchase, @comission

    -- Begin Return Select <- do not remove
SELECT [idComission], [idPurchase], [comission]
FROM [dbo].[ComissionPurchase]
WHERE [idComission] = @idComission
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_comissionPurchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_comissionPurchase]
    END
GO
CREATE PROC [dbo].[sp_update_comissionPurchase] @idComission int,
                                                @idPurchase int,
                                                @comission decimal(9, 2)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[ComissionPurchase]
SET [idPurchase] = @idPurchase,
    [comission]  = @comission
WHERE [idComission] = @idComission

    -- Begin Return Select <- do not remove
SELECT [idComission], [idPurchase], [comission]
FROM [dbo].[ComissionPurchase]
WHERE [idComission] = @idComission
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_comissionPurchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_comissionPurchase]
    END
GO
CREATE PROC [dbo].[sp_delete_comissionPurchase] @idComission int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[ComissionPurchase]
WHERE [idComission] = @idComission
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_delivery]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_delivery]
    END
GO
CREATE PROC [dbo].[sp_read_delivery] @idDelivery int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idDelivery], [idPurchase], [idStatus], [shippingDate], [receptionDate], [active], [idScore]
FROM [dbo].[Delivery]
WHERE ([idDelivery] = @idDelivery OR @idDelivery IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_delivery]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_delivery]
    END
GO
CREATE PROC [dbo].[sp_create_delivery] @idDelivery int,
                                       @idPurchase int,
                                       @idStatus tinyint,
                                       @shippingDate datetime,
                                       @receptionDate datetime,
                                       @active bit,
                                       @idScore int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Delivery] ([idDelivery], [idPurchase], [idStatus], [shippingDate], [receptionDate], [active],
                              [idScore])
SELECT @idDelivery, @idPurchase, @idStatus, @shippingDate, @receptionDate, @active, @idScore

    -- Begin Return Select <- do not remove
SELECT [idDelivery], [idPurchase], [idStatus], [shippingDate], [receptionDate], [active], [idScore]
FROM [dbo].[Delivery]
WHERE [idDelivery] = @idDelivery
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_delivery]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_delivery]
    END
GO
CREATE PROC [dbo].[sp_update_delivery] @idDelivery int,
                                       @idPurchase int,
                                       @idStatus tinyint,
                                       @shippingDate datetime,
                                       @receptionDate datetime,
                                       @active bit,
                                       @idScore int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Delivery]
SET [idPurchase]    = @idPurchase,
    [idStatus]      = @idStatus,
    [shippingDate]  = @shippingDate,
    [receptionDate] = @receptionDate,
    [active]        = @active,
    [idScore]       = @idScore
WHERE [idDelivery] = @idDelivery

    -- Begin Return Select <- do not remove
SELECT [idDelivery], [idPurchase], [idStatus], [shippingDate], [receptionDate], [active], [idScore]
FROM [dbo].[Delivery]
WHERE [idDelivery] = @idDelivery
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_delivery]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_delivery]
    END
GO
CREATE PROC [dbo].[sp_delete_delivery] @idDelivery int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Delivery]
WHERE [idDelivery] = @idDelivery
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_deliveryStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_deliveryStatus]
    END
GO
CREATE PROC [dbo].[sp_read_deliveryStatus] @idDeliveryStatus tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idDeliveryStatus], [name], [description], [enable]
FROM [dbo].[DeliveryStatus]
WHERE ([idDeliveryStatus] = @idDeliveryStatus OR @idDeliveryStatus IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_deliveryStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_deliveryStatus]
    END
GO
CREATE PROC [dbo].[sp_create_deliveryStatus] @idDeliveryStatus tinyint,
                                             @name nvarchar(50),
                                             @description nvarchar(100),
                                             @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[DeliveryStatus] ([idDeliveryStatus], [name], [description], [enable])
SELECT @idDeliveryStatus, @name, @description, @enable

    -- Begin Return Select <- do not remove
SELECT [idDeliveryStatus], [name], [description], [enable]
FROM [dbo].[DeliveryStatus]
WHERE [idDeliveryStatus] = @idDeliveryStatus
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_deliveryStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_deliveryStatus]
    END
GO
CREATE PROC [dbo].[sp_update_deliveryStatus] @idDeliveryStatus tinyint,
                                             @name nvarchar(50),
                                             @description nvarchar(100),
                                             @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[DeliveryStatus]
SET [name]        = @name,
    [description] = @description,
    [enable]      = @enable
WHERE [idDeliveryStatus] = @idDeliveryStatus

    -- Begin Return Select <- do not remove
SELECT [idDeliveryStatus], [name], [description], [enable]
FROM [dbo].[DeliveryStatus]
WHERE [idDeliveryStatus] = @idDeliveryStatus
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_deliveryStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_deliveryStatus]
    END
GO
CREATE PROC [dbo].[sp_delete_deliveryStatus] @idDeliveryStatus tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[DeliveryStatus]
WHERE [idDeliveryStatus] = @idDeliveryStatus
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_employee]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_employee]
    END
GO
CREATE PROC [dbo].[sp_read_employee] @idEmployee int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idEmployee], [user], [photo]
FROM [dbo].[Employee]
WHERE ([idEmployee] = @idEmployee OR @idEmployee IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_employee]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_employee]
    END
GO
CREATE PROC [dbo].[sp_create_employee] @idEmployee int,
                                       @user bigint,
                                       @photo varbinary(MAX)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Employee] ([idEmployee], [user], [photo])
SELECT @idEmployee, @user, @photo

    -- Begin Return Select <- do not remove
SELECT [idEmployee], [user], [photo]
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
CREATE PROC [dbo].[sp_update_employee] @idEmployee int,
                                       @user bigint,
                                       @photo varbinary(MAX)
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Employee]
SET [user]  = @user,
    [photo] = @photo
WHERE [idEmployee] = @idEmployee

    -- Begin Return Select <- do not remove
SELECT [idEmployee], [user], [photo]
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
CREATE PROC [dbo].[sp_delete_employee] @idEmployee int
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

IF OBJECT_ID('[dbo].[sp_read_payment]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_payment]
    END
GO
CREATE PROC [dbo].[sp_read_payment] @idPayment int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idPayment], [date], [result], [transaction], [amount], [idPaymentStatus], [idPaymentMethod]
FROM [dbo].[Payment]
WHERE ([idPayment] = @idPayment OR @idPayment IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_payment]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_payment]
    END
GO
CREATE PROC [dbo].[sp_create_payment] @idPayment int,
                                      @date datetime,
                                      @result varchar(100),
                                      @transaction bigint,
                                      @amount money,
                                      @idPaymentStatus tinyint,
                                      @idPaymentMethod bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Payment] ([idPayment], [date], [result], [transaction], [amount], [idPaymentStatus],
                             [idPaymentMethod])
SELECT @idPayment, @date, @result, @transaction, @amount, @idPaymentStatus, @idPaymentMethod

    -- Begin Return Select <- do not remove
SELECT [idPayment], [date], [result], [transaction], [amount], [idPaymentStatus], [idPaymentMethod]
FROM [dbo].[Payment]
WHERE [idPayment] = @idPayment
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_payment]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_payment]
    END
GO
CREATE PROC [dbo].[sp_update_payment] @idPayment int,
                                      @date datetime,
                                      @result varchar(100),
                                      @transaction bigint,
                                      @amount money,
                                      @idPaymentStatus tinyint,
                                      @idPaymentMethod bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Payment]
SET [date]            = @date,
    [result]          = @result,
    [transaction]     = @transaction,
    [amount]          = @amount,
    [idPaymentStatus] = @idPaymentStatus,
    [idPaymentMethod] = @idPaymentMethod
WHERE [idPayment] = @idPayment

    -- Begin Return Select <- do not remove
SELECT [idPayment], [date], [result], [transaction], [amount], [idPaymentStatus], [idPaymentMethod]
FROM [dbo].[Payment]
WHERE [idPayment] = @idPayment
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_payment]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_payment]
    END
GO
CREATE PROC [dbo].[sp_delete_payment] @idPayment int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Payment]
WHERE [idPayment] = @idPayment
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_paymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_paymentMethod]
    END
GO
CREATE PROC [dbo].[sp_read_paymentMethod] @idPaymentMethod tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idPaymentMethod], [name], [detail], [enable]
FROM [dbo].[PaymentMethod]
WHERE ([idPaymentMethod] = @idPaymentMethod OR @idPaymentMethod IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_paymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_paymentMethod]
    END
GO
CREATE PROC [dbo].[sp_create_paymentMethod] @idPaymentMethod tinyint,
                                            @name nvarchar(50),
                                            @detail nvarchar(MAX),
                                            @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[PaymentMethod] ([idPaymentMethod], [name], [detail], [enable])
SELECT @idPaymentMethod, @name, @detail, @enable

    -- Begin Return Select <- do not remove
SELECT [idPaymentMethod], [name], [detail], [enable]
FROM [dbo].[PaymentMethod]
WHERE [idPaymentMethod] = @idPaymentMethod
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_paymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_paymentMethod]
    END
GO
CREATE PROC [dbo].[sp_update_paymentMethod] @idPaymentMethod tinyint,
                                            @name nvarchar(50),
                                            @detail nvarchar(MAX),
                                            @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[PaymentMethod]
SET [name]   = @name,
    [detail] = @detail,
    [enable] = @enable
WHERE [idPaymentMethod] = @idPaymentMethod

    -- Begin Return Select <- do not remove
SELECT [idPaymentMethod], [name], [detail], [enable]
FROM [dbo].[PaymentMethod]
WHERE [idPaymentMethod] = @idPaymentMethod
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_paymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_paymentMethod]
    END
GO
CREATE PROC [dbo].[sp_delete_paymentMethod] @idPaymentMethod tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[PaymentMethod]
WHERE [idPaymentMethod] = @idPaymentMethod
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_paymentStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_paymentStatus]
    END
GO
CREATE PROC [dbo].[sp_read_paymentStatus] @idPaymentStatus tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idPaymentStatus], [name], [description], [enable]
FROM [dbo].[PaymentStatus]
WHERE ([idPaymentStatus] = @idPaymentStatus OR @idPaymentStatus IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_paymentStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_paymentStatus]
    END
GO
CREATE PROC [dbo].[sp_create_paymentStatus] @idPaymentStatus tinyint,
                                            @name nvarchar(50),
                                            @description nvarchar(100),
                                            @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[PaymentStatus] ([idPaymentStatus], [name], [description], [enable])
SELECT @idPaymentStatus, @name, @description, @enable

    -- Begin Return Select <- do not remove
SELECT [idPaymentStatus], [name], [description], [enable]
FROM [dbo].[PaymentStatus]
WHERE [idPaymentStatus] = @idPaymentStatus
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_paymentStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_paymentStatus]
    END
GO
CREATE PROC [dbo].[sp_update_paymentStatus] @idPaymentStatus tinyint,
                                            @name nvarchar(50),
                                            @description nvarchar(100),
                                            @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[PaymentStatus]
SET [name]        = @name,
    [description] = @description,
    [enable]      = @enable
WHERE [idPaymentStatus] = @idPaymentStatus

    -- Begin Return Select <- do not remove
SELECT [idPaymentStatus], [name], [description], [enable]
FROM [dbo].[PaymentStatus]
WHERE [idPaymentStatus] = @idPaymentStatus
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_paymentStatus]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_paymentStatus]
    END
GO
CREATE PROC [dbo].[sp_delete_paymentStatus] @idPaymentStatus tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[PaymentStatus]
WHERE [idPaymentStatus] = @idPaymentStatus
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_Product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_Product]
    END
GO
CREATE PROC [dbo].[sp_read_Product] @idProduct bigint
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
IF OBJECT_ID('[dbo].[sp_create_Product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_Product]
    END
GO
CREATE PROC [dbo].[sp_create_Product] @idProduct bigint,
                                      @idCategory int,
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
IF OBJECT_ID('[dbo].[sp_update_Product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_Product]
    END
GO
CREATE PROC [dbo].[sp_update_Product] @idProduct bigint,
                                      @idCategory int,
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
IF OBJECT_ID('[dbo].[sp_delete_Product]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_Product]
    END
GO
CREATE PROC [dbo].[sp_delete_Product] @idProduct bigint
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

IF OBJECT_ID('[dbo].[sp_read_purchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_purchase]
    END
GO
CREATE PROC [dbo].[sp_read_purchase] @idPurchase int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idPurchase], [idUser], [date], [idEmployee], [idPayment], [tax], [detail]
FROM [dbo].[Purchase]
WHERE ([idPurchase] = @idPurchase OR @idPurchase IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_purchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_purchase]
    END
GO
CREATE PROC [dbo].[sp_create_purchase] @idPurchase int,
                                       @idUser bigint,
                                       @date datetime,
                                       @idEmployee int = NULL,
                                       @idPayment int,
                                       @tax money,
                                       @detail varchar(100) = NULL
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Purchase] ([idPurchase], [idUser], [date], [idEmployee], [idPayment], [tax], [detail])
SELECT @idPurchase, @idUser, @date, @idEmployee, @idPayment, @tax, @detail

    -- Begin Return Select <- do not remove
SELECT [idPurchase], [idUser], [date], [idEmployee], [idPayment], [tax], [detail]
FROM [dbo].[Purchase]
WHERE [idPurchase] = @idPurchase
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_purchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_purchase]
    END
GO
CREATE PROC [dbo].[sp_update_purchase] @idPurchase int,
                                       @idUser bigint,
                                       @date datetime,
                                       @idEmployee int = NULL,
                                       @idPayment int,
                                       @tax money,
                                       @detail varchar(100) = NULL
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Purchase]
SET [idUser]     = @idUser,
    [date]       = @date,
    [idEmployee] = @idEmployee,
    [idPayment]  = @idPayment,
    [tax]        = @tax,
    [detail]     = @detail
WHERE [idPurchase] = @idPurchase

    -- Begin Return Select <- do not remove
SELECT [idPurchase], [idUser], [date], [idEmployee], [idPayment], [tax], [detail]
FROM [dbo].[Purchase]
WHERE [idPurchase] = @idPurchase
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_purchase]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_purchase]
    END
GO
CREATE PROC [dbo].[sp_delete_purchase] @idPurchase int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Purchase]
WHERE [idPurchase] = @idPurchase
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_purchaseProduct]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_purchaseProduct]
    END
GO
CREATE PROC [dbo].[sp_read_purchaseProduct] @idPurchaseProduct int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idPurchaseProduct], [idProduct], [idPurchase], [quantity], [subtotal]
FROM [dbo].[PurchaseProduct]
WHERE ([idPurchaseProduct] = @idPurchaseProduct OR @idPurchaseProduct IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_purchaseProduct]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_purchaseProduct]
    END
GO
CREATE PROC [dbo].[sp_create_purchaseProduct] @idPurchaseProduct int,
                                              @idProduct bigint,
                                              @idPurchase int,
                                              @quantity int,
                                              @subtotal money
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[PurchaseProduct] ([idPurchaseProduct], [idProduct], [idPurchase], [quantity], [subtotal])
SELECT @idPurchaseProduct, @idProduct, @idPurchase, @quantity, @subtotal

    -- Begin Return Select <- do not remove
SELECT [idPurchaseProduct], [idProduct], [idPurchase], [quantity], [subtotal]
FROM [dbo].[PurchaseProduct]
WHERE [idPurchaseProduct] = @idPurchaseProduct
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_purchaseProduct]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_purchaseProduct]
    END
GO
CREATE PROC [dbo].[sp_update_purchaseProduct] @idPurchaseProduct int,
                                              @idProduct bigint,
                                              @idPurchase int,
                                              @quantity int,
                                              @subtotal money
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[PurchaseProduct]
SET [idProduct]  = @idProduct,
    [idPurchase] = @idPurchase,
    [quantity]   = @quantity,
    [subtotal]   = @subtotal
WHERE [idPurchaseProduct] = @idPurchaseProduct

    -- Begin Return Select <- do not remove
SELECT [idPurchaseProduct], [idProduct], [idPurchase], [quantity], [subtotal]
FROM [dbo].[PurchaseProduct]
WHERE [idPurchaseProduct] = @idPurchaseProduct
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_purchaseProduct]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_purchaseProduct]
    END
GO
CREATE PROC [dbo].[sp_delete_purchaseProduct] @idPurchaseProduct int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[PurchaseProduct]
WHERE [idPurchaseProduct] = @idPurchaseProduct
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_sale]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_sale]
    END
GO
CREATE PROC [dbo].[sp_read_sale] @idSale int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idSale], [idProduct], [salePercentage], [expirationDate], [description], [enable]
FROM [dbo].[Sale]
WHERE ([idSale] = @idSale OR @idSale IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_sale]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_sale]
    END
GO
CREATE PROC [dbo].[sp_create_sale] @idSale int,
                                   @idProduct bigint,
                                   @salePercentage decimal(9, 2),
                                   @expirationDate date,
                                   @description varchar(100),
                                   @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Sale] ([idSale], [idProduct], [salePercentage], [expirationDate], [description], [enable])
SELECT @idSale, @idProduct, @salePercentage, @expirationDate, @description, @enable

    -- Begin Return Select <- do not remove
SELECT [idSale], [idProduct], [salePercentage], [expirationDate], [description], [enable]
FROM [dbo].[Sale]
WHERE [idSale] = @idSale
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_sale]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_sale]
    END
GO
CREATE PROC [dbo].[sp_update_sale] @idSale int,
                                   @idProduct bigint,
                                   @salePercentage decimal(9, 2),
                                   @expirationDate date,
                                   @description varchar(100),
                                   @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Sale]
SET [idProduct]      = @idProduct,
    [salePercentage] = @salePercentage,
    [expirationDate] = @expirationDate,
    [description]    = @description,
    [enable]         = @enable
WHERE [idSale] = @idSale

    -- Begin Return Select <- do not remove
SELECT [idSale], [idProduct], [salePercentage], [expirationDate], [description], [enable]
FROM [dbo].[Sale]
WHERE [idSale] = @idSale
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_sale]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_sale]
    END
GO
CREATE PROC [dbo].[sp_delete_sale] @idSale int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Sale]
WHERE [idSale] = @idSale
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_score]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_score]
    END
GO
CREATE PROC [dbo].[sp_read_score] @idScore int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idScore], [comment], [value]
FROM [dbo].[Score]
WHERE ([idScore] = @idScore OR @idScore IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_score]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_score]
    END
GO
CREATE PROC [dbo].[sp_create_score] @idScore int,
                                    @comment varchar(100),
                                    @value tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Score] ([idScore], [comment], [value])
SELECT @idScore, @comment, @value

    -- Begin Return Select <- do not remove
SELECT [idScore], [comment], [value]
FROM [dbo].[Score]
WHERE [idScore] = @idScore
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_score]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_score]
    END
GO
CREATE PROC [dbo].[sp_update_score] @idScore int,
                                    @comment varchar(100),
                                    @value tinyint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Score]
SET [comment] = @comment,
    [value]   = @value
WHERE [idScore] = @idScore

    -- Begin Return Select <- do not remove
SELECT [idScore], [comment], [value]
FROM [dbo].[Score]
WHERE [idScore] = @idScore
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_score]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_score]
    END
GO
CREATE PROC [dbo].[sp_delete_score] @idScore int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[Score]
WHERE [idScore] = @idScore
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

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

SELECT [idStock], [idProduct], [quantity]
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
                                    @quantity int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[Stock] ([idStock], [idProduct], [quantity])
SELECT @idStock, @idProduct, @quantity

    -- Begin Return Select <- do not remove
SELECT [idStock], [idProduct], [quantity]
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
                                    @quantity int
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[Stock]
SET [idProduct] = @idProduct,
    [quantity]  = @quantity
WHERE [idStock] = @idStock

    -- Begin Return Select <- do not remove
SELECT [idStock], [idProduct], [quantity]
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

IF OBJECT_ID('[dbo].[sp_read_user]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_user]
    END
GO
CREATE PROC [dbo].[sp_read_user] @idUser bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idUser], [name], [lastname], [address]
FROM [dbo].[User]
WHERE ([idUser] = @idUser OR @idUser IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_user]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_user]
    END
GO
CREATE PROC [dbo].[sp_create_user] @idUser bigint,
                                   @name nvarchar(50),
                                   @lastname nvarchar(50),
                                   @address geography
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[User] ([idUser], [name], [lastname], [address])
SELECT @idUser, @name, @lastname, @address

    -- Begin Return Select <- do not remove
SELECT [idUser], [name], [lastname], [address]
FROM [dbo].[User]
WHERE [idUser] = @idUser
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_user]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_user]
    END
GO
CREATE PROC [dbo].[sp_update_user] @idUser bigint,
                                   @name nvarchar(50),
                                   @lastname nvarchar(50),
                                   @address geography
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[User]
SET [name]     = @name,
    [lastname] = @lastname,
    [address]  = @address
WHERE [idUser] = @idUser

    -- Begin Return Select <- do not remove
SELECT [idUser], [name], [lastname], [address]
FROM [dbo].[User]
WHERE [idUser] = @idUser
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_user]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_user]
    END
GO
CREATE PROC [dbo].[sp_delete_user] @idUser bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[User]
WHERE [idUser] = @idUser
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

IF OBJECT_ID('[dbo].[sp_read_userPaymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_read_userPaymentMethod]
    END
GO
CREATE PROC [dbo].[sp_read_userPaymentMethod] @idUserPayment bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

SELECT [idUserPayment], [idPaymentMethod], [detail], [enable]
FROM [dbo].[UserPaymentMethod]
WHERE ([idUserPayment] = @idUserPayment OR @idUserPayment IS NULL)
    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_create_userPaymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_create_userPaymentMethod]
    END
GO
CREATE PROC [dbo].[sp_create_userPaymentMethod] @idUserPayment bigint,
                                                @idPaymentMethod tinyint,
                                                @detail nvarchar(MAX),
                                                @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

INSERT INTO [dbo].[UserPaymentMethod] ([idUserPayment], [idPaymentMethod], [detail], [enable])
SELECT @idUserPayment, @idPaymentMethod, @detail, @enable

    -- Begin Return Select <- do not remove
SELECT [idUserPayment], [idPaymentMethod], [detail], [enable]
FROM [dbo].[UserPaymentMethod]
WHERE [idUserPayment] = @idUserPayment
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_update_userPaymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_update_userPaymentMethod]
    END
GO
CREATE PROC [dbo].[sp_update_userPaymentMethod] @idUserPayment bigint,
                                                @idPaymentMethod tinyint,
                                                @detail nvarchar(MAX),
                                                @enable bit
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

UPDATE [dbo].[UserPaymentMethod]
SET [idPaymentMethod] = @idPaymentMethod,
    [detail]          = @detail,
    [enable]          = @enable
WHERE [idUserPayment] = @idUserPayment

    -- Begin Return Select <- do not remove
SELECT [idUserPayment], [idPaymentMethod], [detail], [enable]
FROM [dbo].[UserPaymentMethod]
WHERE [idUserPayment] = @idUserPayment
    -- End Return Select <- do not remove

    COMMIT
GO
IF OBJECT_ID('[dbo].[sp_delete_userPaymentMethod]') IS NOT NULL
    BEGIN
        DROP PROC [dbo].[sp_delete_userPaymentMethod]
    END
GO
CREATE PROC [dbo].[sp_delete_userPaymentMethod] @idUserPayment bigint
AS
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRAN

DELETE
FROM [dbo].[UserPaymentMethod]
WHERE [idUserPayment] = @idUserPayment
    COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


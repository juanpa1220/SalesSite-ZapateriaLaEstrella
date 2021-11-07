-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[User]

CREATE TABLE [dbo].[User]
(
    [idUser]   bigint       NOT NULL,
    [name]     nvarchar(50) NOT NULL,
    [lastname] nvarchar(50) NOT NULL,
    [address]  geography    NOT NULL,


    CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED ([idUser] ASC)
);
GO


-- ************************************** [dbo].[Score]

CREATE TABLE [dbo].[Score]
(
    [idScore] int          NOT NULL,
    [comment] varchar(100) NOT NULL,
    [value]   tinyint      NOT NULL,


    CONSTRAINT [PK_score] PRIMARY KEY CLUSTERED ([idScore] ASC)
);
GO


-- ************************************** [dbo].[Product]

CREATE TABLE [dbo].[Product]
(
    [idProduct]         bigint        NOT NULL,
    [idCategory]        int           NOT NULL,
    [name]              nvarchar(100) NOT NULL,
    [description]       nvarchar(300) NOT NULL,
    [photo]             nvarchar(200) NOT NULL,
    [manufacturingDate] date          NOT NULL,
    [productionCost]    money         NOT NULL,
    [finalCost]         money         NOT NULL,
    [enable]            bit           NOT NULL,


    CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED ([idProduct] ASC)
);
GO


-- ************************************** [dbo].[PaymentStatus]

CREATE TABLE [dbo].[PaymentStatus]
(
    [idPaymentStatus] tinyint       NOT NULL,
    [name]            nvarchar(50)  NOT NULL,
    [description]     nvarchar(100) NOT NULL,
    [enable]          bit           NOT NULL,


    CONSTRAINT [PK_paymentstate] PRIMARY KEY CLUSTERED ([idPaymentStatus] ASC)
);
GO


-- ************************************** [dbo].[PaymentMethod]

CREATE TABLE [dbo].[PaymentMethod]
(
    [idPaymentMethod] tinyint       NOT NULL,
    [name]            nvarchar(50)  NOT NULL,
    [detail]          nvarchar(max) NOT NULL,
    [enable]          bit           NOT NULL,


    CONSTRAINT [PK_paymentmethod] PRIMARY KEY CLUSTERED ([idPaymentMethod] ASC)
);
GO


-- ************************************** [dbo].[Employee]

CREATE TABLE [dbo].[Employee]
(
    [idEmployee] int            NOT NULL,
    [user]       bigint         NOT NULL,
    [photo]      varbinary(max) NOT NULL,


    CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED ([idEmployee] ASC)
);
GO


-- ************************************** [dbo].[DeliveryStatus]

CREATE TABLE [dbo].[DeliveryStatus]
(
    [idDeliveryStatus] tinyint       NOT NULL,
    [name]             nvarchar(50)  NOT NULL,
    [description]      nvarchar(100) NOT NULL,
    [enable]           bit           NOT NULL,


    CONSTRAINT [PK_deliverystatus] PRIMARY KEY CLUSTERED ([idDeliveryStatus] ASC)
);
GO


-- ************************************** [dbo].[UserPaymentMethod]

CREATE TABLE [dbo].[UserPaymentMethod]
(
    [idUserPayment]   bigint        NOT NULL,
    [idPaymentMethod] tinyint       NOT NULL,
    [detail]          nvarchar(max) NOT NULL,
    [enable]          bit           NOT NULL,


    CONSTRAINT [PK_userpaymentmethod] PRIMARY KEY CLUSTERED ([idUserPayment] ASC),
    CONSTRAINT [FK_315] FOREIGN KEY ([idPaymentMethod]) REFERENCES [dbo].[PaymentMethod] ([idPaymentMethod])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_315] ON [dbo].[UserPaymentMethod]
    (
     [idPaymentMethod] ASC
        )

GO


-- ************************************** [dbo].[Stock]

CREATE TABLE [dbo].[Stock]
(
    [idStock]   int    NOT NULL,
    [idProduct] bigint NOT NULL,
    [quantity]  int    NOT NULL,


    CONSTRAINT [PK_stock] PRIMARY KEY CLUSTERED ([idStock] ASC),
    CONSTRAINT [FK_446] FOREIGN KEY ([idProduct]) REFERENCES [dbo].[Product] ([idProduct])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_446] ON [dbo].[Stock]
    (
     [idProduct] ASC
        )

GO


-- ************************************** [dbo].[Sale]

CREATE TABLE [dbo].[Sale]
(
    [idSale]         int           NOT NULL,
    [idProduct]      bigint        NOT NULL,
    [salePercentage] decimal(9, 2) NOT NULL,
    [expirationDate] date          NOT NULL,
    [description]    varchar(100)  NOT NULL,
    [enable]         bit           NOT NULL,


    CONSTRAINT [PK_sale] PRIMARY KEY CLUSTERED ([idSale] ASC),
    CONSTRAINT [FK_431] FOREIGN KEY ([idProduct]) REFERENCES [dbo].[Product] ([idProduct])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_431] ON [dbo].[Sale]
    (
     [idProduct] ASC
        )

GO


-- ************************************** [dbo].[Payment]

CREATE TABLE [dbo].[Payment]
(
    [idPayment]       int          NOT NULL,
    [date]            datetime     NOT NULL,
    [result]          varchar(100) NOT NULL,
    [transaction]     bigint       NOT NULL,
    [amount]          money        NOT NULL,
    [idPaymentStatus] tinyint      NOT NULL,
    [idPaymentMethod] bigint       NOT NULL,


    CONSTRAINT [PK_payment] PRIMARY KEY CLUSTERED ([idPayment] ASC),
    CONSTRAINT [FK_251] FOREIGN KEY ([idPaymentStatus]) REFERENCES [dbo].[PaymentStatus] ([idPaymentStatus]),
    CONSTRAINT [FK_352] FOREIGN KEY ([idPaymentMethod]) REFERENCES [dbo].[UserPaymentMethod] ([idUserPayment])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_251] ON [dbo].[Payment]
    (
     [idPaymentStatus] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_352] ON [dbo].[Payment]
    (
     [idPaymentMethod] ASC
        )

GO


-- ************************************** [dbo].[Purchase]

CREATE TABLE [dbo].[Purchase]
(
    [idPurchase] int           NOT NULL,
    [idUser]     bigint        NOT NULL,
    [date]       datetime      NOT NULL,
    [idEmployee] int           NULL,
    [idPayment]  int           NOT NULL,
    [tax]        money         NOT NULL,
    [detail]     varchar(100)  NULL,
    discount     decimal(9, 2) NULL,


    CONSTRAINT [PK_purchase] PRIMARY KEY CLUSTERED ([idPurchase] ASC),
    CONSTRAINT [FK_349] FOREIGN KEY ([idEmployee]) REFERENCES [dbo].[Employee] ([idEmployee]),
    CONSTRAINT [FK_362] FOREIGN KEY ([idUser]) REFERENCES [dbo].[User] ([idUser]),
    CONSTRAINT [FK_398] FOREIGN KEY ([idPayment]) REFERENCES [dbo].[Payment] ([idPayment])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_349] ON [dbo].[Purchase]
    (
     [idEmployee] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_362] ON [dbo].[Purchase]
    (
     [idUser] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_398] ON [dbo].[Purchase]
    (
     [idPayment] ASC
        )

GO


-- ************************************** [dbo].[PurchaseProduct]

CREATE TABLE [dbo].[PurchaseProduct]
(
    [idPurchaseProduct] int    NOT NULL,
    [idProduct]         bigint NOT NULL,
    [idPurchase]        int    NOT NULL,
    [quantity]          int    NOT NULL,
    [subtotal]          money  NOT NULL,


    CONSTRAINT [PK_purchaseproduct] PRIMARY KEY CLUSTERED ([idPurchaseProduct] ASC),
    CONSTRAINT [FK_210] FOREIGN KEY ([idPurchase]) REFERENCES [dbo].[Purchase] ([idPurchase]),
    CONSTRAINT [FK_339] FOREIGN KEY ([idProduct]) REFERENCES [dbo].[Product] ([idProduct])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_210] ON [dbo].[PurchaseProduct]
    (
     [idPurchase] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_339] ON [dbo].[PurchaseProduct]
    (
     [idProduct] ASC
        )

GO


-- ************************************** [dbo].[Delivery]

CREATE TABLE [dbo].[Delivery]
(
    [idDelivery]    int      NOT NULL,
    [idPurchase]    int      NOT NULL,
    [idStatus]      tinyint  NOT NULL,
    [shippingDate]  datetime NOT NULL,
    [receptionDate] datetime NOT NULL,
    [active]        bit      NOT NULL,
    [idScore]       int      NOT NULL,


    CONSTRAINT [PK_delivery] PRIMARY KEY CLUSTERED ([idDelivery] ASC),
    CONSTRAINT [FK_205] FOREIGN KEY ([idPurchase]) REFERENCES [dbo].[Purchase] ([idPurchase]),
    CONSTRAINT [FK_299] FOREIGN KEY ([idStatus]) REFERENCES [dbo].[DeliveryStatus] ([idDeliveryStatus]),
    CONSTRAINT [FK_421] FOREIGN KEY ([idScore]) REFERENCES [dbo].[Score] ([idScore])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_205] ON [dbo].[Delivery]
    (
     [idPurchase] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_299] ON [dbo].[Delivery]
    (
     [idStatus] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_421] ON [dbo].[Delivery]
    (
     [idScore] ASC
        )

GO


-- ************************************** [dbo].[ComissionPurchase]

CREATE TABLE [dbo].[ComissionPurchase]
(
    [idComission] int           NOT NULL,
    [idPurchase]  int           NOT NULL,
    [comission]   decimal(9, 2) NOT NULL,


    CONSTRAINT [PK_commissionpurchase] PRIMARY KEY CLUSTERED ([idComission] ASC),
    CONSTRAINT [FK_457] FOREIGN KEY ([idPurchase]) REFERENCES [dbo].[Purchase] ([idPurchase])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_457] ON [dbo].[ComissionPurchase]
    (
     [idPurchase] ASC
        )

GO








-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Subsidiary]

CREATE TABLE [dbo].[Subsidiary]
(
    [idSubsidiary] smallint      NOT NULL,
    [name]         nvarchar(100) NOT NULL,
    [address]      geography     NOT NULL,
    [provincia]    varchar(50)   NOT NULL,


    CONSTRAINT [PK_Subsidiary] PRIMARY KEY CLUSTERED ([idSubsidiary] ASC)
);
GO


-- ************************************** [dbo].[Job]

CREATE TABLE [dbo].[Job]
(
    [idJob]       tinyint       NOT NULL,
    [name]        nvarchar(50)  NOT NULL,
    [description] nvarchar(100) NOT NULL,
    [enable]      bit           NOT NULL,


    CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED ([idJob] ASC)
);
GO


-- ************************************** [dbo].[ContactType]

CREATE TABLE [dbo].[ContactType]
(
    [idContactType] tinyint       NOT NULL,
    [name]          nvarchar(50)  NOT NULL,
    [description]   nvarchar(100) NOT NULL,
    [enable]        bit           NOT NULL,


    CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED ([idContactType] ASC)
);
GO


-- ************************************** [dbo].[Category]

CREATE TABLE [dbo].[Category]
(
    [idCategory]  tinyint       NOT NULL,
    [name]        nvarchar(50)  NOT NULL,
    [description] nvarchar(250) NOT NULL,
    [enable]      bit           NOT NULL,


    CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED ([idCategory] ASC)
);
GO


-- ************************************** [dbo].[SubsidiaryContact]

CREATE TABLE [dbo].[SubsidiaryContact]
(
    [idSubsidiaryContact] smallint     NOT NULL,
    [idSubsidiary]        smallint     NOT NULL,
    [idTypeContact]       tinyint      NOT NULL,
    [contact]             nvarchar(50) NOT NULL,
    [enable]              bit          NOT NULL,


    CONSTRAINT [PK_SubsidiaryContact] PRIMARY KEY CLUSTERED ([idSubsidiaryContact] ASC),
    CONSTRAINT [FK_159] FOREIGN KEY ([idSubsidiary]) REFERENCES [dbo].[Subsidiary] ([idSubsidiary]),
    CONSTRAINT [FK_162] FOREIGN KEY ([idTypeContact]) REFERENCES [dbo].[ContactType] ([idContactType])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_159] ON [dbo].[SubsidiaryContact]
    (
     [idSubsidiary] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_162] ON [dbo].[SubsidiaryContact]
    (
     [idTypeContact] ASC
        )

GO


-- ************************************** [dbo].[Product]

CREATE TABLE [dbo].[Product]
(
    [idProduct]         bigint        NOT NULL,
    [idCategory]        tinyint       NOT NULL,
    [name]              nvarchar(100) NOT NULL,
    [description]       nvarchar(300) NOT NULL,
    [photo]             nvarchar(200) NOT NULL,
    [manufacturingDate] date          NOT NULL,
    [productionCost]    money         NOT NULL,
    [finalCost]         money         NOT NULL,
    [enable]            bit           NOT NULL,


    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([idProduct] ASC),
    CONSTRAINT [FK_262] FOREIGN KEY ([idCategory]) REFERENCES [dbo].[Category] ([idCategory])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_262] ON [dbo].[Product]
    (
     [idCategory] ASC
        )

GO


-- ************************************** [dbo].[Employee]

CREATE TABLE [dbo].[Employee]
(
    [idEmployee]   bigint       NOT NULL,
    [idSubsidiary] smallint     NOT NULL,
    [user]         bigint       NOT NULL,
    [photo]        varchar(100) NOT NULL,


    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([idEmployee] ASC),
    CONSTRAINT [FK_223] FOREIGN KEY ([idSubsidiary]) REFERENCES [dbo].[Subsidiary] ([idSubsidiary])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_223] ON [dbo].[Employee]
    (
     [idSubsidiary] ASC
        )

GO


-- ************************************** [dbo].[Stock]

CREATE TABLE [dbo].[Stock]
(
    [idStock]      int      NOT NULL,
    [idProduct]    bigint   NOT NULL,
    [idSubsidiary] smallint NOT NULL,
    [quantity]     int      NOT NULL,


    CONSTRAINT [PK_productssubsidiary] PRIMARY KEY CLUSTERED ([idStock] ASC),
    CONSTRAINT [FK_415] FOREIGN KEY ([idProduct]) REFERENCES [dbo].[Product] ([idProduct]),
    CONSTRAINT [FK_418] FOREIGN KEY ([idSubsidiary]) REFERENCES [dbo].[Subsidiary] ([idSubsidiary])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_415] ON [dbo].[Stock]
    (
     [idProduct] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_418] ON [dbo].[Stock]
    (
     [idSubsidiary] ASC
        )

GO


-- ************************************** [dbo].[Contract]

CREATE TABLE [dbo].[Contract]
(
    [idContract]    int          NOT NULL,
    [idEmployee]    bigint       NOT NULL,
    [idJob]         tinyint      NOT NULL,
    [file]          varchar(max) NOT NULL,
    [baseSalary]    money        NOT NULL,
    [admissionDate] date         NOT NULL,
    [paymentDate]   date         NOT NULL,


    CONSTRAINT [PK_e] PRIMARY KEY CLUSTERED ([idContract] ASC),
    CONSTRAINT [FK_286] FOREIGN KEY ([idEmployee]) REFERENCES [dbo].[Employee] ([idEmployee]),
    CONSTRAINT [FK_381] FOREIGN KEY ([idJob]) REFERENCES [dbo].[Job] ([idJob])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_286] ON [dbo].[Contract]
    (
     [idEmployee] ASC
        )

GO

CREATE NONCLUSTERED INDEX [fkIdx_381] ON [dbo].[Contract]
    (
     [idJob] ASC
        )

GO








USE `customer_service`;
-- ************************************** `user`

CREATE TABLE `user`
(
    `idUser`            bigint      NOT NULL,
    `identity_card`     varchar(15) NULL,
    `name`              varchar(50) NOT NULL,
    `lastname`          varchar(50) NOT NULL,
    `birthdate`         date        NOT NULL,
    `registration_date` date        NOT NULL,
    `address`           geometry    NOT NULL,
    `enable`            bit         NOT NULL,
    `active`            bit         NOT NULL,

    PRIMARY KEY (`idUser`)
);


-- ************************************** `role`

CREATE TABLE `role`
(
    `idRole`      tinyint     NOT NULL,
    `name`        varchar(50) NOT NULL,
    `description` varchar(50) NOT NULL,
    `enable`      bit         NOT NULL,

    PRIMARY KEY (`idRole`)
);


-- ************************************** `permission`

CREATE TABLE `permission`
(
    `idPermission` tinyint      NOT NULL,
    `name`         varchar(50)  NOT NULL,
    `description`  varchar(100) NOT NULL,
    `enable`       bit          NOT NULL,

    PRIMARY KEY (`idPermission`)
);


-- ************************************** `contact_type`

CREATE TABLE `contact_type`
(
    `idContactType` tinyint      NOT NULL,
    `name`          varchar(50)  NOT NULL,
    `description`   varchar(100) NOT NULL,
    `enable`        bit          NOT NULL,

    PRIMARY KEY (`idContactType`)
);


-- ************************************** `account_type`

CREATE TABLE `account_type`
(
    `idAccountType` tinyint      NOT NULL,
    `name`          varchar(50)  NOT NULL,
    `description`   varchar(100) NOT NULL,
    `enable`        bit          NOT NULL,

    PRIMARY KEY (`idAccountType`)
);


-- ************************************** `user_contact`

CREATE TABLE `user_contact`
(
    `idUserContact` bigint      NOT NULL,
    `idUser`        bigint      NOT NULL,
    `idType`        tinyint     NOT NULL,
    `value`         varchar(50) NOT NULL,
    `enable`        bit         NOT NULL,

    PRIMARY KEY (`idUserContact`),
    KEY `fkIdx_67` (`idType`),
    CONSTRAINT `FK_67` FOREIGN KEY `fkIdx_67` (`idType`) REFERENCES `contact_type` (`idContactType`),
    KEY `fkIdx_70` (`idUser`),
    CONSTRAINT `FK_70` FOREIGN KEY `fkIdx_70` (`idUser`) REFERENCES `user` (`idUser`)
);


-- ************************************** `role_permission`

CREATE TABLE `role_permission`
(
    `idPermission`     tinyint NOT NULL,
    `idRolePermission` int     NOT NULL,
    `idRole`           tinyint NOT NULL,
    `enable`           bit     NOT NULL,

    PRIMARY KEY (`idRolePermission`),
    KEY `fkIdx_82` (`idPermission`),
    CONSTRAINT `FK_82` FOREIGN KEY `fkIdx_82` (`idPermission`) REFERENCES `permission` (`idPermission`),
    KEY `fkIdx_91` (`idRole`),
    CONSTRAINT `FK_91` FOREIGN KEY `fkIdx_91` (`idRole`) REFERENCES `role` (`idRole`)
);


-- ************************************** `discount_coupon`

CREATE TABLE `discount_coupon`
(
    `idDiscountCoupon` varchar(50)   NOT NULL,
    `idUser`           bigint        NOT NULL,
    `value`            decimal(9, 2) NOT NULL,
    `valid_until`      date          NOT NULL,
    `active`           bit           NOT NULL,

    PRIMARY KEY (`idDiscountCoupon`),
    KEY `fkIdx_44` (`idUser`),
    CONSTRAINT `FK_44` FOREIGN KEY `fkIdx_44` (`idUser`) REFERENCES `user` (`idUser`)
);


-- ************************************** `account`

CREATE TABLE `account`
(
    `idAccount` bigint        NOT NULL,
    `idUser`    bigint        NOT NULL,
    `idRole`    tinyint       NOT NULL,
    `idType`    tinyint       NOT NULL,
    `email`     varchar(50)   NOT NULL,
    `username`  varchar(50)   NOT NULL,
    `password`  varbinary(50) NOT NULL,
    `enable`    bit           NOT NULL,

    PRIMARY KEY (`idAccount`),
    KEY `fkIdx_28` (`idType`),
    CONSTRAINT `FK_28` FOREIGN KEY `fkIdx_28` (`idType`) REFERENCES `account_type` (`idAccountType`),
    KEY `fkIdx_41` (`idUser`),
    CONSTRAINT `FK_41` FOREIGN KEY `fkIdx_41` (`idUser`) REFERENCES `user` (`idUser`),
    KEY `fkIdx_94` (`idRole`),
    CONSTRAINT `FK_94` FOREIGN KEY `fkIdx_94` (`idRole`) REFERENCES `role` (`idRole`)
);


CREATE TABLE `city`
(
    `idCity`      int         NOT NULL,
    `province`    varchar(50) NOT NULL,
    `city`        varchar(50) NOT NULL,
    `coordinates` geometry    NOT NULL,

    PRIMARY KEY (`idCity`)
);
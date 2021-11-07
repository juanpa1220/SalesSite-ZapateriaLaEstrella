USE `customer_service`;

-----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_create_account`(IN idAccount bigint, IN idUser bigint, IN idRole tinyint, IN idType tinyint,
                                     IN email VARCHAR(50),
                                     IN username VARCHAR(50), IN password varbinary(50), IN enable bit(1))
BEGIN
    INSERT INTO account(idAccount, idUser, idRole, idType, email, username, password, enable)
    VALUES (idAccount, idUser, idRole, idType, email, username, password, enable);
END $$ -------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_read_account`(IN idAccount bigint)
BEGIN
    SELECT * FROM account WHERE account.idAccount = idAccount;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_update_account`(IN idAccount bigint, IN idUser bigint, IN idRole tinyint, IN idType tinyint,
                                     IN email VARCHAR(50),
                                     IN username VARCHAR(50), IN password varbinary(50), IN enable bit(1))
BEGIN
    update account
    SET idAccount = idAccount,
        idUser=idUser,
        idRole=idRole,
        idType=idType,
        email=email,
        username=username,
        password=password,
        enable=enable;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_delete_account`(IN idAccount bigint)
BEGIN
    delete from account where idAccount = idAccount;
END $$ -------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_create_user`(IN idUser bigint, IN identity_card VARCHAR(15), IN name VARCHAR(50),
                                  IN lastname VARCHAR(50),
                                  IN bithdate date, IN registration_date date, IN address geometry, IN enable bit(1),
                                  IN active bit(1))
BEGIN
    INSERT INTO account(idAccount, idUser, idRole, idType, email, username, password, enable)
    VALUES (idAccount, idUser, idRole, idType, email, username, password, enable);
END $$ -------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_read_user`(IN idUser bigint)
BEGIN
    SELECT * FROM user WHERE user.idUser = idUser;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_update_user`(IN idUser bigint, IN identity_card VARCHAR(15), IN name VARCHAR(50),
                                  IN lastname VARCHAR(50),
                                  IN bithdate date, IN registration_date date, IN address geometry, IN enable bit(1),
                                  IN active bit(1))
BEGIN
    update account
    SET idUser           = idUser,
        identity_card=identity_card,
        name=name,
        lastname=lastname,
        bithdate=bithdate,
        registration_date=registration_date,
        address=address,
        enable=enable,
        active=active;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_delete_user`(IN idUser bigint)
BEGIN
    delete from user where idUser = idUser;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_create_discountCoupon`(IN idDiscountCoupon bigint, IN idUser bigint, IN value decimal(9, 2),
                                            IN valid_until date,
                                            IN active bit(1), IN enable bit(1))
BEGIN
    INSERT INTO discount_coupon(idDiscountCoupon, idUser, value, valid_until, active, enable)
    VALUES (idDiscountCoupon, idUser, value, valid_until, active, enable);
END $$ -----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_read_discountCoupon`(IN idDiscountCoupon bigint)
BEGIN
    SELECT * FROM discount_coupon WHERE user.idUser = idDiscountCoupon;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_update_discountCoupon`(IN idDiscountCoupon bigint, IN idUser bigint, IN value decimal(9, 2),
                                            IN valid_until date,
                                            IN active bit(1), IN enable bit(1))
BEGIN
    update discount_coupon
    SET idDiscountCoupon = idDiscountCoupon,
        idUser=idUser,
        value=value,
        valid_until=valid_until,
        active=active,
        enable=enable;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_delete_discountCoupon`(IN idDiscountCoupon bigint)
BEGIN
    delete from discount_coupon where idDiscountCoupon = idDiscountCoupon;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_create_userContact`(IN idUserContact bigint, IN idUser bigint, IN idType tinyint,
                                         IN value VARCHAR(50), IN enable bit(1))
BEGIN
    INSERT INTO user_contact(idUserContact, idUser, idType, value, enable)
    VALUES (idAccount, idUser, idRole, idType, email, username, password, enable);
END $$ -----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_read_userContact`(IN idDiscountCoupon bigint)
BEGIN
    SELECT * FROM user_contact WHERE user_contact.idDiscountCoupon = idDiscountCoupon;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_update_userContact`(IN idUserContact bigint, IN idUser bigint, IN idType tinyint,
                                         IN value VARCHAR(50), IN enable bit(1))
BEGIN
    update user_contact SET idUserContact = idUserContact, idUser=idUser, idType=idType, value=value, enable=enable;
END $$ -------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `sp_delete_userContact`(IN idDiscountCoupon bigint)
BEGIN
    delete from user_contact where idDiscountCoupon = idDiscountCoupon;
END $$ -------------------------------------------------------------------------------------------

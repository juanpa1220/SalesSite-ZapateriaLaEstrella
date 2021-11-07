DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_account`(p_name varchar(50),p_lastname varchar(50),p_birthdate date, p_address varchar(50),
                                                             p_email varchar(50),p_username varchar(50), p_password varchar(50))
BEGIN
    DECLARE v_password varbinary(50);
    DECLARE p_idUser bigint;
    DECLARE v_address geometry;
    DECLARE p_idAccount bigint;
    SET v_password = CAST(p_password as binary);
    SELECT coordinates into v_address from city where `city` = p_address;
    SELECT MAX(idUser)+1 into p_idUser from `user` ;
    SELECT MAX(idAccount)+1 into p_idAccount from `account`;
    INSERT INTO `user`(idUser,identity_card,`name`,lastname,birthdate,registration_date,`address`,`enable`,`active`)
    VALUES(p_idUser,null,p_name,p_lastname,p_birthdate,(SELECT CURDATE()),v_address,1,1);

    INSERT INTO `account`(idAccount,idUser,idRole,idType,email,username,`password`,`enable`)
    VALUES(p_idAccount,p_idUser,2,2,p_email,p_username,v_password,1);

END
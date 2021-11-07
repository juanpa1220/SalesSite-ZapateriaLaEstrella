DELIMITER $$
CREATE
    DEFINER = `admin`@`%` PROCEDURE `sp_desactive_user`(p_user bigint)
BEGIN
    start transaction;
    update `account`
    set `enable` = 0
    where idUser = p_user
      AND idType = 3;
    commit;
END$$
DELIMITER ;


DELIMITER $$
CREATE
    DEFINER = `admin`@`%` PROCEDURE `sp_read_user`(IN p_idUser bigint)
BEGIN
    SELECT u.idUser,
           identity_card,
           `name`,
           lastname,
           birthdate,
           registration_date,
           CONCAT('Point(', ST_X(address), ' ', ST_Y(address), ')'),
           `enable`,
           `active`
    FROM `user` u
    WHERE p_idUser IS NULL
       OR u.idUser = p_idUser;
END$$
DELIMITER ;

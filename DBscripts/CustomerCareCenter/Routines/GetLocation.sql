DELIMITER $$
CREATE PROCEDURE `GetLocation`(p_user bigint)
BEGIN
    select ST_X(address), ST_Y(address)
    from `user`
    where idUser = p_user;
END$$
DELIMITER ;
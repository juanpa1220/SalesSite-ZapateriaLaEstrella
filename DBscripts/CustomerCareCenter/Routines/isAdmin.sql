DELIMITER $$
CREATE PROCEDURE `isAdmin`(IN idUser int)
BEGIN
	DECLARE roleID int;
    SET roleID = (SELECT a.idRole FROM `account` a inner join `user` u on a.idUser = u.idUser
    inner join `role` r on a.idRole = r.idRole WHERE a.idUser = idUser);
    if roleID = 1 then select 1 as result;
    ELSE select 0 as result;
    end if;
END$$
DELIMITER ;
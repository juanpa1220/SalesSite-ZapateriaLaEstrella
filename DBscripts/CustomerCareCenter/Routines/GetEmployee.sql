DELIMITER $$
CREATE PROCEDURE `get_employee`(p_address varchar(50))
BEGIN
SELECT u.idUser as `value`, `name` as label FROM `user` u inner join `account` a on u.idUser = a.idUser WHERE a.idType = 3;
END$$
DELIMITER ;
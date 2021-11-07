DELIMITER $$
CREATE PROCEDURE `GetUserContact`()
BEGIN
    SELECT u.idUser                                  AS Id,
           CONCAT(u.`name`, ' ', u.lastname)         AS Usuario,
           GROUP_CONCAT(c.`value` SEPARATOR '  &  ') AS Contacto
    FROM `User` u INNER JOIN user_contact c ON (u.idUser = c.idUser)
    WHERE MONTH(u.birthdate) = MONTH(NOW())
      AND DAY(u.birthdate) = DAY(NOW())
    GROUP BY u.idUser, CONCAT(u.`name`, ' ', u.lastname)
    ORDER BY u.idUser, CONCAT(u.`name`, ' ', u.lastname);
END$$
DELIMITER ;
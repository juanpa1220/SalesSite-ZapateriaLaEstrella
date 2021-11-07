DELIMITER $$
CREATE PROCEDURE `get_user_address`(p_address varchar(50))
BEGIN
    select ST_X(coordinates), ST_Y(coordinates)
    from `city`
    where city = p_address;
END$$
DELIMITER ;
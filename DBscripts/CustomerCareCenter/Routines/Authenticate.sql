DELIMITER $$
CREATE PROCEDURE `authenticate`(p_user varchar(50), p_password varchar(50))
BEGIN
    DECLARE v_password, cp_password varbinary(50);
    DECLARE v_user bigint;
    set cp_password = CAST(p_password as binary);
    select `password`, idUser into v_password, v_user from `account` where username = p_user;
    if (v_password is not null) then
        if (BINARY (v_password) = BINARY (cp_password)) then
            select v_user as result;
        else
            select 0 as result;
        end if;
    else
        select 0 as result;
    end if;
END$$
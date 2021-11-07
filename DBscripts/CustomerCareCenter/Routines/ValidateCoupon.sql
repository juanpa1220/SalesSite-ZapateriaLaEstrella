DELIMITER $$
CREATE PROCEDURE `sp_validate_coupon`(p_idUser bigint, p_idDiscountCoupon varchar(50))
BEGIN
    DECLARE `user` bigint;
    DECLARE `coupon` varchar(50);
    DECLARE `coupon_active` varchar(50);
    DECLARE `coupon_value` decimal(9, 2);
    SET `coupon_value` = (select `value` from discount_coupon where idDiscountCoupon = p_idDiscountCoupon);
    SET `user` = (SELECT idUser FROM discount_coupon where idDiscountCoupon = p_idDiscountCoupon);
    SET `coupon` = (SELECT idDiscountCoupon FROM discount_coupon where idDiscountCoupon = p_idDiscountCoupon);
    SET `coupon_active` = (SELECT `active` FROM discount_coupon where idDiscountCoupon = p_idDiscountCoupon);
    if (`user` is not null) then
        if (`coupon_active` = 1) then
            select `coupon_value` as result;
        else
            select 0 as result;
        end if;
    else
        select 0 as result;
    end if;
END$$
DELIMITER ;
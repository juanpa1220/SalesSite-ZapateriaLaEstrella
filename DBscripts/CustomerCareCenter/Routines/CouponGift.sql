USE `customer_service`;
DELIMITER $$
CREATE PROCEDURE `coupon_gift`(IN idUser int)
BEGIN
	DECLARE p_idCoupon int;
    SET p_idCoupon = (SELECT max(idDiscountCoupon) from discount_coupon);
    if p_idCoupon is null then
		SET p_idCoupon = 1;

		INSERT INTO `discount_coupon`(idDiscountCoupon,idUser,`value`,`valid_until`,`active`,`enable`)
		VALUES(p_idCoupon,idUser,5.0,DATE_ADD(NOW(),INTERVAL 3 month),1,1);

    ELSE
		INSERT INTO `discount_coupon`(idDiscountCoupon,idUser,`value`,`valid_until`,`active`,`enable`)
		VALUES((SELECT MAX(idDiscountCoupon)+1 from discount_coupon),idUser,5.0,DATE_ADD(NOW(),INTERVAL 3 month),1,1);
	end if;

END$$
DELIMITER ;
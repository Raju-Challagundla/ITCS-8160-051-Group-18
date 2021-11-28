
DELIMITER $$
-- DROP FUNCTION IF EXISTS total_pay_amount;
-- calculate total fee paid per delivery order
CREATE FUNCTION  total_pay_amount (ord_id int)
RETURNS float 
DETERMINISTIC
BEGIN 
	DECLARE final_pay float;	
    SELECT total_price + delivery_charge INTO final_pay
    FROM  CampusEats_Fall_2021.orders
	WHERE order_id = ord_id; 
    RETURN final_pay;
END $$
DELIMITER;
-- Test function total_pay_amount
SELECT  total_pay_amount(3)


-- DROP FUNCTION IF EXISTS sum_delivety_by_driver;
-- calculate total delivery fee made by a driver
DELIMITER $$
CREATE FUNCTION sum_delivety_by_driver( d_id INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN 
	DECLARE sum_delivety FLOAT;	
	SELECT SUM(delivery_charge) INTO sum_delivety 
    FROM  CampusEats_Fall_2021.orders
	WHERE driver_id = d_id;
	RETURN sum_delivety;
END $$
DELIMITER ;

SELECT  sum_delivety_by_driver(3)



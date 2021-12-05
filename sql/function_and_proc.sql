DROP PROCEDURE IF EXISTS total_order_customer

-- Change statement delimiter from semicolon to double front slash
DELIMITER //
CREATE PROCEDURE total_order_customer ( in cus_id int, in timea VARCHAR(100), in timeb VARCHAR(100), out total_order int)
-- declare parameter within stored procedure
-- (
--  @cus_id int , 
--  @total_order int
-- )
BEGIN
  -- DECLARE sum_number_order INT; -- declare variable to be used during execution of stored procedure

  SELECT COUNT(*)
  INTO total_order
  -- the result will be placed in this variable sum_balance_due_var
  FROM  CampusEats_Fall_2021.orders
  WHERE person_id = cus_id AND ordered_time BETWEEN timea AND timeb;
  -- Change statement delimiter from semicolon to double front slash
END //
DELIMITER ; 

set @cus_id=2, @timea='2021-11-15 09:30:00', @timeb='2021-11-17 10:45:33';
CALL total_order_customer(@cus_id, @timea, @timeb, @total_order);
select @total_order;


-- DROP FUNCTION IF EXISTS customer_rating_for_restaurant
-- calculate a particular customer’s  average rating for a restaurant
DELIMITER $$
CREATE FUNCTION customer_rating_for_restaurant( cus_id INT, res_id INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN 
	DECLARE avg_customer_rating_for_restaurant FLOAT;	
	SELECT ROUND(avg_restaurant_rating, 2) INTO avg_customer_rating_for_restaurant
	FROM  
		(SELECT AVG(rating.restaurant_rating) AS avg_restaurant_rating, rating.order_id, ord.person_id, rating.restaurant_id
		FROM  CampusEats_Fall_2021.rating AS rating
		INNER JOIN CampusEats_Fall_2021.orders AS ord
		ON rating.order_id = ord.order_id
		where ord.person_id = cus_id AND rating.restaurant_id = res_id
    -- where person_id=2
		group by  order_id, rating.restaurant_id) as avg_rest_rating;
	RETURN avg_customer_rating_for_restaurant;
END $$
DELIMITER ;

SELECT  customer_rating_for_restaurant(2, 9) 


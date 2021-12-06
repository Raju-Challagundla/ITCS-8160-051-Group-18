-- 1) display the max, min and average ratings for each feature when given a restaurant ID for all orders for that restaurant
DROP PROCEDURE IF EXISTS min_max_ave_restaurant_rating;
DELIMITER //
CREATE PROCEDURE min_max_avg_restaurant_rating ( in res_id int, out min_rest_rating float, out max_rest_rating float, out avg_rest_rating float)
BEGIN
  SELECT MIN(restaurant_rating) 
  INTO min_rest_rating
  FROM  rating
  WHERE restaurant_id = res_id; 
  
  SELECT MAX(restaurant_rating) 
  INTO max_rest_rating
  FROM  rating
  WHERE restaurant_id = res_id; 
  
  SELECT AVG(restaurant_rating) 
  INTO avg_rest_rating
  FROM  rating
  WHERE restaurant_id = res_id; 
END //
DELIMITER ; 

set @res_id=3;
CALL min_max_avg_restaurant_rating(@res_id, @min_rest_rating, @max_rest_rating, @avg_rest_rating);
select Round(@min_rest_rating, 3), Round(@max_rest_rating, 3), Round(@avg_rest_rating, 3);


-- 2) display a count of the orders made by a customer for a specified date range when given a customer id
DROP PROCEDURE IF EXISTS total_order_customer
DELIMITER //
CREATE PROCEDURE total_order_customer ( in cus_id int, in timea VARCHAR(100), in timeb VARCHAR(100), out total_order int)
BEGIN
  SELECT COUNT(*)
  INTO total_order
  FROM  orders
  WHERE person_id = cus_id AND ordered_time BETWEEN timea AND timeb;
END //
DELIMITER ; 

set @cus_id=2, @timea='2021-11-15 09:30:00', @timeb='2021-11-17 10:45:33';
CALL total_order_customer(@cus_id, @timea, @timeb, @total_order);
select @total_order;

--3) calculate a particular customer’s rating for a restaurant
-- calculate a particular customer’s rating for a restaurant
DELIMITER $$
CREATE FUNCTION customer_rating_for_restaurant( cus_id INT, res_id INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN 
	DECLARE cus_rating_for_rest FLOAT;	
	SELECT restaurant_rating  INTO cus_rating_for_rest
		FROM (SELECT rating.restaurant_rating AS restaurant_rating, rating.order_id, ord.person_id, rating.restaurant_id
		FROM  CampusEats_Fall_2021.rating AS rating
		INNER JOIN CampusEats_Fall_2021.orders AS ord
		ON rating.order_id = ord.order_id
		WHERE ord.person_id = cus_id AND rating.restaurant_id =res_id)  as rest_rate;
	RETURN cus_rating_for_rest;
END $$
DELIMITER ;

SELECT  customer_rating_for_restaurant(2, 9) 



-- views
-- Display total price of the orders by each customer (distinct) for a specified date range

CREATE VIEW total_spending_per_person AS 
SELECT ROUND(SUM(orders.total_price), 2) AS total_spending, person.person_id, orders.ordered_time FROM `orders`, `person` WHERE orders.person_id = person.person_id GROUP BY (orders.person_id);

DROP PROCEDURE IF EXISTS total_order_price;
DELIMITER $$
CREATE PROCEDURE total_order_price(
	IN  StartDate DATETIME, 
	IN  EndDate DATETIME
)
BEGIN
	SELECT * FROM `total_spending_per_person` where ordered_time BETWEEN StartDate AND EndDate;
END$$
DELIMITER ;
CALL total_order_price('2021-01-01 09:30:00', '2022-01-01 01:30:00');



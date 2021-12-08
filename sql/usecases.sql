-- 1) display the max, min and average ratings for each feature when given a restaurant ID for all orders for that restaurant
DROP PROCEDURE IF EXISTS min_max_ave_restaurant_rating;
DELIMITER //
CREATE PROCEDURE min_max_avg_restaurant_rating ( in res_id int, out min_rest_rating float, out max_rest_rating float, out avg_rest_rating float)
BEGIN
  SELECT MIN(restaurant_rating) 
  INTO min_rest_rating
  FROM  rating,orders
  WHERE restaurant_id = res_id AND rating.order_id= orders.order_id; 
  
  SELECT MAX(restaurant_rating) 
  INTO max_rest_rating
  FROM  rating,orders
  WHERE restaurant_id = res_id AND rating.order_id= orders.order_id; 
  
  SELECT AVG(restaurant_rating) 
  INTO avg_rest_rating
  FROM  rating,orders
  WHERE restaurant_id = res_id AND rating.order_id= orders.order_id; 
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

-- 3) calculate a particular customer’s rating for a restaurant
SELECT rating.restaurant_rating AS restaurant_rating,ord.person_id, ord.restaurant_id,rating.order_id
FROM rating AS rating
INNER JOIN orders AS ord
ON rating.order_id = ord.order_id
WHERE ord.person_id = 2 AND ord.restaurant_id = 7 AND rating.restaurant_rating is not null



-- 4) Display total price of the orders by each customer (distinct) for a specified date range
-- Below are the functions which accepts startDate and endDate as input variables for the view
CREATE FUNCTION startDate() RETURNS DATETIME DETERMINISTIC NO SQL RETURN @startDate;
CREATE FUNCTION endDate() RETURNS DATETIME DETERMINISTIC NO SQL RETURN @endDate;


CREATE VIEW total_spending_per_person AS 
SELECT 
	person.person_id,
    ROUND(SUM(orders.total_price), 2) AS total_spending 
FROM
    `orders`,
    `person`
WHERE
    orders.person_id = person.person_id 
    AND ordered_time BETWEEN startDate() AND endDate() 
GROUP BY orders.person_id
ORDER BY orders.person_id;

SELECT 
    tsp.*
FROM
    (SELECT @startDate:='2021-01-01 09:30:00' sd) AS sdt,
    (SELECT @endDate:='2022-11-16 01:30:00' ed) AS edt,
    total_spending_per_person tsp;

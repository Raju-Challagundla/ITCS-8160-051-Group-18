-- display the max, min and average ratings for each feature when given a restaurant ID for all orders for that restaurant
DROP PROCEDURE IF EXISTS min_max_ave_restaurant_rating;

-- Change statement delimiter from semicolon to double front slash
DELIMITER //
CREATE PROCEDURE min_max_avg_restaurant_rating ( in res_id int, out min_rest_rating float, out max_rest_rating float, out avg_rest_rating float)
-- declare parameter within stored procedure
-- (
--  @l_id int , 
--  @min_rest_rating float output
--  @max_rest_rating float output
--  @avg_rest_rating float output
-- )
BEGIN
  -- DECLARE sum_number_order INT; -- declare variable to be used during execution of stored procedure

  SELECT MIN(restaurant_rating) 
  INTO min_rest_rating
  -- the result will be placed in this variable sum_balance_due_var
  FROM  CampusEats_Fall_2021.rating
  WHERE restaurant_id = res_id; 
  
  SELECT MAX(restaurant_rating) 
  INTO max_rest_rating
  -- the result will be placed in this variable sum_balance_due_var
  FROM  CampusEats_Fall_2021.rating
  WHERE restaurant_id = res_id; 
  
  SELECT AVG(restaurant_rating) 
  INTO avg_rest_rating
  -- the result will be placed in this variable sum_balance_due_var
  FROM  CampusEats_Fall_2021.rating
  WHERE restaurant_id = res_id; 

  -- Change statement delimiter from semicolon to double front slash
END //
DELIMITER ; 

set @res_id=3;
CALL min_max_avg_restaurant_rating(@res_id, @min_rest_rating, @max_rest_rating, @avg_rest_rating);
select Round(@min_rest_rating, 3), Round(@max_rest_rating, 3), Round(@avg_rest_rating, 3);


-- display a count of the orders made by a customer for a specified date range when given a customer id

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

-- views
-- Display the max, min and average ratings for each feature when given a restaurant ID for all orders for that restaurant.
create view resturant_ratings as select min(rating.restaurant_rating) as min_rating, max(rating.restaurant_rating) as max_rating, round(avg(rating.restaurant_rating), 2) as avg_rating, restaurant.restaurant_name, restaurant.restaurant_id from restaurant, rating where restaurant.restaurant_id = rating.restaurant_id group by (restaurant.restaurant_id);
-- Display total price of the orders by each customer (distinct) for a specified date range
create view total_spending_per_person as SELECT round(sum(orders.total_price), 2) as total_spending, person.person_id, orders.ordered_time FROM `orders`, `person` where orders.person_id = person.person_id and orders.ordered_time between '2021-01-01' and '2022-12-31' GROUP by (orders.person_id);
-- Persons who are approved can only be the drivers.
create view approved_driver as select driver.date_hired, driver.license_number, rating.driver_rating, student.student_id, person.person_name from rating, student, person, driver where student.student_id = driver.student_id and person.person_id = student.student_id and driver.driver_id = rating.driver_id;
-- who is going to deliver, where is it getting delivered,delivered or not, which vehicle driver is using, from which restaurant, items under the order.
create view required_table as select orders.order_id, orders.	total_price, driver.license_number, location.location_address, status.status_desc, vehicle.model, restaurant.restaurant_name, items.item, person.person_name from driver, orders, location, status, delivery, vehicle, restaurant, orders_items, items, person, student where orders.driver_id = driver.driver_id and orders.location_id = location.location_id and delivery.delivery_status = status.status_id and status.status_id = 4 and delivery.driver_id = driver.driver_id and delivery.vehicle_id = vehicle.vehicle_id and restaurant.restaurant_id = orders.restaurant_id and orders.order_id = orders_items.order_id and items.item_id = orders_items.item_id and student.person_id = person.person_id and driver.student_id = student.student_id;


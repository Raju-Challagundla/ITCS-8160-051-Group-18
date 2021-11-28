-- USE CampusEats_Fall_2021;

DROP PROCEDURE IF EXISTS location_totalnumber_order;

-- Change statement delimiter from semicolon to double front slash
DELIMITER //
CREATE PROCEDURE location_totalnumber_order ( in l_id int, out sum_number_order int)
-- declare parameter within stored procedure
-- (
--  @l_id int , 
--  @sum_number_order int output
-- )
BEGIN
  -- DECLARE sum_number_order INT; -- declare variable to be used during execution of stored procedure

  SELECT COUNT(*)
  INTO sum_number_order
  -- the result will be placed in this variable sum_balance_due_var
  FROM  CampusEats_Fall_2021.orders
  WHERE location_id = l_id; 
  -- Change statement delimiter from semicolon to double front slash
END //
DELIMITER ; 

set @l_id=3;
CALL location_totalnumber_order(@l_id, @sum_number_order);
select @sum_number_order;


DROP PROCEDURE IF EXISTS max_restaurant_rating;

-- Change statement delimiter from semicolon to double front slash
DELIMITER //
CREATE PROCEDURE max_restaurant_rating ( in res_id int, out max_rest_rating float)
-- declare parameter within stored procedure
-- (
--  @l_id int , 
--  @max_rest_rating float output
-- )
BEGIN
  -- DECLARE sum_number_order INT; -- declare variable to be used during execution of stored procedure

  SELECT MAX(restaurant_rating)
  INTO max_rest_rating
  -- the result will be placed in this variable sum_balance_due_var
  FROM  CampusEats_Fall_2021.rating
  WHERE restaurant_id = res_id; 
  -- Change statement delimiter from semicolon to double front slash
END //
DELIMITER ; 

set @res_id=3;
CALL max_restaurant_rating(@res_id, @max_rest_rating);
select @max_rest_rating;


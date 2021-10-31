## Campus Eats (Fall-2021)
This project is based on Campus Eats database dump , further adds a rating system allows customers of Campus Eats to rate both food and drivers and a login enabled administrator who can make CRUD operations over all the tables.

## Team Members

Raju Challagundla

Yuehan Lan

Sumanta Bhattacharyya

Zihui Wang

## Project Introduction

With the threat of the Corona virus, food delivery services are more important than ever.Local restaurants are eager to find easy ways to have food delivered to customers without having to hire delivery employees. Even when things return to normal, many experts feel that food delivery will be something that we all will have become accustomed to as a part of our regular activites (even more than before).  

Students love food delivery services on campus.  Campuses do not like the steady stream of visitors that may or  may not have a formal connection with the university.  Companies such as UberEats and GrubHub are happy to deliver on campus, but many schools are wondering if they should take control of the delivery and ensure that students and authorized university employees are the only ones delivering food on campus for safety and health reasons.



## Business Rules
1. Persons who are approved can only be the drivers.
2. Only students or authrorzied employees may be drivers.
3. Food can only be delivered to the approved locations 
4. There is a flat fee of $5 for each delivery.
5. Include approved Food providers or restaurants
6. Max offerings by a restaurent is 10.
7. Orders can only be from one restaurant and from one person only
8. A customer can rate the foold only one time per order
9. A customer can rate the delivery only one time per order
10. Rating scale is between 1 to 5.
11. Administrators can will have access over all the data through the WebUI.

## EERD
[Click me to EERD page](https://github.com/Raju-Challagundla/ITCS-8160-051-Group-18/blob/main/project_demo.drawio.png)

## Data Dictionary

[Click me to Data Dictionary page](https://github.com/Raju-Challagundla/ITCS-8160-051-Group-18/blob/main/Data%20Dictionary.xlsx)

## Sample Stored procedures
###### 1) Name of Stored Procedure: no_of_orders_delivered_by_driver

**Purpose**: To get total orders delivered per driver.

**Code**:
-- Get total orders delivered per driver.

DROP PROCEDURE IF EXISTS no_of_orders_delivered_by_driver;

DELIMITER //

CREATE PROCEDURE no_of_orders_delivered_by_driver(IN driver_id INT, OUT total INT)

BEGIN
	SELECT count(*) INTO total FROM driver dr, delivery de 
	WHERE dr.driver_id = de.driver_id AND dr.driver_id = driver_id AND de.delivery_time IS NOT NULL;
END //
DELIMITER ;
CALL no_of_orders_delivered_by_driver(2,@total);
SELECT @total;
Screenshot of successful Call and execution, showing results.


**2) Name of Stored Procedure:** ###### sum_total_by_restaurant
Purpose:  To get Sum of total purchase by restaurant.
Code:
DROP PROCEDURE IF EXISTS sum_total_by_restaurant;
DELIMITER //
CREATE PROCEDURE sum_total_by_restaurant( IN res_id INT, OUT sumtotal FLOAT)
BEGIN
	SELECT SUM(total_price) INTO sumtotal 
    FROM Campus_Eats_Fall2021.order ord where ord.restaurant_id = res_id;
 
END //
 
DELIMITER ;
 
CALL sum_total_by_restaurant(5, @sumtotal);
SELECT ROUND(@sumtotal,2);
 


 


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

We study the data and food delivery service website/app to enhancing the database.


## Business Rules
1. Persons who are approved can only be the drivers.
2. Only students may be drivers.
3. Food can only be delivered to the approved locations 
4. There is a flat fee of $5 for each delivery.
5. Include approved Food providers or restaurants
6. Max offerings by a restaurent is 10.
7. Orders can only be from one restaurant and from one person only
8. A customer can rate the foold only one time per order
9. A customer can rate the delivery only one time per order
10. Rating scale is between 1 to 5.
11. Administrators can will have access over all the data through the WebUI.
12. A restaurant can have many menu items. Each menu item only offered from one restaurant.

## EERD
[Click me to EERD page](Final_EERD_2.pdf)

## Data Dictionary


				

![image](https://user-images.githubusercontent.com/89530932/139565106-7f70b71a-706b-4087-9be1-dc5ff38e4873.png)


## Sample Stored procedures

  
**1) To get total orders delivered per driver.** 
<pre>

DROP PROCEDURE IF EXISTS no_of_orders_delivered_by_driver;

DELIMITER //

CREATE PROCEDURE no_of_orders_delivered_by_driver(IN driver_id INT, OUT total INT)

BEGIN
	
	SELECT count(*) INTO total 
	
	FROM driver dr, delivery de 
	
	WHERE dr.driver_id = de.driver_id AND dr.driver_id = driver_id AND de.delivery_time IS NOT NULL;

END //

DELIMITER ;

CALL no_of_orders_delivered_by_driver(2,@total);

SELECT @total;

   </pre>

**2)  To get Sum of total purchase by restaurant.**

<pre>

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
</pre>

## Springboot Web/App Implementation
TBA
## MySQL Database Dump

[Complete Database Dump](sql/CampusEats_Dump20211128.sql)


 


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

## Architecture / Use Case for Rating System

1. Customers provide ratings after delivery of an order.
2. Customers may provide ratings / comments / upload a photo of a driver
3. Customers may provide ratings / comments / upload a photo of a restaurant
4. Customers may provide ratings / comments / upload a photo of a food item
5. Customers may search for ratings on a particular restaurant.
6. Administrators of the system can view driver ratings, Item ratings and restaurant ratings.

![image](docs/CampusEats_Architecture.png)

## EERD
![image](docs/Final_EERD.png)

## Data Dictionary

				
[Click here](docs/DataDictionary_Final.pdf)


## Stored procedures

Database users who retrieve updated records daily or repeatedly throughout the week/month use stored procedures to simplify this task. Stored procedures are SQL code that is saved to a file and accessed via a call procedure. To execute the query, a user calls the procedure and specifies a parameter that the underlying SQL query then executes. Thereby, stored procedures allow users to save time and increase efficiency by eliminating the need to re-write SQL code.

  
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
## Indexes and indexing: speed up search run time
Because the primary key and foreign key already have index, we only need add index to the data which needs to search frequent and special, and not search by id.

![image](screenshots/test.png)

Before we have index, the search will scan full table, it will spend much more time.

![image](screenshots/i1.png)

After create index, the search changed to non-unique key look up, and search time is sharp drop.

![image](screenshots/i2.png)

## Springboot Web/App Implementation

The web application is built using Springboot-2.5.6 which also uses thymeleaf as html template engine and authentication is handled through spring web security. You can download [source code and instructions to setup from here](https://github.com/Raju-Challagundla/CampusEats-Backoffice).

This web application allows an administrative user to manage entries in the different (Refer to above architecture Diagram) tables of the database. Appication uses below tables to authenticate the administrative user
- Person (col: person_email)
- Staff (col: is_admin = Y)
- Admin (col: encrypted password)

And once authentication is successful then a session gets started which ensures the protection of the urls that is used within the application until logout happens; only authorized users can access the application's Create-Read-Update-Delete (CRUD) functionality.

An authenticated administrator has the ability to view 
- Orders
- Deliveries
- Students / Drivers
- Restaurants
- Food Items
- Vehicles
- Ratinng of Drivers / Restaurants / Food Items.
	
An authenticated administrator has the ability to add new, update , delete existing 
- Students / Drivers
- Restaurants
- Food Items
- Vehicles

New users (who will have administrative privileges) can only be added by a previously authenticated user. Once added, new user will be able to login as administrator and be able to to perform the the previleged functionalities.


#### Screenshots of the CampusEats Backoffice (CRUD)

[Login](screenshots/1-Login-Admin.png) | [Home](screenshots/2-Home.png) | [Add Adminstrator](screenshots/3-AddAdmin.png) | [Retrieve Students](screenshots/4-ListStudents.png) | [Add Student](screenshots/6-AddStudent.png) | [Update Student](screenshots/7-UpdateStudent.png) | [Retrieve Restaurants](screenshots/8-ListRestaurants.png) | [Add Restaurant](screenshots/9-AddRestaurant.png) | [Update Restaurant](screenshots/10-UpdateRestaurant.png) | [Retrieve Orders](screenshots/11-ListOrders.png) | [Retrieve Deliveries](screenshots/12-ListDeliveries.png) | [Manage Delivery](screenshots/13-ManageDelivery.png) | [Retrieve Food Items](screenshots/14-ListFoodItems.png) | [Add Food Item](screenshots/15-AddFoodItem.png) | [AddFoodItemsByRestaurants](screenshots/16-AddFoodItemsByRestaurants.png) | [Update Food Item](screenshots/17-UpdateFoodItem.png) | [Retrieve Vehicles](screenshots/18-Listvehicles.png) | [Add Vehicle](screenshots/19-AddVehicle.png) | [Update Vehicle](screenshots/20-UpdateVehicle.png)

#### Future Work
TBA

## MySQL Database Dump

[Complete Database Dump](sql/CampusEatsDump_20211130.sql)

#### Screenshots of Populated Database Tables:
[ratings table](screenshots/ratings.png) |
[order table](screenshots/order.png) |
[delivery table](screenshots/delivery.png) |
[driver table](screenshots/driver.png) |
[faculty table](screenshots/faculty.png) |
[location table](screenshots/location.png) |
[person table](screenshots/person.png) |
[restaurant table](screenshots/restaurant.png) |
[staff table](screenshots/staff.png) |
[student table](screenshots/student.png) |
[vehicle table](screenshots/vehicle.png) |
[users table for CRUD admin interface](screenshots/users.png)
 
## PPT or Video

[Summary video](https://drive.google.com/file/d/1WFpg5wHiJIFeC-CWg3tntDvHGEhr9yeH/view)


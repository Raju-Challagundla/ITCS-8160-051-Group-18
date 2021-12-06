-- display the max, min and average ratings for each feature when given a restaurant ID for all orders for that restaurant
create view resturant_ratings as select min(rating.restaurant_rating) as min_rating, max(rating.restaurant_rating) as max_rating, round(avg(rating.restaurant_rating), 2) as avg_rating, restaurant.restaurant_name, restaurant.restaurant_id from restaurant, rating where restaurant.restaurant_id = rating.restaurant_id group by (restaurant.restaurant_id);

-- Persons who are approved can only be the drivers.

create view approved_driver as select driver.date_hired, driver.license_number, rating.driver_rating, student.student_id, person.person_name from rating, student, person, driver where student.student_id = driver.student_id and person.person_id = student.student_id and driver.driver_id = rating.driver_id

-- cover as much table as possible -who is going to deliver,
-- where is going to location - where is it getting delivered,
-- delivered or not,
-- which vehicle driver is using,
-- from which restaurant,
-- items under the order.

create view required_table as select orders.order_id, orders.	total_price, driver.license_number, location.location_address, status.status_desc, vehicle.model, restaurant.restaurant_name, items.item, person.person_name from driver, orders, location, status, delivery, vehicle, restaurant, orders_items, items, person, student where orders.driver_id = driver.driver_id and orders.location_id = location.location_id and delivery.delivery_status = status.status_id and status.status_id = 4 and delivery.driver_id = driver.driver_id and delivery.vehicle_id = vehicle.vehicle_id and restaurant.restaurant_id = orders.restaurant_id and orders.order_id = orders_items.order_id and items.item_id = orders_items.item_id and student.person_id = person.person_id and driver.student_id = student.student_id;
 
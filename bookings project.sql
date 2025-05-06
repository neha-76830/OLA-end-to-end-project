CREATE DATABASE Ola;
CREATE TABLE bookings(
	Date DATE,
	Time TIME,
	Booking_ID VARCHAR(50),
	Booking_Status VARCHAR(50),
	Customer_ID VARCHAR(50),
	Vehicle_Type VARCHAR(50),
	Pickup_Location VARCHAR(50),
	Drop_Location VARCHAR(50),
	V_TAT NUMERIC(10,2),
	C_TAT NUMERIC(10,2),
	Cancelled_Reason_by_Customer VARCHAR(100),
	Cancelled_Reason_by_Driver VARCHAR(100),
	Incomplete_Rides VARCHAR(100),
	Incomplete_Rides_Reason VARCHAR(100),
	Payment_Method VARCHAR(50),
	Booking_Value INT,
	Ride_Distance INT,
	Driver_Ratings NUMERIC(3,1),
	Customer_Rating NUMERIC(3,1)
);
SELECT * FROM bookings;
COPY
bookings(Date, Time, Booking_ID, Booking_Status, Customer_ID, Vehicle_Type, Pickup_Location, Drop_Location, V_TAT, C_TAT, Cancelled_Reason_by_Customer,Cancelled_Reason_by_Driver, Incomplete_Rides, Incomplete_Rides_Reason, Payment_Method, Booking_Value, Ride_Distance, Driver_Ratings, Customer_Rating)
FROM 'C:\Program Files\PostgreSQL\16\Bookings.csv'
DELIMITER','
CSV HEADER
NULL 'NULL';

SQL Questions:
--1. Retrieve all successful bookings:
CREATE VIEW Successful_bookings AS
SELECT*FROM bookings
WHERE Booking_status='Success';

--2. Find the average ride distance for each vehicle type:
CREATE VIEW ride_distance_for_each_vehicle AS
SELECT Vehicle_type,AVG(ride_distance) AS avg_distance
FROM bookings
GROUP BY Vehicle_type;

--3.Get the total number of cancelled rides by customers:
CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT(*) FROM bookings
WHERE Booking_Status='Cancelled by Customer';

--4.List the top 5 customers who booked the highest number of rides:
CREATE VIEW top_5_customers AS
SELECT customer_id,COUNT(booking_id) AS total_rides FROM bookings
GROUP BY customer_id 
ORDER BY total_rides DESC LIMIT 5;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW rides_cancelled_by_drivers_p_c_issues AS
SELECT COUNT(*) FROM bookings
WHERE Cancelled_reason_by_driver='Personal & Car related issues';

--6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW max_min_driver_rating AS
SELECT MAX(Driver_ratings) AS max_rating,
MIN(Driver_ratings) AS min_rating FROM bookings
WHERE Vehicle_type='Prime Sedan';

--7. Retrieve all rides where payment was made using UPI:
CREATE VIEW upi_payment AS
SELECT*FROM bookings
WHERE Payment_method='UPI';

--8. Find the average customer rating per vehicle type:
CREATE VIEW avg_cust_rating AS 
SELECT Vehicle_type,AVG(Customer_rating) AS avg_rating
FROM bookings
GROUP BY Vehicle_type;

--9. Calculate the total booking value of rides completed successfully:
CREATE VIEW total_successful_ride_value AS
SELECT SUM(booking_value) AS total_successful_ride_value 
FROM bookings
WHERE booking_status = 'Success';

--10. List all incomplete rides along with the reason:
CREATE VIEW Incomplete_rides_reason AS 
SELECT Incomplete_rides, Incomplete_rides_reason FROM bookings
WHERE Incomplete_rides='Incomplete';

         --Retrieve all answers--

--1. Retrieve all successful bookings:
SELECT*FROM Successful_bookings;

--2. Find the average ride distance for each vehicle type:
SELECT*FROM ride_distance_for_each_vehicle;

--3.Get the total number of cancelled rides by customers:
SELECT*FROM cancelled_rides_by_customers;

--4.List the top 5 customers who booked the highest number of rides:
SELECT * FROM top_5_customers;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT * FROM rides_cancelled_by_drivers_p_c_issues;

--6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT*FROM max_min_driver_rating;

--7. Retrieve all rides where payment was made using UPI:
SELECT*FROM upi_payment;

--8. Find the average customer rating per vehicle type:
SELECT * FROM avg_cust_rating;

--9. Calculate the total booking value of rides completed successfully:
SELECT*FROM total_successful_ride_value;

--10. List all incomplete rides along with the reason:
SELECT*FROM Incomplete_rides_reason;

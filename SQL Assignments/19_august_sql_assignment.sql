-- Que1: Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
select * from CITY where POPULATION >100000 and COUNTRYCODE = 'USA';

-- Que2: Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
select NAME from CITY where POPULATION > 120000 AND COUNTRYCODE = 'USA';

-- Que3: Query all columns (attributes) for every row in the CITY table
select * from CITY;

-- Que4: Query all columns for a city in CITY with the ID 1661
select * from CITY where ID = 1661;

-- Que5: Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from CITY where COUNTRYCODE = 'JPN';

##STATION TABLE
-- Que6: Query a list of CITY and STATE from the STATION table.
select CITY, STATE from STATION;

-- Que7: uery a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct CITY from STATION where mod(ID, 2)=0;

-- Que8: Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
select count(CITY) - count(distinct(CITY)) from STATION;

-- Que10:  Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
select CITY, length(CITY) as City_letter_length from STATION order by CITY limit 1;
select CITY , length(CITY) as Length_city_letter from STATION order by CITY desc limit 1;

-- Que11: Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select distinct(CITY) from STATION where CITY like 'a%' or CITY like 'e%' or CITY like'i%' or CITY like'o%' or CITY like 'u%' order by CITY; 

-- Que12:  Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct(CITY) from STATION where CITY like '%a' or CITY like '%e' or CITY like '%i' or CITY like '%o' or CITY like '%u' order by CITY;

-- Que13:  Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct(CITY) from STATION where CITY not like 'a%' and CITY not like 'e%' and CITY not like 'i%' and CITY not like 'o%' and CITY not like 'u%' and
CITY not like 'A%' and CITY not like 'E%' and CITY not like 'I%' and CITY not like 'O%' and CITY not like 'U%';

-- Que14: Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates
select distinct(CITY) from STATION 
where CITY not like '%a' and CITY not like '%e' and CITY not like '%i' and CITY not like '%o' and CITY not like '%u' and
CITY not like '%A' and CITY not like '%E' and CITY not like '%I' and CITY not like '%O' and CITY not like '%U' 
order by CITY;

-- Que15:  Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select CITY from STATION 
where 
(CITY not like '%a' and CITY not like '%e' and CITY not like '%i' and CITY not like '%o' and CITY not like '%u' and
CITY not like '%A'and CITY not like '%E' and CITY not like '%I' and CITY not like '%O' and CITY not like '%U') 
or 
(CITY not like 'a%' and CITY not like 'e%' and CITY not like 'i%' and CITY not like 'o%' and CITY not like 'u%' and
CITY not like 'A%' and CITY not like 'E%' and CITY not like 'I%' and CITY not like 'O%' and CITY not like 'U%')
order by CITY;

-- Que16:  Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
select CITY from STATION 
where 
(CITY not like '%a' and CITY not like '%e' and CITY not like '%i' and CITY not like '%o' and CITY not like '%u' and
CITY not like '%A'and CITY not like '%E' and CITY not like '%I' and CITY not like '%O' and CITY not like '%U') 
and 
(CITY not like 'a%' and CITY not like 'e%' and CITY not like 'i%' and CITY not like 'o%' and CITY not like 'u%' and
CITY not like 'A%' and CITY not like 'E%' and CITY not like 'I%' and CITY not like 'O%' and CITY not like 'U%')
order by CITY

 
/*
Table: Product
Column Name Type
product_id int
product_name varchar
unit_price int
product_id is the primary key of this table.
Each row of this table indicates the name and the price of each product.
Table: Sales
Column Name Type
seller_id int
product_id int
buyer_id int
sale_date date
quantity int
price int
This table has no primary key, it can have repeated rows.
product_id is a foreign key to the Product table.
Each row of this table contains some information about one sale.
*/

-- Que17: Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.Return the result table in any order.
select distinct p.product_id, p.product_name from product p
left join Sales s on p.product_id = s.product_id
where s.sale_date between '2019-01-01' and '2019-03-31'
order by p.product_id;

/*
Table: Views
Column Name Type
article_id int
author_id int
viewer_id int
view_date date
There is no primary key for this table, it may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some
date.
Note that equal author_id and viewer_id indicate the same person.
*/
-- Que18: Write an SQL query to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.
select distinct author_id from Views
where viewer_id = author_id
order by author_id;

/*
Table: Delivery
Column Name Type
delivery_id int
customer_id int
order_date date
customer_pref_delivery_date date
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date and
specify a preferred delivery date (on the same order date or after it).
If the customer's preferred delivery date is the same as the order date, then the order is called
immediately; otherwise, it is called scheduled.
*/
-- Que19: Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
select round(count(case when order_date = customer_pref_delivery_date then 1 end) / count(*)*100), 2) as Immediate_Orders from Delivery;

/*
Table: Ads
Column Name Type
ad_id int
user_id int
action enum
(ad_id, user_id) is the primary key for this table.
Each row of this table contains the ID of an Ad, the ID of a user, and the action taken by this user
regarding this Ad.
The action column is an ENUM type of ('Clicked', 'Viewed', 'Ignored').
A company is running Ads and wants to calculate the performance of each Ad.
Performance of the Ad is measured using Click-Through Rate (CTR) where:
*/
-- Que20: Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points. Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.
select ad_id, round((sum(action = 'Clicked')*100.0) / nullif(sum(action in ('Clicked', 'Viewed')), 0), 2) as ctr
from Ads where Ads != 'Ignored'
group by ad_id
order by ctr desc, ad_id;

/*
Table: Employee
Column Name Type
employee_id int
team_id int
employee_id is the primary key for this table.
Each row of this table contains the ID of each employee and their respective team.
*/
-- Que21: Write an SQL query to find the team size of each of the employees. Return result table in any order. The query result format is in the following example.
select employee_id, sum(1) over (partition by team_id) as team_size from Employee;

/*
Table: Countries
Column Name Type
country_id int
country_name varchar
country_id is the primary key for this table.
Each row of this table contains the ID and the name of one country.
Table: Weather
Column Name Type
country_id int
weather_state int
day date
(country_id, day) is the primary key for this table.
Each row of this table indicates the weather state in a country for one day.
*/
-- Que22: Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
# ● Cold if the average weather_state is less than or equal 15,
# ● Hot if the average weather_state is greater than or equal to 25, and
# ● Warm otherwise.
# Return result table in any order
 
SELECT c.country_name,
       CASE
           WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
           WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
           ELSE 'Warm'
       END AS weather_type
FROM Countries c
JOIN Weather w ON c.country_id = w.country_id
WHERE w.day >= '2019-11-01' AND w.day < '2019-12-01' GROUP BY c.country_name;

/*
Table: Prices
Column Name Type
product_id int
start_date date
end_date date
price int
(product_id, start_date, end_date) is the primary key for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two
intersecting periods for the same product_id.
Table: UnitsSold
Column Name Type
product_id int
purchase_date date
units int
There is no primary key for this table, it may contain duplicates.
Each row of this table indicates the date, units, and product_id of each product sold.
*/
-- Que 23: Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places. Return the result table in any order
select p.product_id, round(sum(p.price)/ count(us.Units), 2) as average_price from Prices p
join UnitSold us on p.product_id = us.product_id
group by product_id
order by product_id;

/*
Table: Activity
Column Name Type
player_id int
device_id int
event_date date
games_played int
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before
logging out on someday using some device.
*/
-- Que24: Write an SQL query to report the first login date for each player. Return the result table in any order.
select player_id, min(event_date) as first_login from Activity group by player_id;

/*
Table: Activity
Column Name Type
player_id int
device_id int
event_date date
games_played int
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before
logging out on someday using some device.
*/
-- Que25: Write an SQL query to report the device that is first logged in for each player. Return the result table in any order.
select player_id, min(device_id) as first_device from Activity group by player_id;

/*
Table: Products
Column Name Type
product_id int
product_name varchar
product_category varchar
product_id is the primary key for this table.
This table contains data about the company's products.
Table: Orders
Column Name Type
product_id int
order_date date
unit int
There is no primary key for this table. It may have duplicate rows.
product_id is a foreign key to the Products table.
unit is the number of products ordered in order_date.
*/
-- Que26: Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount. Return result table in any order.
select p. product_name, sum(o.unit) as amount from Products p 
join Orders o on p.Products = o.Orders
where o.order_date >= '2020-02-01' and o.order_date <= '2020-02-29'
group by p.product_name
having sum(o.unit) >= 100;

/*
Table: Users
Column Name Type
user_id int
name varchar
mail varchar
user_id is the primary key for this table.
This table contains information of the users signed up in a website. Some emails are invalid.
*/
-- que27: Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where:
# ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
# ● The domain is '@leetcode.com'. Return the result table in any order

select user_id, name, mail from Users where mail like '[A-Za-z]%@leetcode.com';

/*
Table: Customers
Column Name Type
customer_id int
name varchar
country varchar
customer_id is the primary key for this table.
This table contains information about the customers in the company.
Table: Product
Column Name Type
customer_id int
name varchar
country varchar
product_id is the primary key for this table.
This table contains information on the products in the company.
price is the product cost.
Table: Orders
Column Name Type
order_id int
customer_id int
product_id int
order_date date
quantity int
order_id is the primary key for this table.
This table contains information on customer orders.
customer_id is the id of the customer who bought "quantity" products with id "product_id".
Order_date is the date in format ('YYYY-MM-DD') when the order was shipped.
*/
-- Que28: Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020. Return the result table in any order
select c.customer_id, c.name from Customers
join Orders o on c.customer_id = o.customer_id
join Product p on p.product_id = o.product_id
where (year(o.order_date) = 2020 and month(o.order_date) = 6) or (year(o.order_date) = 2020 and month(o.order_date) = 7)
group by c.customer_id, c.name
having sum(p.price) >= 100 * 2;

-- Que29: Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. Return the result table in any order.
select distinct(c.title) from Content c
join TVProgram t on t.TVProgram = c.Content
where (c.Kids_content = 'Y') and (c.content_type = 'Movies') and (year(t.program_date) = 2020) and (month(t.program_date) = 6)
order by c.title;

-- Que30: Write an SQL query to find the npv of each query of the Queries table. Return the result table in any order.
select n.id, q.year, ifnull(n.npv, 0) as npv from NPV n
join Queries q on n.id = q.id and n.year = q.year
order by q.year;

-- Que31: Write an SQL query to find the npv of each query of the Queries table. Return the result table in any order
select n.id, q.year, coalesce(n.npv, 0) AS npv from NPV n
join Queries q  on n.id = q.id and n.year = q.year 
ORDER BY q.year;


-- Que32: Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null. Return the result table in any order.
select ifnull(eu.unique_id, null) as unique_id, e.name from Employees e
join EmployeeUNI eu on e.id = eu.id
order by eu.unique_id;

-- Que33: Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order.
select u.name, coalesce(sum(r.distance), 0) as travelled_distance from Users u
join Rides r on u.id = r.id group by u.name order by travelled_distance desc , u.name;

-- Que34: Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount. Return result table in any order.
select p.product_name, o.unit as Amount from Products p
join Orders o on p.product_id = o.product_id
where (o.unit >= 100) and (year(o.order_date) = 2020) and (month(o.order_date) = 2)
order by p.product_name;

-- Que35: Write an SQL query to:
# ● Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
# ● Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
select u.name as result from Users u
join MovieRating mr on u.user_id = mr.user_id
group by u.name order by count(mr.movie_id) desc, u.name limit 1;

select m.title from Movies m
join MovieRating mr on m.movie_id = mr.movie_id
where year(mr.created_at) = 2020 and month(mr.created_at) = 2
group by m.title
order by avg(mr.rating) desc, m.title limit 1;

-- Que36: Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order
select u.name, ifnull(sum(r.distance), 0) as travelled_distance from Users u
left join Rides r on u.id = r.id
group by u.name order by travelled_distance desc, u.name;

-- Que37: Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null. Return the result table in any order
select eu.unique_id, e.name from EmployeeUNI eu
left join Employees e on eu.id = e.id
order by e.id;

-- Que38: Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist. Return the result table in any order.
select s.id, s.name from Students s
left join Departments d on s.department_id = d.id
where d.id is null;

-- Que39: Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2. Return the result table in any order
select least(from_id, to_id) as person1, greatest(from_id, to_id) as person2, count(*) as call_count, sum(duration) as total_duration from Calls 
where from_id < to_id
group by person1, person2 order by person1, person2;

-- Que40: Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places. Return the result table in any order
select us.product_id, round(sum(p.price * us.units) / sum(us.units), 2) as average_price from UnitSolds us
left join Prices p on us.product_id = p.product_id  
group by us.product_id;

-- Que41: Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse. Return the result table in any order.
select w.name as warehouse_name, sum(p.Width * p.Length * p.Height * w.units) as volume from Warehouse w
join Products p on w.product_id = p.product_id
group by w.name 
order by w.name;

-- Que42: Write an SQL query to report the difference between the number of apples and oranges sold each day. Return the result table ordered by sale_date
select sale_date, SUM(sold_num * (2 * (fruit = 'apples') - 1)) as diff from Sales group by sales_date order by sales_date;

-- Que43: Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
select round(sum(1.0 * (event_date = date_add(event_date, interval -1 day))) / count(distinct player_id), 2) as fraction
from Activity group by player_id;

-- Que44: Write an SQL query to report the managers with at least five direct reports. Return the result table in any order
select distinct e1.name from Employee e1, Employee e2
where e1.id = e2.manager_id group by e1.id having count(*) >= 5;

-- Que45: Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department table (even ones with no current students).
# Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.
select d.dept_name, ifnull(count(s.student_id), 0) as student_number from Department d
left join Student s on d.dept_id = s.dept_id
group by d.dept_name order by student_number desc, d.dept_name;

-- Que46: Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.Return the result table in any order.
select c.customer_id from Customer c
left join Product p on c.product_key = p.product_key
group by c.customer_id having sum(if(p.product_key is null, 1, 0)) = 0;

-- Que47: Write an SQL query that reports the most experienced employees in each project. In case of a tie,
# report all employees with the maximum number of experience years. Return the result table in any order.
select distinct p.project_id, e.employee_id from Project p
join Employee e on p.employee_id = e.employee_id
where (p.project_id, e.experience_years) in (select project_id, max(experience_years) from Project
join Employee on Project.employee_id = Employee.employee_id group by project_id);

-- Que48: Write an SQL query that reports the books that have sold less than 10 copies in the last year,
# excluding books that have been available for less than one month from today. Assume today is 2019-06-23. Return the result table in any order
select distinct b.book_id, b.name from Books b
left join Orders o on b.book_id = o.book_id and o.dispatch_date >= date_sub('2019-06-23', interval 1 year) and o.dispatch_date <= '2019-06-23'
where b.available_from <= date_sub('2019-06-23', interval 1 month)
group by b.book_id, b.name
having sum(coalesce(o.quantity, 0)) < 10;

-- Que49: Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.
# Return the result table ordered by student_id in ascending order.
select student_id, course_id, grade 
from (select student_id, course_id, grade, rank() over(partition by student__id order by grade desc, course_id) as HighestGrade from Enrollments)
ranked where HighestGrade = 1 order by student_id;

-- Que50: Write an SQL query to find the winner in each group. Return the result table in any order.
select distinct p.group_id, 
first_value (p.player_id) over(partition by p.group_id order by sum(m.host_goals + m.guest_goals) desc, p.player_id) as winner from Players p
left join Matches m on p.player_id = m.host_team or p.player_id = m.guest_team group by p.group_id, p.player_id;

-- Thank You!! --
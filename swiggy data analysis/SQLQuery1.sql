create database swiggy;

use swiggy;

select * from Table_1;

select * from table_2;

--Area-wise distribution of restaurant----THIS PART DONE IN EXCEL BY USING PIVOT TABLE

--Which is cheapest and expensive restaurant for each types of cuisine. (IMPORT IN EXCEL AND MAKE PIVOT FOR EXP AND CHEAPEST)

with cte as
(select Restaurant_Name,Cuisine, sum(price_per_two) as total from Table_1
group by Restaurant_Name,Cuisine)

select restaurant_name,cuisine, max(total) as expensive, min(total) as cheapest from cte
group by restaurant_name, cuisine;

---Which location maximum number of restaurant where the delivery_review_number is greater than 1000.

with cte as
(select location, count(restaurant_name) as num_rest , rating from Table_1 a
join table_2 b on a.Restaurant_ID = b.restourant_id
where rating > 1000
group by location, rating)

select location, max(num_rest) as max_num_rest from cte
group by Location;

--Generate any one interesting insight from the data.

--INSIGHTS-MOST popular restaurant in each location



with cte as
(Select restaurant_name, location,sum(rating) as total_rating from Table_1 t1
join table_2 t2 on t1.Restaurant_ID = t2.restourant_id
group by restaurant_name, location),

cte2 as
(select restaurant_name, location,total_rating,
DENSE_RANK()over(partition by location order by total_rating desc) as rnk from cte)

select restaurant_name, location, total_rating from cte2
where rnk =1
order by total_rating desc;

--Which location maximum number of less rated restaurant.

with cte as
(select location, rating, count(restaurant_id) as num_rest from Table_1 as a
join table_2 as b on a.Restaurant_ID = b.restourant_id
where rating <100
group by location , rating)

select location, maX(num_rest) as num_less_rated_rest from cte
group by location;

--Area wise cheap and expensive restaurant and their average price.
select location, restaurant_name, avg(price_per_two) as avg_price from Table_1
group by Location, Restaurant_Name;


--Number of restaurant for each type of cuisine.

select cuisine, count(restaurant_name) as num_of_rstaurant from Table_1
group by cuisine
order by num_of_rstaurant desc ;



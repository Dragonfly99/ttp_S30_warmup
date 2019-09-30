-- You're wandering through the wilderness of someone else's code, and you stumble across
-- the following queries that use subqueries. You think they'd be better as CTE's
-- Go ahead and re-write the queries to use CTE's

-- -- EXAMPLE CTE:
--Returns the customer ID’s of ALL customers who have spent more money than $100 in their life.

WITH customer_totals AS (
  SELECT customer_id, 
         SUM(amount) as total
  FROM payment
  GROUP BY customer_id
)

SELECT customer_id, total 
FROM customer_totals 
WHERE total > 100;


--YOUR TURN:
-- Returns the average of the amount of stock each store has in their inventory. 
SELECT AVG(stock)
FROM (SELECT COUNT(inventory_id) as stock
	  FROM inventory
	  GROUP BY store_id) as store_stock;
	  
-- Returns the average customer lifetime spending, for each staff member.
-- HINT: you can work off the example
SELECT staff_id, AVG(total)
FROM (SELECT staff_id, SUM(amount) as total
	  FROM payment 
	  GROUP BY customer_id, staff_id) as customer_totals
GROUP BY staff_id;

-- Returns the average rental rate for each genre of film.
SELECT AVG(rental_rate)
FROM film JOIN film_category ON film.film_id=film_category.film_id
GROUP BY category_id;

-- Return all films that have the rating that is biggest category 
-- (ie. rating with the highest count of films)
SELECT title, rating
FROM film
WHERE rating = (SELECT rating 
				FROM film
			   GROUP BY rating
			   ORDER BY COUNT(*)
			   LIMIT 1);

-- Return all purchases from the longest standing customer
-- (ie customer who has the earliest payment_date)
SELECT * 
FROM payment
WHERE customer_id = (SELECT customer_id
					  FROM payment
					  ORDER BY payment_date
					 LIMIT 1);
                     
                     
                     
                     
                     
--Question 1
WITH avg_stock AS(
SELECT COUNT(inventory_id) AS stock
FROM inventory 
GROUP BY store_id 
)
SELECT AVG(stock)
FROM avg_stock;

--Question 2
WITH LTV AS(
SELECT staff_id, SUM(amount) as total
FROM payment
GROUP BY customer_id, staff_id 
)
SELECT staff_id, AVG(total)
FROM LTV
GROUP BY LTV.staff_id;


--Question 3
WITH  avg_rental_rate AS(
SELECT AVG(rental_rate) AS avg_rate
FROM film
INNER JOIN film_category
USING (film_id)
GROUP BY  category_id
)
SELECT avg_rate
FROM avg_rental_rate;

--Question 4
WITH biggest_category AS(
SELECT title, rating
FROM film
GROUP BY title, rating
ORDER BY COUNT(*) Desc 
)
SELECT title, rating
FROM biggest_category
WHERE rating = 'PG-13';

--Question 5
WITH early_customer AS
(SELECT *
FROM payment
ORDER BY customer_id)
SELECT *
FROM early_customer
WHERE customer_id = 416;


-- SQL Practice Case 
-- Retno Dewi Yulianti
-- Data Fellowship Batch 6 - Data Science (2021)

-- [1] A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
select count(title) 
from film
where description like '%Astronaut%'

-- [2] I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(title) 
from film
where rating = 'R' and replacement_cost between 5 and 15

-- [3] We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.How many payments did each staff member handle? And how much was the total amount processed by each staff member?
select s.staff_id, count(p.payment_id) record_count, sum(p.amount) total_amount 
from staff s 
join payment p on s.staff_id = p.staff_id 
where s.staff_id = 1 or s.staff_id = 2
group by s.staff_id 
order by record_count desc

-- [4] Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, avg(replacement_cost) avg_replacement_cost 
from film
group by rating 
order by avg_replacement_cost desc

-- [5] We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
select concat(c.first_name, ' ', c.last_name) cust_name, c.email, sum(p.amount) as spent_money 
from customer c 
join payment p on c.customer_id = p.customer_id 
group by cust_name, c.email 
order by spent_money desc 
limit 5

-- [6] We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
select s.store_id, count(i.film_id) total_copy_film
from store s
join inventory i on s.store_id = i.store_id 
group by s.store_id 

-- [7] We want to know what customers are eligible for our platinum credit card. The requirements are that the customer has at least a total of 40 transaction payments. Get the customer name, email who are eligible for the credit card! 
select concat(c.first_name, ' ', c.last_name) cust_name, c.email, count(p.payment_id) total_payment
from customer c 
join payment p on c.customer_id = p.customer_id
group by cust_name, c.email
having count(p.payment_id) > 40
order by total_payment desc

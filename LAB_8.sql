USE sakila;

#Rank films by length (filter out the rows that have nulls or 0s in length column). 
#In your output, only select the columns title, length, and the rank.


SELECT title, length, RANK() OVER (ORDER BY length DESC) as 'rank'
FROM film;

#Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
#In your output, only select the columns title, length, rating and the rank.

SELECT title, length, rating, DENSE_RANK() OVER (PARTITION BY rating ORDER BY length DESC) as 'dense_rank'
FROM film;


#How many films are there for each of the categories in the category table. Use appropriate join to write this query

SELECT C.Name, count(film_id) as CAT_COUNT
FROM Category C
INNER JOIN Film_category F
ON C.category_id = F.category_id
GROUP by C.Name
ORDER BY CAT_COUNT desc;



#Which actor has appeared in the most films?

SELECT Actor.First_Name, Actor.Last_name, count(film_id) as Movie_Count 
FROM Actor
INNER JOIN Film_Actor
ON Actor.actor_id = Film_Actor.actor_id
GROUP by Actor.First_Name, Actor.Last_Name
ORDER BY Movie_Count desc;

#Most active customer (the customer that has rented the most number of films)


SELECT C.First_name, C.Last_Name, count(rental_id) as Number_of_Rentals
FROM Customer C
INNER JOIN RENTAL
ON C.Customer_id = rental.customer_id
GROUP BY C.First_name, C.Last_name
Order BY Number_of_rentals desc;

#Bonus: Which is the most rented film? The answer is Bucket Brotherhood 
#This query might require using more than one join statement. Give it a try. 
#We will talk about queries with multiple join statements later in the lessons.

SELECT FILM.Title, count(rental_id) as Number_of_Rentals
FROM Film
INNER JOIN Inventory
ON Film.Film_id = Inventory.Film_id
INNER JOIN Rental
ON Inventory.Inventory_id = Rental.Inventory_id
GROUP BY FILM.Title
Order BY Number_of_rentals desc;
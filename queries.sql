/*
Databases I Final - COMP 5730
Patrick Kyoyetera and Matt Waterman 
*/

/*1. List titles of all books in ascending order. */
SELECT title FROM books ORDER BY title ASC;

/*2. Find the name of the author who wrote the book titled "On The Road". */
SELECT firstname,lastname FROM people
JOIN authors ON people.person_id = authors.person_id
JOIN books ON authors.author_id = books.author_id
WHERE title = 'On The Road';

/*3. List the title and author of books whose price is greater than $20. List your result in the 
ascending order of the price. */
SELECT title, books.author_id, price
FROM books
JOIN authors on books.author_id = authors.author_id
WHERE price > 20;

/*4. Find the books that have the same title but different author(s). Each book title should 
only be displayed once.*/
SELECT DISTINCT b1.title
FROM books b1, books b2
WHERE b1.title = b2.title AND b1.author_id <> b2.author_id AND b1.isbn <> b2.isbn;


/*5. Find the publisher that has the largest revenue in 2021. */
SELECT publisher_id, SUM(orders.paid) as revenue
FROM books
JOIN orders on books.book_id = orders.book_id
WHERE EXTRACT(year FROM time) = 21
GROUP BY publisher_id
ORDER BY revenue DESC
FETCH FIRST ROW ONLY;


/*6. List the title and price of all books written by the author of the best-selling book of 2021 
(the book that has been sold the most number of copies in 2021). */
SELECT title, price
FROM books
WHERE author_id IN( 
	SELECT author_id 
	FROM books
	WHERE book_id IN(
		SELECT book_id
		FROM orders
		GROUP BY book_id
		HAVING COUNT(book_id) = (
			SELECT MAX(COUNT(book_id))
			FROM orders
			GROUP BY book_id)));
			
			

/*7. Find the customer who has purchased every book written by Stephen King. */			
SELECT firstname, lastname
FROM people
JOIN customers ON people.person_id = customers.person_id
WHERE NOT EXISTS (
	SELECT books.book_id
	FROM books
	JOIN authors ON books.author_id = authors.author_id
	JOIN people on authors.person_id = people.person_id
	WHERE people.firstname = 'Stephen' AND people.lastname = 'King'
	MINUS
	SELECT orders.book_id
	FROM orders
	WHERE customer_id = customers.customer_id);	


/*8. Insert a new author. */
INSERT INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (5222, '299-33-2222', 'Jorge', 'Borges', ADDRESS_T('112 Main St', 'Santa Fe', 'NM', 67126));
INSERT INTO Authors (author_id, person_id) VALUES (232444, 5222);

/*9. Increase $2 to those books whose price is lower than $10.*/
UPDATE books
SET price = price + 2
WHERE price < 10;

/*10. Delete publishers and books they have published who are in Chicago. */
DELETE books.*, publishers.*
FROM books
INNER JOIN publishers
ON books.publisher_id = publisher.publisher_id
WHERE publisher.city = "Chicago";

DELETE FROM publisher
WHERE address.city = 'Chicago';
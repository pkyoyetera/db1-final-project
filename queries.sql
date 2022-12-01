/*
Databases I Final - COMP 5730
Patrick Kyoyetera and Matt Waterman 
*/

/*1. List titles of all books in ascending order. */
SELECT title FROM books ORDER BY ASC;

/*2. Find the name of the author who wrote the book titled "On The Road". */
SELECT name FROM people WHERE ssn = (
	SELECT ssn FROM people
	JOIN writes on author_id
	JOIN books on isbn
	WHERE title = "On The Road"
	)

/*3. List the title and author of books whose price is greater than $20. List your result in the 
ascending order of the price. */
SELECT title, name, price
FROM books
JOIN writes on author_id 
JOIN authors on author_id
WHERE price > 20;

/*4. Find the books that have the same title but different author(s). Each book title should 
only be displayed once.*/
SELECT DISTINCT b1.title
FROM books b1, books b2
WHERE b1.title = b2.title AND b1.author_id <> b2.author_id AND b1.isbn <> b2.isbn;


/*5. Find the publisher that has the largest revenue in 2021. */
SELECT name 
FROM publisher
HAVING publisher_id = (SELECT publisher_id 
		FROM orders
		JOIN books ON isbn
		GROUP BY publisher_id
		HAVING SUM(price) = MAX(
			SELECT SUM(price) 
			FROM orders
			JOIN books ON isbn
			GROUP BY publisher_id));


/*6. List the title and price of all books written by the author of the best-selling book of 2021 
(the book that has been sold the most number of copies in 2021). */

SELECT title, price
FROM books
WHERE author_id = 
	SELECT author_id 
	FROM books
	WHERE isbn = 
		SELECT isbn
		FROM orders
		GROUP BY isbn
		HAVING COUNT(isbn) = MAX(
			SELECT COUNT(isbn)
			FROM orders
			GROUP BY isbn;

/*7. Find the customer who has purchased every book written by Stephen King. */

SELECT name
FROM customers
WHERE customer_id = 
	SELECT customer_id 
	FROM orders
	WHERE isbn IN(
		SELECT isbn
		FROM books
		WHERE author_id = (
			SELECT author_id 
			FROM authors
			WHERE name = "Stephen King"))
	GROUP BY customer_id
	HAVING COUNT isbn = (
		SELECT COUNT(isbn)
		FROM books
		WHERE author_id = (
			SELECT author_id 
			FROM authors
			WHERE name = "Stephen King"))

/*8. Insert a new author. */
INSERT INTO
Authors (author_id, person_data)
VALUES ('4410',
        PERSON('12-12-12',  -- fixme probably want to set a proper format for SSN
               'Honorebel',
               ADDRESS_T('Main St.',
                         'Boston',
                         'MA',
                         '01231')
              )
        );
		
/*9. Increase $2 to those books whose price is lower than $10.*/
UPDATE books
SET price = price + 2
WHERE price < 10;

/*10. Delete publishers and books they have published who are in Chicago. */
DELETE books.*, publishers.*
FROM books
INNER JOIN publishers
ON books.publisher_id = publisher.publisher_id
WHERE publisher.city = "Chicago"
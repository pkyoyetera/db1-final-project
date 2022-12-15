
-- What makes an address?
CREATE OR REPLACE TYPE ADDRESS_T AS OBJECT (
    street              VARCHAR(40),
    city                VARCHAR(30),
    state               CHAR(2),
    zip_code            CHAR(5)
) FINAL;


CREATE TABLE People (
    person_id           INT                 NOT NULL,
    ssn                 VARCHAR(11)         NOT NULL,
    firstname           VARCHAR(30)         NOT NULL,
    lastname            VARCHAR(30)         NOT NULL,
    address             ADDRESS_T,

    CONSTRAINT pk_people PRIMARY KEY (person_id)  -- give the primary key constraint for this table the name 'pk_people'
);


-- An Authors table
CREATE TABLE Authors (
    author_id          INT              NOT NULL,
    person_id          INT              NOT NULL,

    CONSTRAINT pk_authors PRIMARY KEY (author_id),
    FOREIGN KEY (person_id) REFERENCES People (person_id)
);


-- A table for customers
CREATE TABLE Customers (
    customer_id        INT              NOT NULL,
    person_id          INT              NOT NULL,

    CONSTRAINT pk_customer PRIMARY KEY (customer_id),
    FOREIGN KEY (person_id) REFERENCES People (person_id)
);


-- Publishing house table
CREATE TABLE Publisher (
    publisher_id        INT             NOT NULL,
    name                VARCHAR(30),
    address             ADDRESS_T,

    CONSTRAINT pk_publisher PRIMARY KEY (publisher_id)
);

-- Describe books table
CREATE TABLE Books (
    book_id             INT             NOT NULL,
    isbn                VARCHAR(17)     NOT NULL,
    title               VARCHAR(50)     NOT NULL,
    price               FLOAT,
    publisher_id        INT,

    CONSTRAINT pk_books PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);


-- Writes relationship set
CREATE TABLE Writes (
    id                  INT             NOT NULL,
    author_id           INT             NOT NULL,
    book_id             INT             NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- Authors relationship set
CREATE TABLE Orders (
    order_id            INT             NOT NULL,
    customer_id         INT             NOT NULL,
    book_id             INT             NOT NULL,
    paid                FLOAT           NOT NULL,
    time                DATE            NOT NULL,

    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- Insert People into database
INSERT ALL
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (2314, '111-22-3333', 'Alexander', 'McQueen', ADDRESS_T('10 School St.', 'Devens', 'MA', '03020'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (2315, '213-11-2323', 'Elizabeth', 'Blomqvist', ADDRESS_T('Main St.', 'Boston', 'MA', '01231'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (1010, '542-55-2377', 'Tony', 'Stark', ADDRESS_T('1 Avengers Sq', 'New York', 'NY', '07023'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (8383, '432-56-2321', 'Steve', 'Nash', ADDRESS_T('6531 Buckets St', 'San Diego', 'CA', '72043'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (6283, '211-63-5247', 'Stephen', 'King', ADDRESS_T('91 Ackers Boulevard', 'Gotham', 'NJ', '13994'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (7116, '544-34-5637', 'Maile', 'Donaldson', ADDRESS_T('882 Sit Avenue', 'Rotterdam', 'LV', '54222'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (1183, '322-63-5247', 'Octavia', 'Butler', ADDRESS_T('44 Bowling Lane', 'Jersey City', 'NJ', '13994'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (8482, '889-52-1121', 'Emmanuel', 'Adebayor', ADDRESS_T('2686 Bibendum St, Apt 12', 'Salt Lake City', 'UT', '89122'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (7771, '213-63-6611', 'Bartlett', 'Giamatti', ADDRESS_T('443 East Gardner Rd', 'Naperville', 'IL', '09331'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (7217, '777-01-1100', 'Toni', 'Morrison', ADDRESS_T('1 Heaven Lane', 'Los Angeles', 'CA', '89923'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (4414, '121-34-6565', 'Jill', 'McCorkle', ADDRESS_T('12 Brimbury St', 'San Francisco', 'CA', '89923'))
    INTO People (person_id, ssn, firstname, lastname, address)
        VALUES (5117, '199-21-1333', 'Kate', 'Atkinson', ADDRESS_T('113 Main St', 'Albuquerque', 'NM', 67126))
SELECT 1 FROM DUAL;


-- Insert authors into Authors table
INSERT ALL
    INTO Authors (author_id, person_id) VALUES (151245, 6283)  -- Stephen King
    INTO Authors (author_id, person_id) VALUES (435222, 2315)  -- Beth Blomqvist
    INTO Authors (author_id, person_id) VALUES (328818, 7217)  -- T. Morrison
    INTO Authors (author_id, person_id) VALUES (123315, 8482)  -- E. Adebayor
    INTO Authors (author_id, person_id) VALUES (453112, 1183)  -- Octavia Butler
    INTO Authors (author_id, person_id) VALUES (212121, 4414)  -- Jill M
    INTO Authors (author_id, person_id) VALUES (343434, 5117)  -- Kate A
SELECT 1 FROM DUAL;


-- Dummy Customers (not literally :) )
INSERT ALL
    INTO Customers (customer_id, person_id) VALUES (55, 7771)
    INTO Customers (customer_id, person_id) VALUES (93, 8482)
    INTO Customers (customer_id, person_id) VALUES (83, 7116)
    INTO Customers (customer_id, person_id) VALUES (46, 1010)
SELECT 1 FROM DUAL;


-- Add some publishers
INSERT ALL
    INTO Publisher (publisher_id, name, address)
        VALUES (432, 'Random House', ADDRESS_T('491 Dutton St', 'Lowellita', 'MA', 02323))
    INTO Publisher (publisher_id, name, address)
        VALUES (919, 'Hachette Book Group', ADDRESS_T('12 43W 13th St', 'New York City', 'NY', 05522))
    INTO Publisher (publisher_id, name, address)
        VALUES (623, 'Harper Collins', ADDRESS_T('8 Lumberg Drive', 'Chicago', 'IL', 92344))
    INTO Publisher (publisher_id, name, address)
        VALUES (766, 'Macmillan', ADDRESS_T('7 Collins Lane', 'Franklin', 'MI', 44291))
    INTO Publisher (publisher_id, name, address)
        VALUES (221, 'Simon and Schuster', ADDRESS_T('9898 Winnnow Circle', 'Seattle', 'QA', 89892))
SELECT 1 FROM DUAL;


-- Add some books
INSERT ALL
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (3, '978-0-2257-7600-3', 'The Lost City of Culyan', 15.60, 432)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (5, '978-5-0072-6605-5', 'The Hunger Games', 12.99, 623)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (6, '978-0-743-26886-7', 'The Great Gatsby', 14.99, 221)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (8, '978-0-532-05686-5', 'Kindred', 10.99, 766)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (2, '978-2-9753-4360-3', 'The Shining', 11.99, 766)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (4, '978-2-5942-1677-7', 'It', 8.99, 919)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (7, '978-0-532-05256-5', 'Pride and Prejudice', 23.99, 623)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (11, '978-7-8114-4773-6', 'On The Road', 17.99, 919)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (12, '978-7-6360-9428-3', 'Life After Life', 7.99, 766)
    INTO Books (book_id, isbn, title, price, publisher_id)
        VALUES (13, '978-9-3350-0035-0', 'Life After Life', 26.75, 221)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Writes (id, author_id, book_id)
        VALUES (11, 435222, 3)
    INTO Writes (id, author_id, book_id)
        VALUES (12, 123315, 5)
    INTO Writes (id, author_id, book_id)
        VALUES (13, 435222, 6)
    INTO Writes (id, author_id, book_id)
        VALUES (14, 453112, 8)
    INTO Writes (id, author_id, book_id)
        VALUES (15, 151245, 2)
    INTO Writes (id, author_id, book_id)
        VALUES (16, 151245, 4)
    INTO Writes (id, author_id, book_id)
        VALUES (17, 435222, 7)
    INTO Writes (id, author_id, book_id)
        VALUES (18, 212121, 13)
    INTO Writes (id, author_id, book_id)
        VALUES (21, 123315, 11)
    INTO Writes (id, author_id, book_id)
        VALUES (19, 343434, 12)
SELECT 1 FROM DUAL;

-- Orders
INSERT ALL
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (10, 55, 3, 15.60, TO_DATE('01-JAN-17 13:11:33', 'dd-mon-yyyy hh24:mi::ss'))
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (11, 55, 6, 14.99, TO_DATE('02-FEB-21 10:00:00', 'dd-mon-yyyy hh24:mi::ss'))
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (12, 93, 8, 10.99, TO_DATE('03-FEB-20 11:00:00', 'dd-mon-yyyy hh24:mi::ss'))
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (13, 83, 2, 11.99, TO_DATE('05-MAR-22 09:05:00', 'dd-mon-yyyy hh24:mi::ss'))
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (14, 83, 4,  8.99, TO_DATE('19-MAR-21 14:00:10', 'dd-mon-yyyy hh24:mi::ss'))
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (15, 46, 7, 13.99, TO_DATE('26-APR-19 16:17:18', 'dd-mon-yyyy hh24:mi::ss'))
    INTO Orders (order_id, customer_id, book_id, paid, time)
        VALUES (16, 46, 5, 12.99, TO_DATE('30-APR-21 08:30:54', 'dd-mon-yyyy hh24:mi::ss'))

SELECT 1 FROM DUAL;

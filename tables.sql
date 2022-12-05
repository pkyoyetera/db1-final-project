
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
    isbn                VARCHAR(13)     NOT NULL,
    title               VARCHAR(50)     NOT NULL,
    price               FLOAT,
    author_id           INT,
    publisher_id        INT,

    CONSTRAINT pk_books PRIMARY KEY (book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
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
    price               FLOAT           NOT NULL,
    time                DATE            NOT NULL,

    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

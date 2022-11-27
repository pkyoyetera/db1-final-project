
-- What makes an address?
CREATE OR REPLACE TYPE ADDRESS_T AS OBJECT (
    street              VARCHAR(40),
    city                VARCHAR(30),
    state               CHAR(2),
    zip_code            CHAR(5)
) NOT FINAL;

-- Type person will describe Authors and Customers.
CREATE OR REPLACE TYPE PERSON AS OBJECT (
    ssn                 VARCHAR(20),
    name                VARCHAR (30),
    address             ADDRESS_T
) NOT FINAL;
-- REF FROM  (SSN);

-- An Authors table
CREATE TABLE Authors (
    author_id          INT         NOT NULL,  -- fixme, perhaps VARCHAR not INT?
    person_data        PERSON,

    PRIMARY KEY (author_id)
);

-- A table for customers
CREATE TABLE Customers (
    customer_id             INT         NOT NULL,  -- fixme, VARCHAR not INT?
    person_data   /*REF*/   PERSON,

    PRIMARY KEY (customer_id)
);


-- Attempt to insert a dummy author
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


-- Publishing house table
CREATE TABLE Publisher (
    publisher_id        INT             NOT NULL,
    name                VARCHAR(30),
    city                VARCHAR(20),

    PRIMARY KEY (publisher_id)
);

CREATE TABLE Books (
    isbn                VARCHAR(25)     NOT NULL,
    title               VARCHAR(50)     NOT NULL,
    author_id           INT,
    publisher_id        INT,

    PRIMARY KEY (isbn),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);



/*  Attempt to insert data into tables above */
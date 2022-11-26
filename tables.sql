
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
    person_data     REF     PERSON,

    PRIMARY KEY (customer_id)
);

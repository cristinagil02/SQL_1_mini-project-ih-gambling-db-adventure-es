USE SQL_TEST_DATA;

CREATE TABLE customer (
    CustId INT,
    AccountLocation VARCHAR(255),
    Title VARCHAR(255),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    CreateDate DATE,
    CountryCode VARCHAR(255),
    Language VARCHAR(255),
    Status VARCHAR(255),
    DateOfBirth DATE,
    Contact VARCHAR(255),
    CustomerGroup VARCHAR(255)
);

INSERT INTO customer (CustId, AccountLocation, Title, FirstName, LastName, CreateDate, CountryCode, Language, Status, DateOfBirth, Contact, CustomerGroup) VALUES
(4188499, 'GIB', 'Mr', 'Elvis', 'Presley', '2011-11-01', 'US', 'en', 'A', '1948-10-18', 'Y', 'Bronze'),
(1191874, 'GIB', 'Mr', 'Jim', 'Morrison', '2008-09-19', 'US', 'en', 'A', '1967-07-27', 'Y', 'Gold'),
(3042166, 'GIB', 'Mr', 'Keith', 'Moon', '2011-01-11', 'UK ', 'en', 'A', '1970-07-26', 'Y', 'Gold'),
(5694730, 'GIB', 'Mr', 'James', 'Hendrix', '2012-10-10', 'US', 'en', 'A', '1976-04-05', 'N', 'Bronze'),
(4704925, 'GIB', 'Mr', 'Marc', 'Bolan', '2012-03-26', 'UK ', 'en', 'A', '1982-03-11', 'Y', 'Bronze'),
(1569944, 'GIB', 'Miss', 'Janice', 'Joplin', '2009-04-09', 'US', 'en', 'A', '1954-08-22', 'Y', 'Gold'),
(3531845, 'GIB', 'Mr', 'Bon', 'Scott', '2011-04-02', 'AU', 'en', 'A', '1975-10-22', 'N', 'Silver'),
(2815836, 'GIB', 'Mr', 'Buddy', 'Holly', '2010-10-17', 'US', 'en', 'A', '1964-01-13', 'Y', 'Silver'),
(889782, 'GIB', 'Mr', 'Bob', 'Marley', '2008-01-16', 'UK ', 'en', 'A', '1964-04-18', 'Y', 'Silver'),
(1965214, 'GIB', 'Mr', 'Sidney', 'Vicious', '2009-12-18', 'UK ', 'en', 'A', '1976-08-12', 'N', 'Bronze');
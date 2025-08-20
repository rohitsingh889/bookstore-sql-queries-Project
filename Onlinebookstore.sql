--first create three tables as follows.....>
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:\DE\csv files data\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'C:\DE\csv files data\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'C:\DE\csv files data\Orders.csv' 
CSV HEADER;

--checking the dataset once....>
select * from Books;
select * from Customers;
select * from Orders;


--Q1) Retrieve all books in the "Science Fiction" genre.
--checks the Books table first and analyse
select * from Books;

--now, solving querry

select * from Books
where genre = 'Science Fiction';

--Q2) Find books published after the year 1980.
select * from Books
where published_year >1980;

--Q3) List all customers from the Turkey.
select * from Customers
where country ='Turkey';

--Q4) Show orders placed in November 2023.
--first, see the data set
select * from Orders;
--Answer 
--approach 1
SELECT * 
FROM Orders
WHERE EXTRACT(YEAR FROM order_date) = 2023
  AND EXTRACT(MONTH FROM order_date) = 11;
--approach 2
SELECT * 
FROM Orders
WHERE order_date >= '2023-11-01'
  AND order_date < '2023-12-01';
  --approach 3
  
SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--Q5) Retrieve the total stock of books available.
--first see the dataset
select stock from Books;

--answer
select sum(stock) as Total_Count from Books;

--Q6) Retrieve the total Average for stock of books available.
select avg(stock) as Total_Avg from Books;

--Q7) Retrieve the total Count stock of books available.

select count(stock) as Total_Avg from Books;

--Q8) Find the details of the most expensive book.
--see the dataset
select * from Books;
--answer 1
select  max(price) as Max_price from Books
LIMIT 1;
--answer 2 This will return the complete row(s) 
--of the book(s) that have the maximum price.
SELECT * 
FROM Books
WHERE price = (SELECT MAX(price) FROM Books);

--answer 3 
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;


--Q9Show all customers who ordered more than 1 quantity of a book.
--see the dataset and analyse.
select* from Orders;

--answer
select * from Orders
where quantity >1;

--Q10Retrieve all orders where the total amount exceeds $40.
select *  from 
Orders
where total_amount>40;

--Q11List all genres available in the Books table.
select distinct(genre) from Books;

-- If we also want them in alphabetical order, we can add ORDER BY genre.

SELECT DISTINCT genre
FROM Books
ORDER BY genre;

-- Q12) Find the book(s) with the lowest stock.
--answer 1
SELECT *
FROM Books
WHERE stock = (SELECT MIN(stock) FROM Books);

--answer 2
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;



--Q13Calculate the total revenue generated from all orders.
select sum(total_amount) as total_revenue from Orders;


--Q14Retrieve the total number of books sold for each genre.
SELECT * FROM ORDERS;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

--Q15Find the average price of books in the "Fantasy" genre.
--Q15 Find the average price of books in the "Fantasy" genre
SELECT AVG(price) AS avg_price
FROM Books
WHERE Genre = 'Fantasy';


--Q16 List customers who have placed at least 2 orders
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o 
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

--Q17Find the most frequently ordered book.

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;


--Q18Show the top 5 most expensive books of 'Fantasy' Genre.
select title , price from Books
where genre='Fantasy'
order by price desc
limit 5;

--Q19Retrieve the total quantity of books sold by each author.
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

--Q20List the cities where customers who spent over $20 are located.


 select c.city, sum(o.total_amount)
 from Customers c
 join Orders o
 on c.customer_id=o.customer_id
 group by c.city
HAVING sum(o.total_amount)>20;



--Q21Find the customer who spent the most on orders.


SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

--Q22Calculate the stock remaining after fulfilling all orders.

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


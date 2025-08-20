
---

## 🏗️ Database Schema

### 📘 Books Table
| Column          | Type           | Description |
|-----------------|---------------|-------------|
| Book_ID         | SERIAL (PK)   | Unique ID for each book |
| Title           | VARCHAR(100)  | Book title |
| Author          | VARCHAR(100)  | Author name |
| Genre           | VARCHAR(50)   | Book genre |
| Published_Year  | INT           | Year published |
| Price           | NUMERIC(10,2) | Price of book |
| Stock           | INT           | Available stock |

### 👤 Customers Table
| Column        | Type           | Description |
|---------------|---------------|-------------|
| Customer_ID   | SERIAL (PK)   | Unique customer ID |
| Name          | VARCHAR(100)  | Customer name |
| Email         | VARCHAR(100)  | Email address |
| Phone         | VARCHAR(15)   | Phone number |
| City          | VARCHAR(50)   | City |
| Country       | VARCHAR(150)  | Country |

### 🛒 Orders Table
| Column       | Type           | Description |
|--------------|---------------|-------------|
| Order_ID     | SERIAL (PK)   | Unique order ID |
| Customer_ID  | INT (FK)      | References Customers |
| Book_ID      | INT (FK)      | References Books |
| Order_Date   | DATE          | Date of order |
| Quantity     | INT           | Quantity ordered |
| Total_Amount | NUMERIC(10,2) | Total order value |

---

## 📊 SQL Queries Implemented

✅ **Data Retrieval & Filtering**  
1. Retrieve all books in the *Science Fiction* genre  
2. Find books published after 1980  
3. List customers from Turkey  
4. Show orders placed in November 2023  

✅ **Aggregation & Calculations**  
5. Total stock of books available  
6. Average stock of books  
7. Count of stock entries  
8. Most expensive book  
9. Customers who ordered more than 1 quantity  
10. Orders exceeding $40  

✅ **Distinct & Ordering**  
11. List all genres  
12. Book(s) with the lowest stock  
13. Total revenue generated  
14. Books sold per genre  
15. Average price of *Fantasy* books  

✅ **Joins & Grouping**  
16. Customers with at least 2 orders  
17. Most frequently ordered book  
18. Top 5 expensive Fantasy books  
19. Books sold by each author  
20. Cities where customers spent > $20  
21. Customer who spent the most  

✅ **Advanced Query**  
22. Remaining stock after fulfilling orders  

---



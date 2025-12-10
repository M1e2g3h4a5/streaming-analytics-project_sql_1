# Streaming Analytics SQL Project  
Analysis of user engagement, watch behavior, and churn using SQL

This project explores a Netflix-style streaming platform dataset.  
The goal is to understand user engagement, binge-watching trends, content preferences,  
and churn risk using SQL techniques including joins, aggregations, and window functions.

---

## 🎯 Project Objectives

- Analyze total watch time, genre popularity, and platform usage
- Identify top users and user segments based on watch behavior
- Detect binge-watching sessions (>150 minutes)
- Study customer churn patterns using inactivity gaps
- Build insights for product and business decisions

---

## 🗂️ Dataset Description

The project uses three tables:

### **1. users**
Contains profile and subscription information.

| Column | Description |
|--------|-------------|
| user_id | Unique user identifier |
| user_name | Name of user |
| country | User's country |
| signup_date | Date user joined |
| subscription_plan | Basic / Standard / Premium |

---

### **2. shows**
Contains metadata of streaming content.

| Column | Description |
|--------|-------------|
| show_id | Unique show ID |
| title | Name of the show |
| genre | Category (Drama, Action, Anime…) |
| release_year | Year show released |

---

### **3. watch_history**
Contains watch sessions for each user.

| Column | Description |
|--------|-------------|
| watch_id | Session ID |
| user_id | Who watched |
| show_id | Which show |
| watch_date | Date of watching |
| watch_minutes | Total minutes watched |
| device_type | Mobile / TV / Laptop |

---

## 🧠 Key SQL Skills Used

- **Joins**: INNER JOIN, LEFT JOIN  
- **Aggregations**: SUM, COUNT, AVG  
- **GROUP BY / HAVING**  
- **Window Functions**:  
  - Ranking: RANK(), ROW_NUMBER(), DENSE_RANK()  
  - Value functions: LAG(), FIRST_VALUE(), LAST_VALUE()  
  - Distribution: CUME_DIST(), PERCENT_RANK(), NTILE()  
- **Churn identification using LAG + DATEDIFF**  
- **User behavior segmentation with CASE**




# 📅 SQL Learning Journey — Day 9: DATE Functions  
📆 *Date:* 12/11  
💼 *By:* Rosalint Celcia  
🏢 *With:* Indian Data Club & DPDzero  

---

## 📘 Topics Covered  
- Working with SQL Date Functions  
- Date Arithmetic  
- Extracting Date Components  

---

## 📖 Reading & Resources  

Date functions help you **analyze, calculate, and filter date and time data** in SQL.  
They are essential for time-based reporting, calculating durations, and trend analysis.

---

## 🧩 Common Date Functions (SQLite Examples)

DATE('now')                     -- Current date
JULIANDAY(date)                 -- Convert to Julian day number
DATE(date, '+1 day')            -- Add 1 day
strftime('%Y', date)            -- Extract year
strftime('%m', date)            -- Extract month
strftime('%d', date)            -- Extract day

## 🧠 Examples
### 1️⃣ Calculate length of stay in days
SELECT
    patient_id,
    name,
    arrival_date,
    departure_date,
    CAST(JULIANDAY(departure_date) - JULIANDAY(arrival_date) AS INTEGER) AS stay_days
FROM patients;

### 2️⃣ Extract year and month from date
SELECT
    patient_id,
    strftime('%Y', arrival_date) AS arrival_year,
    strftime('%m', arrival_date) AS arrival_month
FROM patients;

### 3️⃣ Filter by date range
SELECT * FROM patients
WHERE arrival_date BETWEEN '2024-01-01' AND '2024-12-31';

### 4️⃣ Find patients admitted in a specific month (e.g., June)
SELECT * FROM patients
WHERE strftime('%m', arrival_date) = '06';  -- June

## 💡 Tips & Tricks

✅ Use ISO format ('YYYY-MM-DD') for consistent date comparisons

✅ Date difference functions by database:

-- SQLite
JULIANDAY(date2) - JULIANDAY(date1)

-- MySQL
DATEDIFF(date2, date1)

-- PostgreSQL
date2 - date1


### ✅ Extract date parts easily (SQLite):

strftime('%Y', date)  -- Year (2024)
strftime('%m', date)  -- Month (01–12)
strftime('%d', date)  -- Day (01–31)
strftime('%W', date)  -- Week number


### ✅ Performance tip: Using date functions in WHERE may slow queries on large datasets

### ✅ Cast results to appropriate types (INTEGER, REAL) for accurate math and formatting

## 🏋️‍♀️ Daily Challenge
## 🎯 Question:

Calculate the average length of stay (in days) for each service,
showing only services where the average stay is more than 7 days.
Also show the count of patients, and order results by average stay descending.

### ✅ Query:
SELECT
    service,
    COUNT(patient_id) AS patient_count,
    ROUND(AVG(JULIANDAY(departure_date) - JULIANDAY(arrival_date)), 2) AS avg_stay_days
FROM patients
WHERE departure_date IS NOT NULL AND arrival_date IS NOT NULL
GROUP BY service
HAVING AVG(JULIANDAY(departure_date) - JULIANDAY(arrival_date)) > 7
ORDER BY avg_stay_days DESC;

## 📊 Result:

This query highlights the services where patients tend to stay longer,
helping identify areas for further analysis or resource optimization.

## 🧾 Key Learning Outcomes

▪️Learned how to calculate date differences in SQL
▪️Understood date extraction and filtering using strftime()
▪️Practiced GROUP BY + HAVING with date-based metrics
▪️Gained insight into real-world healthcare analytics scenarios

## 🚀 Challenge Series

This challenge is part of the 21 Days SQL Challenge powered by Indian Data Club & DPDzero,
designed to help data enthusiasts strengthen SQL skills through hands-on problem-solving.

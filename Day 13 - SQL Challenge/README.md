# 📅 Day 13 (17/11): INNER JOIN — SQL Daily Challenge

with Indian Data Club & DPDzero

### 🧠 Topics Covered:
INNER JOIN — Combining Related Data from Multiple Tables

INNER JOIN returns only the matching rows from two tables based on a related column.

### 🔍 Basic Syntax
```sql
SELECT columns
FROM table1
INNER JOIN table2
    ON table1.column = table2.column;
```

### 🛠️ How INNER JOIN Works

Takes each row from table1

Looks for matching rows in table2

Returns only rows where the match exists in BOTH tables

Excludes unmatched rows

### 📘 Examples
1️⃣ Join patients with staff (same service)
```sql
SELECT 
    p.patient_id, 
    p.name AS patient_name, 
    p.service, 
    s.staff_name, 
    s.role
FROM patients p
INNER JOIN staff s 
    ON p.service = s.service
ORDER BY p.service, p.name;
```

2️⃣ Staff count per patient service
```sql
SELECT 
    p.patient_id,
    p.name,
    p.service,
    COUNT(s.staff_id) AS staff_count
FROM patients p
INNER JOIN staff s 
    ON p.service = s.service
GROUP BY 
    p.patient_id, 
    p.name, 
    p.service;
```

3️⃣ Multi-column INNER JOIN
```sql
SELECT *
FROM services_weekly sw
INNER JOIN staff_schedule ss
    ON sw.service = ss.service
   AND sw.week = ss.week;
```

💡 Tips & Tricks
✅ Use table aliases for clean, readable SQL
```sql
FROM patients p
JOIN staff s
```

✅ Avoid ambiguity by qualifying columns
```sql
SELECT p.service   -- Recommended
```

✅ INNER JOIN is default — meaning:
```sql
JOIN staff s  ==  INNER JOIN staff s
```

✅ Chain multiple joins
```sql
FROM t1
JOIN t2 ON ...
JOIN t3 ON ...
```

✅ Use WHERE for extra filtering (after JOIN)
```sql
WHERE p.age > 65
```

### 🏆 Daily Challenge
## Question:

Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service. 
Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name. 

### ✅ Solution Query (MySQL)
```sql
SELECT
    p.patient_id,
    p.name AS patient_name,
    p.age,
    p.service,
    staff_summary.staff_count
FROM patients p
INNER JOIN (
    SELECT 
        service,
        COUNT(staff_id) AS staff_count
    FROM staff
    GROUP BY service
    HAVING COUNT(staff_id) > 5
) AS staff_summary
ON p.service = staff_summary.service
ORDER BY 
    staff_summary.staff_count DESC,
    patient_name ASC;
```

### 📌 Day 13 Complete!

Another step forward in mastering SQL Joins 🚀

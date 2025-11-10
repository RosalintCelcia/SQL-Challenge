# 🧠 SQL Learning Journey — Day 7: HAVING Clause  
📅 *Date:* 10/11  
💼 *By:* Rosalint Celcia  
🏢 *With:* Indian Data Club & DPDzero  

---

## 📘 Topics Covered  
- HAVING Clause  
- Filtering aggregated results  

---

## 📖 Reading & Resources  

The **HAVING** clause filters groups created by `GROUP BY`, just as `WHERE` filters rows before grouping.  
It is mainly used with aggregate functions like `COUNT`, `AVG`, `SUM`, etc.

---

### 🧩 Basic Syntax

SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1
HAVING aggregate_condition;

### ⚖️ WHERE vs HAVING
Feature	WHERE	HAVING
Filters	Rows before grouping	Groups after grouping
Aggregate Functions	❌ Not allowed	✅ Allowed
Execution Order	Before GROUP BY	After GROUP BY
🧠 Examples
1️⃣ Services with more than 100 patients
SELECT service, COUNT(*) AS patient_count
FROM patients
GROUP BY service
HAVING COUNT(*) > 100;

2️⃣ Combining WHERE and HAVING
SELECT service, COUNT(*) AS elderly_count
FROM patients
WHERE age >= 65              -- Filter rows first
GROUP BY service
HAVING COUNT(*) > 20;        -- Filter groups after

3️⃣ Multiple HAVING Conditions
SELECT
    service,
    AVG(satisfaction) AS avg_sat,
    COUNT(*) AS count
FROM patients
GROUP BY service
HAVING AVG(satisfaction) > 80 AND COUNT(*) > 50;

### 💡 Tips & Tricks

✅ Execution Order: WHERE → GROUP BY → HAVING → ORDER BY
✅ Use WHERE for row filtering, HAVING for group filtering

❌ Inefficient:

### HAVING age > 65


### ✅ Efficient:

SELECT service, COUNT(*) 
FROM patients
WHERE age > 65         -- Filter before grouping (faster)
GROUP BY service;


✅ HAVING requires GROUP BY – it cannot be used alone.
✅ Some databases allow referencing column aliases in HAVING:

SELECT service, COUNT(*) AS count
FROM patients
GROUP BY service
HAVING count > 100;  -- Supported in some systems


✅ Combine multiple conditions with AND/OR just like in WHERE.

###  🏋️‍♀️ Daily Challenge
🎯 Question:

Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80.
Show:

service
total_refused
avg_satisfaction

### ✅ Query:
SELECT
    service,
    SUM(patients_refused) AS total_refused,
    AVG(satisfaction) AS avg_satisfaction
FROM services_weekly
GROUP BY service
HAVING 
    SUM(patients_refused) > 100 
    AND AVG(satisfaction) < 80
ORDER BY total_refused DESC;

### 🧾 Summary

The HAVING clause is your go-to tool for filtering aggregated data after grouping.
It’s essential for deeper analytical queries where you want to focus on group-level insights rather than individual rows.

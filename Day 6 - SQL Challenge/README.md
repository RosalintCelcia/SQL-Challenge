# 🧠 SQL Learning Journey — Day 6: GROUP BY Clause  
📅 *Date:* 09/11  
💼 *By:* Rosalint Celcia  
🏢 *With:* Indian Data Club & DPDzero  

---

## 📘 Topics Covered  
- GROUP BY  
- Aggregating by categories  

---

## 📖 Reading & Resources  

The **GROUP BY** clause divides rows into groups based on one or more column values, allowing you to apply aggregate functions like `COUNT`, `SUM`, `AVG`, etc., on each group.

### 🧩 Basic Syntax

SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1;

### 💡 Tips & Tricks

✅ Think “one row per group” — if you GROUP BY service, you get one row per service.
✅ Execution order: FROM → WHERE → GROUP BY → SELECT → ORDER BY → LIMIT
✅ Use WHERE before GROUP BY to filter rows.
✅ Use HAVING after GROUP BY to filter aggregated results.
✅ Group by multiple columns for finer granularity:

GROUP BY service, month


✅ You can order by aggregates:

SELECT service, COUNT(*) AS count
FROM patients
GROUP BY service
ORDER BY count DESC;


✅ Always name your aggregates for better readability.

### 🏋️‍♀️ Daily Challenge
### 🎯 Question:

For each hospital service, calculate:

Total number of patients admitted

Total number of patients refused

Admission rate (percentage of requests that were admitted)

Order the results by admission rate (descending).

### ✅ Query:
SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND(
        (SUM(patients_admitted) * 100.0 / 
         (SUM(patients_admitted) + SUM(patients_refused))), 
        2
    ) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;

### 🧾 Summary

The GROUP BY clause is powerful for analyzing patterns, summarizing data, and deriving insights from grouped categories in SQL.

### 🔗 Connect & Learn

💬 #SQLDailyChallenge | #IndianDataClub | #DPDzero | #RosalintCelcia | #DataAnalyticsJourney


---

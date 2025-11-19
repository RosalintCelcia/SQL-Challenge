# 📅 Day 15 — Multiple Joins in SQL

Date: 19/11
Topic: Joining More Than Two Tables + Complex Relationships

Welcome to Day 15 of my SQL learning journey!
Today’s focus was on multiple joins, where we connect three or more tables to build powerful analytical queries.

📘 Concepts Covered
🔗 Multiple Joins

Multiple joins allow combining data from several related tables into one meaningful dataset.

## Basic Syntax:
```sql
SELECT columns
FROM table1
JOIN table2 ON table1.key = table2.key
JOIN table3 ON table2.key = table3.key
LEFT JOIN table4 ON table3.key = table4.key;
```

## 🧠 How Join Order Works

Joins are evaluated left → right

Each join builds on the previous result

INNER + LEFT joins together can change results significantly

LEFT JOIN keeps all rows from the left, INNER JOIN only keeps matched rows

### 📝 Examples
1️⃣ Comprehensive service report with staff & schedules
```sql
SELECT
    sw.service,
    sw.week,
    sw.patients_admitted,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id
    AND sw.week = ss.week
WHERE sw.week = 10
GROUP BY sw.service, sw.week, sw.patients_admitted;
```

2️⃣ Patient admission with staff availability
```sql
SELECT
    p.patient_id,
    p.name,
    p.service,
    p.arrival_date,
    COUNT(DISTINCT s.staff_id) AS assigned_staff,
    AVG(ss.present) AS avg_staff_presence
FROM patients p
JOIN staff s ON p.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY p.patient_id, p.name, p.service, p.arrival_date;
```

### 💡 Tips & Tricks

✅ Start with the main table

✅ Use LEFT JOIN when you want all rows from the left

✅ Join order matters especially when mixing inner & outer joins

✅ Add join conditions carefully, sometimes referencing multiple tables

✅ Use DISTINCT or GROUP BY to avoid duplication

✅ Build queries incrementally, testing each join

## 🧩 SQL Challenge – Day 15
### Question:

Question: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, 
total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week.
Order by patients admitted descending.

### ✅ Answer Query
```sql
SELECT
    sw.service,
    sw.patients_admitted AS total_admitted,
    sw.patients_refused AS total_refused,
    sw.avg_patient_satisfaction,
    COUNT(DISTINCT s.staff_id) AS total_staff_assigned,
    SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present_week20
FROM services_weekly sw
LEFT JOIN staff s 
    ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id
    AND sw.week = ss.week
WHERE sw.week = 20
GROUP BY 
    sw.service,
    sw.patients_admitted,
    sw.patients_refused,
    sw.avg_patient_satisfaction
```


ORDER BY 
    sw.patients_admitted DESC;

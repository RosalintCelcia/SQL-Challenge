# 🕵️ SQL Murder Mystery: Who Killed the CEO?
### A Data Forensics Investigation Solved Completely Using SQL  
**By: Rosalint Celcia**

---

## 📌 Project Overview
TechNova Inc.’s CEO was found dead inside their office on **October 15th, 2025 at 9:00 PM**.  
CCTV was disabled. No witnesses. The only way to catch the killer?

👉 **Use SQL to analyze digital footprints hidden across five company databases.**

This project simulates a **real-world data investigation**, where SQL becomes the detective’s strongest weapon.

---

## 🗂️ Database Schema
The dataset includes 5 tables:

| Table | Description |
|-------|-------------|
| `employees` | Employee details |
| `keycard_logs` | Room access history |
| `calls` | Phone call records |
| `alibis` | Claimed locations |
| `evidence` | Physical evidence found |

---

## 🕵️ Investigation Workflow
1. **Identify crime scene & time**
2. **Check who entered CEO’s office around the murder window**
3. **Analyze suspicious calls (20:50–21:00)**
4. **Verify alibis vs actual movements**
5. **Match evidence to suspects**
6. **Use SQL logic intersections to identify the killer**

---

## 🧠 SQL Concepts Used
- `JOIN`
- `WHERE`, `BETWEEN`
- `GROUP BY`
- `CTE` (Common Table Expressions)
- `INTERSECT`
- Subqueries
- Forensic timeline reconstruction using SQL

---

## 🗝️ Key Investigation Queries

### **🔍 1. Who Accessed the CEO Office?**
```sql
SELECT e.name, k.entry_time
FROM keycard_logs k
JOIN employees e ON e.employee_id = k.employee_id
WHERE k.room = 'CEO Office'
  AND k.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:10';
```

### ** 📞 2. Suspicious Calls Before the Murder**
```sql
SELECT e.name, c.call_time, c.duration_sec
FROM calls c
JOIN employees e ON e.employee_id = c.caller_id
WHERE c.call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00';
```

### **❌ 3. Detecting False Alibis**
```sql
SELECT e.name, a.claimed_location, k.room AS actual_location
FROM alibis a
JOIN keycard_logs k ON a.employee_id = k.employee_id
JOIN employees e ON e.employee_id = a.employee_id
WHERE a.claimed_location != k.room;
```

### **🟥 Final Killer Identification Query**
```sql
WITH suspects AS (
   SELECT DISTINCT e.name
   FROM keycard_logs k
   JOIN employees e ON e.employee_id = k.employee_id
   WHERE k.room = 'CEO Office'
     AND k.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:10'
),
liars AS (
   SELECT DISTINCT e.name
   FROM alibis a
   JOIN keycard_logs k ON a.employee_id = k.employee_id
   JOIN employees e ON e.employee_id = k.employee_id
   WHERE a.claimed_location != k.room
),
callers AS (
   SELECT DISTINCT e.name
   FROM calls c
   JOIN employees e ON e.employee_id = c.caller_id
   WHERE c.call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00'
)

SELECT name AS killer
FROM suspects
INTERSECT
SELECT name FROM liars
INTERSECT
SELECT name FROM callers;
```

---

## 🧩 Final Outcome

Using all intersecting clues, SQL successfully identified:

### **🎯 The killer : David Kumar**
📍 The location
🕒 The timeline
🔍 The motive trail hidden inside the logs

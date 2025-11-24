# 📌 Day 18 – UNION & UNION ALL | 21-Day SQL Challenge

📅 **Date:** 24/11  
🎯 **Focus Topic:** Combining Result Sets in SQL  
📍 **Challenge By:** Indian Data Club | Sponsored by DPDzero  

---

## 📚 What I Learned Today

### 🔹 UNION vs UNION ALL

| Feature | UNION | UNION ALL |
|--------|-------|------------|
| Removes Duplicates | ✔️ Yes | ❌ No |
| Performance | Slower | Faster |
| Use Case | When unique results required | When all rows needed |

---

### 🧩 Syntax

```sql
SELECT column1, column2
FROM table1
UNION [ALL]
SELECT column1, column2
FROM table2;
```
### 📝 Key Requirements

Same number of columns in each query

Matching/compatible data types

Column names are taken from the first SELECT

ORDER BY must be applied at the end of full query

### 🏥 Practical Examples
--> Combine patient and staff names
```sql
SELECT name AS full_name, 'Patient' AS type, service
FROM patients
UNION ALL
SELECT staff_name AS full_name, 'Staff' AS type, service
FROM staff
ORDER BY service, type, full_name;
```

--> High and low performers
```sql
SELECT patient_id, name, satisfaction, 'High Performer' AS category
FROM patients WHERE satisfaction >= 90
UNION
SELECT patient_id, name, satisfaction, 'Low Performer' AS category
FROM patients WHERE satisfaction < 50
ORDER BY satisfaction DESC;
```

--> All unique services
```sql
SELECT DISTINCT service FROM patients
UNION
SELECT DISTINCT service FROM staff
UNION
SELECT DISTINCT service FROM services_weekly;
```

--> Monthly summary from different metrics
```sql
SELECT 'Admissions' AS metric, month, SUM(patients_admitted) AS value
FROM services_weekly GROUP BY month
UNION ALL
SELECT 'Refusals' AS metric, month, SUM(patients_refused) AS value
FROM services_weekly GROUP BY month
ORDER BY month, metric;
```

### 💡 Productivity Tips

🚀 Prefer UNION ALL when duplicate checks are unnecessary

🔎 Use literals to identify data sources

🔁 Avoid ORDER BY inside individual statements

🛑 Keep an eye on data type consistency

### 🏆 Daily Challenge Question:
Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id),
full name, type ('Patient' or 'Staff'), and associated service.
Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.

```sql
SELECT patient_id AS identifier, name AS full_name, 'Patient' AS type, service
FROM patients
WHERE service IN ('surgery', 'emergency')
UNION ALL
SELECT staff_id AS identifier, staff_name AS full_name, 'Staff' AS type, service
FROM staff
WHERE service IN ('surgery', 'emergency')
ORDER BY type, service, full_name;
```

✨ On to Day 19 — Let’s keep growing, one query at a time! 🚀

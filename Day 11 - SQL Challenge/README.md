# 📅 Day 11 (14/11): DISTINCT and Handling Duplicates  
**Topics:** DISTINCT, removing duplicates, unique values  

---

## 📘 Understanding DISTINCT

`DISTINCT` removes duplicate rows from your result set and returns only **unique values**.

### 🔹 Basic Syntax
```sql
SELECT DISTINCT column1, column2
FROM table_name;
```

### 🔑 Key Concepts

DISTINCT checks all selected columns together

Works as “unique combinations”

Can impact performance on large datasets

### 🧠 Tips & Tricks
✅ DISTINCT vs GROUP BY
-- These give similar results

```sql
SELECT DISTINCT service FROM patients;

SELECT service 
FROM patients
GROUP BY service;
```

✔ Use DISTINCT for unique values
✔ Use GROUP BY when applying aggregations

✅ DISTINCT applies to the entire row
-- Returns unique (service, name) pairs
```sql
SELECT DISTINCT service, name
FROM patients;
```

✅ Count unique values within groups
```sql
COUNT(DISTINCT column_name)
```

✅ Performance Note
```sql
DISTINCT can be expensive — use only when necessary.
```

✅ DISTINCT with NULL

```sql
NULL values are treated as equal, so only one NULL will appear.
```

### 📝 Daily Challenge
Question:

Find all unique combinations of service and event_type from the services_weekly table where events are not null or 'none'.
Show the count of occurrences for each combination.
Order results by count in descending order.

### ✔ Answer Query:
```sql
SELECT 
    DISTINCT service,
    event_type,
    COUNT(*) AS occurrence_count
FROM services_weekly
WHERE event_type IS NOT NULL 
  AND event_type <> 'none'
GROUP BY service, event_type
ORDER BY occurrence_count DESC;
```

🔚 End of Day 11 🚀

Stay consistent — small steps daily create big impact!

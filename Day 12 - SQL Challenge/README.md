# 📘 Day 12 (15/11): NULL Values & IS NULL / IS NOT NULL
## Topics:

NULL handling, IS NULL, IS NOT NULL, COALESCE

NULL represents missing or unknown data — it is not zero, not an empty string, and not false.
It simply indicates no value.

### 🔍 NULL Handling
Check for NULL
IS NULL
IS NOT NULL

Replace NULL with default value
COALESCE(column, default_value)

NULL-safe comparison (depends on DB)
column IS DISTINCT FROM value

### 📌 Examples
-- Find records with NULL events
```sql
SELECT * 
FROM services_weekly 
WHERE event IS NULL;
```

-- Find records with non-NULL events
```sql
SELECT * 
FROM services_weekly 
WHERE event IS NOT NULL;
```

💡 Tips & Tricks
❌ Avoid using = or != with NULL
-- Wrong
```sql
WHERE event = NULL
WHERE event != NULL
```

-- Correct
```sql
WHERE event IS NULL
WHERE event IS NOT NULL
```

🧮 Arithmetic with NULL results in NULL
5 + NULL = NULL  
NULL * 10 = NULL

🔁 COALESCE picks the first non-NULL
```sql
COALESCE(column1, column2, 'default')
```

🔢 COUNT behavior
```sql
COUNT(*) → includes NULLs

COUNT(column) → excludes NULLs
```

📑 Sort NULL values at the end
ORDER BY COALESCE(event, 'ZZZZ')

❗ Empty string ('') is NOT NULL

Check both when necessary.

### 🏆 Daily Challenge (Day 12)
Question:
Question: Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, 
and average staff morale. Order by average patient satisfaction descending.

### ✅ MySQL Query:
```sql
SELECT
    CASE 
        WHEN event IS NULL OR event = '' THEN 'No Event'
        ELSE 'With Event'
    END AS event_status,
    COUNT(*) AS week_count,
    ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction,
    ROUND(AVG(staff_morale), 2) AS avg_morale
FROM services_weekly
GROUP BY event_status
ORDER BY avg_satisfaction DESC;
```

### 🔚 End of Day 11 🚀

Stay consistent — small steps daily create big impact!
```

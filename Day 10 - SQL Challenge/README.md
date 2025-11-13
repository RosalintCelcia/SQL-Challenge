# 🧩 SQL Daily Challenge — Day 10 (13/11)
### Topic: CASE Statements

**Concepts Covered:**  
`CASE WHEN`, conditional logic, derived columns

CASE statements introduce conditional logic into SQL — similar to `if-else` in programming.  

---

### 🧱 Two Syntaxes

**1️⃣ Simple CASE:**
```sql
CASE column_name
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```
2️⃣ Searched CASE (more flexible):

```sql
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

### 💡 Tips & Tricks

✅ Always include ELSE to handle unexpected values (otherwise returns NULL)
✅ CASE is an expression, not a statement – use it anywhere you’d use a column
✅ Custom Sorting:

```sql
ORDER BY CASE 
    WHEN service = 'Emergency' THEN 1 
    WHEN service = 'ICU' THEN 2 
    ELSE 3 
END
```

✅ Conditional Aggregation Pattern:

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END) -- Count matching rows
AVG(CASE WHEN condition THEN value ELSE NULL END) -- Conditional average
```

✅ Nest CASE statements for complex logic (but consider readability)
✅ Evaluation is top-to-bottom — first match wins!

### 🎯 Daily Challenge

### 📝 Question:
Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65,
otherwise 'Needs Improvement'. Order by average satisfaction descending.

✅ Answer Query (MySQL Workbench)
```sql
SELECT 
    service,
    SUM(patients_admitted) AS total_admitted,
    AVG(patient_satisfaction) AS avg_satisfaction,
    CASE
        WHEN AVG(patient_satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(patient_satisfaction) >= 75 THEN 'Good'
        WHEN AVG(patient_satisfaction) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM 
    patients
GROUP BY 
    service
ORDER BY 
    avg_satisfaction DESC;
```

### 📘 Key Learning:

Using CASE statements allows you to categorize, filter, or even reorder data dynamically within SQL — a powerful tool for conditional reporting.

Stay tuned for Day 11 !

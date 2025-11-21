# 📅 Day 16 – Subqueries in SQL (WHERE Clause)
🚀 21-Day SQL Challenge – Indian Data Club × DPDzero

Today’s focus was on **Subqueries**, specifically inside the **WHERE** clause.  
Subqueries help filter data using results from another query—powerful for deeper insights!

---

## 🧠 Key Concepts Learned

### 🔹 What is a Subquery?
A query *inside* another query — used to:

- Filter based on dynamic data
- Check existence of records
- Compare aggregated values

---

## 🧩 Types of Subqueries Used
| Type | Use Case | Operators |
|------|----------|-----------|
| Single-value | Compare a field to a single result | =, <, > |
| Multi-value | Filter against multiple results | IN, NOT IN |
| Existence Check | Validate if condition exists in related table | EXISTS, NOT EXISTS |

---

## 🧾 Sample Queries

### ▶️ Patients from high-satisfaction services
```sql
SELECT *
FROM patients
WHERE service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING AVG(patient_satisfaction) > 80
);
```

### ▶️ Patients older than average
```sql
SELECT name, age
FROM patients
WHERE age > (
    SELECT AVG(age)
    FROM patients
);
```

### ▶️ Services with any refusals
```sql
SELECT DISTINCT service
FROM services_weekly sw1
WHERE EXISTS (
    SELECT 1
    FROM services_weekly sw2
    WHERE sw2.service = sw1.service
    AND sw2.patients_refused > 0
);
```

## ⚙ Daily Challenge

Question: Find all patients who were admitted to services that had at least one week where patients were refused AND 
the average patient satisfaction for that service was below the overall hospital average satisfaction.
Show patient_id, name, service, and their personal satisfaction score.

## ✔️ Solution Query

```sql
SELECT 
    p.patient_id,
    p.name,
    p.service,
    p.satisfaction
FROM patients p
WHERE p.service IN (
    SELECT sw.service
    FROM services_weekly sw
    GROUP BY sw.service
    HAVING 
        SUM(sw.patients_refused) > 0
        AND AVG(sw.patient_satisfaction) < (
            SELECT AVG(patient_satisfaction)
            FROM services_weekly
        )
);
```
## 💡 Key Takeaways

Subqueries add dynamic intelligence to filters

IN → great for smaller sets

EXISTS → best for performance in large datasets

Always test subqueries independently 🔍

## ✨ Consistency leads to mastery!

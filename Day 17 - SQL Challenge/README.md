# 📌 Day 17 – Subqueries in SELECT & FROM Clauses  
### 21-Day SQL Challenge – Indian Data Club × DPDzero

Today’s focus: Using **Subqueries inside SELECT** and **Derived Tables (FROM Subqueries)** to build smarter analytical queries.

---

## 📚 Topics Covered
🔹 Subqueries in `SELECT` for calculated values  
🔹 Subqueries in `FROM` as inline views / derived tables  
🔹 Using CROSS JOIN for global metrics  
🔹 Organizing complex logic with nested queries  

---

## 🧠 Key Concepts

### 🏗️ Subquery in SELECT  
Used when a **single aggregated value** is needed per row:

```sql
SELECT 
    service,
    COUNT(*) AS patient_count,
    COUNT(*) - (
        SELECT AVG(service_count)
        FROM (
            SELECT COUNT(*) AS service_count 
            FROM patients 
            GROUP BY service
        )
    ) AS diff_from_avg
FROM patients
GROUP BY service;
```

### 📊 Subquery in FROM (Derived Tables)

Used for intermediate calculations:
```sql
SELECT 
    service,
    total_admitted,
    CASE 
        WHEN total_admitted > avg_admitted THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM (
    SELECT 
        service,
        SUM(patients_admitted) AS total_admitted,
        (
            SELECT AVG(total) 
            FROM (
                SELECT SUM(patients_admitted) AS total
                FROM services_weekly
                GROUP BY service
            )
        ) AS avg_admitted
    FROM services_weekly
    GROUP BY service
) AS service_stats;
```

### 📌 Weekly Metrics Using Cross Join
```sql
SELECT 
    week_stats.*, 
    overall.avg_satisfaction AS hospital_avg_satisfaction
FROM (
    SELECT 
        week,
        AVG(patient_satisfaction) AS weekly_avg_satisfaction,
        SUM(patients_admitted) AS weekly_admissions
    FROM services_weekly
    GROUP BY week
) AS week_stats
CROSS JOIN (
    SELECT AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
) AS overall;
```

## 💡 Tips & Tricks
Concept	Best Practice
Alias Required	Always alias derived tables
Subquery in SELECT	Must return a single value
Performance	Correlated subqueries run per row — use wisely
Query Design	Use derived tables to break down complex logic
Coming Soon	CTEs (Day 21) are even cleaner!
🎯 Daily Challenge

## Question:
Question: Create a report showing each service with: service name, total patients admitted,
the difference between their total admissions and the average admissions across all services,
and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.

## Solution Query:
```sql
SELECT
    svc.service AS service_name,
    svc.total_admitted AS total_patients_admitted,
    ROUND(svc.total_admitted - avg_table.avg_patients, 2) AS diff_btw_total_and_avg,
    CASE
        WHEN svc.total_admitted > avg_table.avg_patients THEN 'Above Average'
        WHEN svc.total_admitted = avg_table.avg_patients THEN 'Average'
        ELSE 'Below Average'
    END AS rank_indicator
FROM 
    (
        SELECT
            service,
            SUM(patients_admitted) AS total_admitted
        FROM services_weekly
        GROUP BY service
    ) AS svc
CROSS JOIN
    (
        SELECT AVG(total_patients) AS avg_patients
        FROM (
            SELECT SUM(patients_admitted) AS total_patients
            FROM services_weekly
            GROUP BY service
        ) AS inner_avg
    ) AS avg_table
ORDER BY
    svc.total_admitted DESC;
``` 

🚀 Learning Boost: Today’s queries show how SQL can analyze data at multiple levels at once!

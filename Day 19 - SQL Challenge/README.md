### 📌 Day 19 – Window Functions: Rankings in SQL
### 🚀 21-Day SQL Challenge — Indian Data Club x DPDzero
## 📚 Topics Covered:

ROW_NUMBER()

RANK()

DENSE_RANK()

OVER with PARTITION BY & ORDER BY

Window functions allow analytics without reducing rows like GROUP BY, making them powerful for ranking, trends & insights.

### 🧠 Key Concepts
Function	Behavior	Handling of Ties
ROW_NUMBER()	Assigns unique numbers	No ties — always sequential
RANK()	Ranking with gaps	Ties share same rank (1,2,2,4)
DENSE_RANK()	Ranking without gaps	Ties share same rank (1,2,2,3)

### 📌 Syntax:

```sql
window_function() OVER (
    [PARTITION BY column]
    ORDER BY column
)

```

### 📝 Example Queries
-- Sequential numbering of patients by highest satisfaction within each service

```sql
SELECT patient_id, name, service, satisfaction,
    ROW_NUMBER() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS row_num
FROM patients;

```

-- Ranking across the hospital

```sql
SELECT patient_id, name, satisfaction,
    RANK() OVER (ORDER BY satisfaction DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY satisfaction DESC) AS dense_rank
FROM patients;

```

-- Top 3 weeks by satisfaction within each service


```sql
SELECT *
FROM (
    SELECT service, week, patient_satisfaction,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS sat_rank
    FROM services_weekly
)
WHERE sat_rank <= 3;

-- Rank services by total admissions
SELECT service,
    SUM(patients_admitted) AS total_admitted,
    RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS admission_rank
FROM services_weekly
GROUP BY service;

```
### 💡 Tips & Tricks

✔ Use PARTITION BY to restart rankings within groups
✔ Filter ranks using subqueries (not directly in WHERE)
✔ Window functions preserve all rows
✔ Use correct function based on tie requirements

### 🎯 Daily Challenge Task

Rank weeks by patient satisfaction (highest first) for each service. Only show Top 3 per service.

```sql
SELECT
    service,
    week,
    patient_satisfaction,
    patients_admitted,
    week_rank
FROM (
    SELECT
        service,
        week,
        patient_satisfaction,
        patients_admitted,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS week_rank
    FROM services_weekly
) AS ranked_weeks
WHERE week_rank <= 3
ORDER BY service, week_rank;

```

### 🔗 Challenge Credits

Thanks to Indian Data Club & DPDzero for this learning journey! 🙌

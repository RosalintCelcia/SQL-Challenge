📅 Day 21 (27/11): Common Table Expressions (CTEs)

Today’s focus: WITH clause, CTEs, recursive CTEs (if applicable), and query organization.
CTEs help break down complex queries into readable, manageable steps — perfect for analytics and real-world SQL problem-solving.

📘 What Are CTEs?

CTEs (Common Table Expressions) create temporary named result sets that exist only during query execution.

They make queries:

More readable

Easier to debug

Easier to maintain

Step-by-step like Python functions ⬆️

🧱 Basic Syntax
```sql
WITH cte_name AS (
    SELECT columns
    FROM table
    WHERE condition
)
SELECT *
FROM cte_name;

🔗 Multiple CTEs
WITH cte1 AS (
    SELECT ...
),
cte2 AS (
    SELECT ...
)
SELECT *
FROM cte1
JOIN cte2 ON ...;
```

💡 Examples
📊 Simple CTE for Service Statistics
```sql
WITH service_stats AS (
    SELECT 
        service,
        COUNT(*) AS patient_count,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
)
SELECT *
FROM service_stats
WHERE avg_satisfaction > 75
ORDER BY patient_count DESC;
```

🛠️ Tips & Tricks
✅ Break Down Complex Queries with Step-by-Step CTEs
```sql
WITH step1 AS (SELECT ...),
step2 AS (SELECT ... FROM step1),
step3 AS (SELECT ... FROM step2)
SELECT *
FROM step3;
```

✅ CTEs vs Subqueries

CTEs: More readable, reusable
Subqueries: More concise for simple tasks

-- CTE (readable & reusable)
```sql
WITH avg_age AS (
    SELECT AVG(age) FROM patients
)
SELECT *
FROM patients, avg_age
WHERE age > avg_age;
```sql

-- Subquery (simple)
```sql
SELECT *
FROM patients
WHERE age > (SELECT AVG(age) FROM patients);
```

🔁 CTEs Can Be Referenced Multiple Times
```sql
WITH service_avg AS (
    SELECT 
        service,
        AVG(satisfaction) AS avg_sat
    FROM patients
    GROUP BY service
)
SELECT *
FROM patients p
JOIN service_avg sa 
    ON p.service = sa.service
WHERE p.satisfaction > sa.avg_sat;
```

📝 Use Descriptive CTE Names
-- ❌ WITH x AS (...), y AS (...), z AS (...)
-- ✅ WITH patient_stats AS (...),
--        staff_summary AS (...),
--        weekly_trends AS (...)

🧪 CTEs Improve Debugging

-- Test CTE 1
```sql
WITH cte1 AS (SELECT ...)
SELECT * FROM cte1;
```

-- Then add next CTE
```sql
WITH cte1 AS (...),
cte2 AS (...)
SELECT * FROM cte2;
```

### ⚠️ Note

CTEs are not materialized by default in many SQL engines.
If reused many times for expensive calculations → consider temporary tables.

### 🏆 Daily Challenge

**Question:** Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction), 2)
Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report showing service name, 
all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.

Question Breakdown: 

Create a comprehensive hospital performance dashboard using CTEs.

Your output should include:

1️⃣ Service-Level Metrics

Total admissions

Total refusals

Average satisfaction

2️⃣ Staff Metrics per Service

Total staff

Average weeks present

3️⃣ Patient Demographics

Average age

Total patients

4️⃣ Combine all CTEs → Final report

Service name

All metrics

Performance Score

Weighted avg of admission rate + satisfaction

5️⃣ Order by performance score DESC


### ✅ SQL Answer – Hospital Performance Dashboard Using CTEs

```sql
WITH
-- 1️⃣ Service-Level Metrics
service_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_admissions,
        SUM(CASE WHEN status = 'refused' THEN 1 ELSE 0 END) AS total_refusals,
        ROUND(AVG(satisfaction), 2) AS avg_satisfaction
    FROM patients
    GROUP BY service
),

-- 2️⃣ Staff Metrics per Service
staff_metrics AS (
    SELECT
        service,
        COUNT(staff_id) AS total_staff,
        ROUND(AVG(weeks_present), 2) AS avg_weeks_present
    FROM staff
    GROUP BY service
),

-- 3️⃣ Patient Demographics per Service
patient_demo AS (
    SELECT
        service,
        ROUND(AVG(age), 2) AS avg_age,
        COUNT(*) AS patient_count
    FROM patients
    GROUP BY service
),

-- 4️⃣ Combine all three CTEs into a final report
combined AS (
    SELECT
        sm.service,
        sm.total_admissions,
        sm.total_refusals,
        sm.avg_satisfaction,
        st.total_staff,
        st.avg_weeks_present,
        pd.avg_age,
        pd.patient_count,

        -- Performance Score (weighted metrics)
        ROUND(
            (
                -- 60% weight: admission rate (higher is better)
                (sm.total_admissions::float / NULLIF((sm.total_admissions + sm.total_refusals), 0)) * 0.60
                +
                -- 40% weight: satisfaction score normalized to 0–1
                (sm.avg_satisfaction / 100) * 0.40
            ), 
        3) AS performance_score
    FROM service_metrics sm
    LEFT JOIN staff_metrics st ON sm.service = st.service
    LEFT JOIN patient_demo pd ON sm.service = pd.service
)

-- 5️⃣ Final Output Ordered by Performance Score
SELECT *
FROM combined
ORDER BY performance_score DESC;
```

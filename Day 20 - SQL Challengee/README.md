### 📅 Day 20 (26/11): Window Functions – Aggregate Window Functions

Today focuses on aggregate window functions — essential for trend analysis, running totals, and moving averages without reducing your dataset.

## 📘 Topics Covered

SUM() OVER

AVG() OVER

Running totals

Moving averages

Window frames (ROWS BETWEEN ...)

### 🔍 What Are Aggregate Window Functions?

Aggregate window functions apply calculations over a group of rows related to the current row — without collapsing rows like GROUP BY does.

Common Window Aggregates
SUM(column) OVER (...)      
AVG(column) OVER (...)      
COUNT(*) OVER (...)         
MIN(column) OVER (...)      
MAX(column) OVER (...)      

### 🎯 Window Frame Clauses

Define how many rows to include in the window:

ROWS BETWEEN start AND end


### Start / End Options:

UNBOUNDED PRECEDING: From the first row

N PRECEDING: N rows before

CURRENT ROW: Current row

N FOLLOWING: N rows ahead

UNBOUNDED FOLLOWING: Until last row

### 📌 Examples
✅ Running Total of Patients Admitted
```sql
SELECT
    service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions
FROM services_weekly
ORDER BY service, week;
```

✅ 3-Week Moving Average
```sql
SELECT
    service,
    week,
    patient_satisfaction,
    ROUND(
        AVG(patient_satisfaction) OVER (
            PARTITION BY service
            ORDER BY week
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS moving_avg_3week
FROM services_weekly
ORDER BY service, week;
```

✅ Compare With Service Average
```sql
SELECT
    service,
    week,
    patients_admitted,
    AVG(patients_admitted) OVER (PARTITION BY service) AS service_avg,
    patients_admitted
        - AVG(patients_admitted) OVER (PARTITION BY service) AS diff_from_avg
FROM services_weekly;
```

✅ Running Min / Max
```sql
SELECT
    service,
    week,
    patient_satisfaction,
    MIN(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS min_so_far,
    MAX(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS max_so_far
FROM services_weekly;
```

###💡 Tips & Tricks

With ORDER BY, window defaults to:

ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


Without ORDER BY, function applies to the entire partition

Moving averages require explicit frame definitions

Use window aggregates for % totals, deviations, trend indicators

Window functions cannot be nested, but you can reference multiple in one query

### 🧠 Daily Challenge Question

## Question: 

Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative),
3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average.
Filter for weeks 10-20 only.

### 📝 Daily Challenge Answer Query
```sql
SELECT
    service,
    week,
    patients_admitted,

    -- Running total of admissions
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions,

    -- 3-week moving average of satisfaction
    ROUND(
        AVG(patient_satisfaction) OVER (
            PARTITION BY service
            ORDER BY week
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS moving_avg_3week,

    -- Difference from service-wide average admissions
    patients_admitted
        - AVG(patients_admitted) OVER (PARTITION BY service)
        AS diff_from_service_avg

FROM services_weekly
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;
```

# 📘 Day 5 - SQL Daily Challenge  
### Topic: Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)  
**Challenge Series by [Indian Data Club](https://www.linkedin.com/company/indiandataclub/) x [DPDzero](https://www.linkedin.com/company/dpdzero/)**  

---

## 🧠 Concept Overview

Aggregate functions perform calculations across multiple rows and return a single summarized value.

### 🔹 The Five Core Aggregates:
| Function | Description |
|-----------|--------------|
| `COUNT(*)` | Counts all rows (including NULLs) |
| `COUNT(column)` | Counts only non-NULL values |
| `COUNT(DISTINCT column)` | Counts unique non-NULL values |
| `SUM(column)` | Adds up numeric values |
| `AVG(column)` | Calculates the average value |
| `MIN(column)` | Finds the minimum value |
| `MAX(column)` | Finds the maximum value |

---

## 🧩 Example Queries

### 🧾 Single Aggregate
SELECT COUNT(*) AS total_patients
FROM patients;

### 📊 Multiple Aggregates
SELECT
    COUNT(*) AS total,
    AVG(age) AS avg_age,
    MIN(age) AS youngest,
    MAX(age) AS oldest,
    SUM(satisfaction) AS total_satisfaction
FROM patients;

### 🩺 With WHERE Clause
SELECT AVG(satisfaction)
FROM patients
WHERE service = 'Cardiology';

### 💡 Tips & Tricks

✅ COUNT(*) vs COUNT(column):

COUNT(*) counts all rows (including NULLs)

COUNT(column) counts only non-NULL values

✅ Round averages for cleaner output:

SELECT ROUND(AVG(age), 2) AS avg_age
FROM patients;


✅ Aggregates ignore NULL values (except COUNT(*))
✅ Use DISTINCT with COUNT to count unique values:

SELECT COUNT(DISTINCT service) AS unique_services
FROM patients;

### 🎯 Day 5 Challenge
### Question:

Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks.
Round the average satisfaction to 2 decimal places.

### Answer:
SELECT 
    SUM(patients_admitted) AS Admitted_Patients,
    SUM(patients_refused) AS Refused_Patients,
    ROUND(AVG(patient_satisfaction), 2) AS Patients_Satisfaction
FROM services_weekly;


### 📊 Result:
This query provides a summarized view of hospital metrics — total admissions, refusals, and overall satisfaction.

### 🧠 Key Learning Outcomes

Mastered use of core SQL aggregate functions.

Learned to calculate summaries and averages efficiently.

Practiced rounding and filtering with conditional clauses.

Explored ways to handle NULL values and unique counts.

### 🚀 Challenge Series

This challenge is part of the 21 Days SQL Challenge powered by Indian Data Club & DPDzero — designed to help data enthusiasts strengthen their SQL fundamentals through hands-on problem-solving.

### 📅 Day 5 Completed!
Next up: Day 6 — stay tuned for more SQL adventures!


🧑‍💻 GitHub - RosalintCelcia

🌐 Indian Data Club

🚀 DPDzero

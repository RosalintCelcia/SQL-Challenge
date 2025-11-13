# 🏥 Day 2 — Filtering Data with WHERE Clause

21 Days SQL Challenge with Indian Data Club (Powered by DPDzero)

### 🎯 Topics Covered

WHERE clause

Comparison operators (=, !=, >, <, >=, <=)

Logical operators (AND, OR, NOT)

Pattern and range filters (LIKE, IN, BETWEEN)

### 📘 Concept Overview

The WHERE clause filters records based on given conditions, allowing analysts to retrieve only the relevant rows. It forms the backbone of conditional data retrieval in SQL.

Syntax:
```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

🧠 Example Queries
-- Single condition
```sql
SELECT * FROM patients WHERE age > 60;
```

-- Multiple conditions
```sql
SELECT * FROM patients
WHERE age > 60 AND service = 'Cardiology';
```

-- OR condition
```sql
SELECT * FROM patients
WHERE service = 'Emergency' OR service = 'Cardiology';
```

-- IN operator (cleaner than multiple ORs)
```sql
SELECT * FROM patients
WHERE service IN ('Emergency', 'Cardiology', 'Neurology');
```

💡 Tips & Tricks

✅ Use IN instead of multiple ORs for readability.
✅ Strings need single quotes ' ', numbers don’t.
✅ Use parentheses with mixed AND/OR.
✅ BETWEEN is inclusive (18 and 65 included).
✅ Check for NULL values with IS NULL / IS NOT NULL.

Example:
```sql
WHERE (age < 18 OR age > 65) AND service = 'Emergency';
```

🧩 Practice Questions

1️⃣ Find all patients who are older than 60 years.
2️⃣ Retrieve all staff members who work in the 'Emergency' service.
3️⃣ List all weeks where more than 100 patients requested admission in any service.

🚀 Daily Challenge

Question:
Find all patients admitted to 'Surgery' service with a satisfaction score below 70.

Answer:
```sql
SELECT patient_id, name, age, satisfaction AS satisfaction_score
FROM patients
WHERE service = 'Surgery' AND satisfaction < 70;
```
🌱 Reflection

Filtering is where data turns from raw to relevant.
The WHERE clause doesn’t just limit data — it reveals the patterns, insights, and decisions hidden within.

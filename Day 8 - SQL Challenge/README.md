# 🧠 SQL Daily Challenge - Day 8 (11/11): String Functions

## 📚 Topics Covered
**String Functions:**  
`UPPER()`, `LOWER()`, `LENGTH()`, `CONCAT()`, `SUBSTRING()`, `TRIM()`, `REPLACE()`

String functions help manipulate and format text data directly within SQL queries — useful for cleaning, transforming, or standardizing textual columns like names, addresses, or services.

---

## 🧩 Example Concepts

-- Convert to uppercase
SELECT UPPER(name) AS name_upper FROM patients;

-- Concatenate columns
SELECT CONCAT(name, ' - ', service) AS patient_info FROM patients;

-- Get name length
SELECT name, LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 15;

-- Extract substring (first 3 characters)
SELECT SUBSTRING(name, 1, 3) AS name_abbr FROM patients;

-- Replace text
SELECT REPLACE(service, 'Emergency', 'ER') AS service_abbr
FROM patients;

## 💡 Tips & Tricks

Use || or CONCAT() for joining strings:

-- SQLite/PostgreSQL:
name || ' - ' || service
-- MySQL:
CONCAT(name, ' - ', service)


## TRIM functions:

LTRIM() → remove left spaces

RTRIM() → remove right spaces

TRIM() → remove both sides

Case-insensitive comparison:

WHERE LOWER(name) = LOWER('john smith')


Avoid string functions in WHERE when using indexes (they affect performance).

## 🧮 Challenge Question
## Task:

Create a patient summary that shows:

patient_id

full name in uppercase

service in lowercase

age category:

'Senior' if age >= 65

'Adult' if age >= 18

'Minor' otherwise

name length

👉 Only include patients whose name length is greater than 10 characters.

## ✅ SQL Solution
SELECT
    patient_id,
    UPPER(name) AS full_name_upper,
    LOWER(service) AS service_lower,
    CASE
        WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_category,
    LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;

## 🧠 Key Learnings

Used UPPER() and LOWER() to standardize text.

Derived an age category using a CASE expression.

Applied LENGTH() to filter and display name length.

Combined multiple string operations for cleaner, formatted summaries.

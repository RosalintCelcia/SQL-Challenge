# 📘 Day 4 - SQL Daily Challenge  
### Topic: LIMIT, OFFSET & Pagination Concepts  
**Challenge Series by [Indian Data Club](https://www.linkedin.com/company/indiandataclub/) x [DPDzero](https://www.linkedin.com/company/dpdzero/)**  

---

## 🧠 Concept Overview

### 🔹 LIMIT  
Restricts the number of rows returned from the result set.

### 🔹 OFFSET  
Skips a specified number of rows before returning the remaining results.

✅ **Use Case:**  
Pagination — splitting query results into multiple pages (useful for dashboards and large datasets).

---

## 🧩 Basic Syntax

```sql
-- Using LIMIT
SELECT columns
FROM table_name
LIMIT number_of_rows;

-- Using OFFSET
SELECT columns
FROM table_name
LIMIT number_of_rows OFFSET skip_rows;

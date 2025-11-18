# 📘 Day 14 (18/11): LEFT JOIN & RIGHT JOIN

## SQL Daily Challenge – Indian Data Club x DPDzero

Today’s focus was on LEFT JOIN and RIGHT JOIN, essential for combining tables while keeping unmatched rows. These joins help ensure that no important data gets left out—even when one table doesn’t have corresponding records.

### 🔍 Topics Covered

▪️LEFT JOIN

▪️RIGHT JOIN

▪️Handling unmatched / missing records

N▪️ULL handling with COALESCE

▪️Finding non-matching rows

▪️Difference between JOIN types

### 🧠 Concept Summary
## LEFT JOIN

Returns all rows from the left table and matching rows from the right table.
If no match → NULL on the right side.

```sql
SELECT columns
FROM table1
LEFT JOIN table2 ON table1.column = table2.column;
```

## RIGHT JOIN

Returns all rows from the right table and matching rows from the left table.

```sql
SELECT columns
FROM table1
RIGHT JOIN table2 ON table1.column = table2.column;
```

## INNER vs LEFT vs RIGHT
JOIN        -> Type	Returns
INNER JOIN	-> Only matching rows
LEFT JOIN   -> All left table rows + matching right table rows
RIGHT JOIN  -> 	All right table rows + matching left table rows

### 📝 Examples
1️⃣ Staff with their schedule (even if no schedule exists)
```sql
SELECT
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COUNT(ss.week) AS weeks_scheduled,
    SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service;
```

2️⃣ Staff with NO schedule records
```sql
SELECT s.*
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
WHERE ss.staff_id IS NULL;
```

3️⃣ All services and patient counts (including empty services)
```sql
SELECT
    sw.service,
    sw.week,
    COUNT(p.patient_id) AS patient_count
FROM services_weekly sw
LEFT JOIN patients p ON sw.service = p.service
GROUP BY sw.service, sw.week;
```

### 💡 Tips & Tricks
✅ Rewrite RIGHT JOIN using LEFT JOIN

Swap table positions!

Equivalent to RIGHT JOIN:
```sql
FROM table2 LEFT JOIN table1 ON ...
```

✅ Use COALESCE to replace NULL

Especially useful in LEFT JOIN results.

COALESCE(ss.present, 0)

✅ Find unmatched rows
WHERE table2.column IS NULL

✅ WHERE vs ON in LEFT JOIN

ON → filters before join (keeps all left rows)

WHERE → filters after join (may remove left rows)

### 🏆 Daily Challenge
#### Question:

Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule). Include staff members even if they have no schedule records. Order by weeks present descending..

#### ✔️ Solution Query
```sql
SELECT
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COALESCE(SUM(ss.present), 0) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss 
    ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present DESC, s.staff_name;
```

### 📅 Day 14 Completed!

Moving forward step-by-step, mastering joins and relational data deeper each day.

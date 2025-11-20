-- Mini Project:
-- 1. Create the pizza_types table (No Foreign Keys)

CREATE DATABASE IDC_Pizza;
-- Create tables for MySQL (adapted from PostgreSQL script)

-- Phase 1: Foundation & Inspection
-- 1.Install IDC_Pizza.dump as IDC_Pizza server
-- 1. Create the pizza_types table (No Foreign Keys)
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY, -- e.g., 'bbq_ckn'
    name VARCHAR(100),                      -- e.g., 'The Barbecue Chicken Pizza'
    category VARCHAR(50),                   -- e.g., 'Chicken'
    ingredients TEXT                        -- e.g., 'Barbecued Chicken, Red Peppers, ...'
);

-- 2. Create the pizzas table (FK to pizza_types)
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,       -- e.g., 'bbq_ckn_s'
    pizza_type_id VARCHAR(50),
    size VARCHAR(10),                       -- e.g., 'S', 'M', 'L'
    price DECIMAL(5, 2),                    -- e.g., 12.75
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);

-- 3. Create the orders table (No Foreign Keys)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

-- 4. Create the order_details table (FK to orders and pizzas)
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);

-- Verify the Data Loaded
SELECT COUNT(*) AS pizza_types_count FROM pizza_types;
SELECT COUNT(*) AS pizzas_count FROM pizzas;
SELECT COUNT(*) AS orders_count FROM orders;
SELECT COUNT(*) AS order_details_count FROM order_details;

-- 2.List all unique pizza categories (DISTINCT).
SELECT DISTINCT category 
FROM pizza_types 
ORDER BY category;

/* 3.Display pizza_type_id, name, and ingredients, 
replacing NULL ingredients with "Missing Data". First 5 rows */
SELECT 
    pizza_type_id,
    name,
    COALESCE(ingredients, 'Missing Data') AS ingredients
FROM pizza_types
LIMIT 5;

-- 4.Check for pizzas missing a price
SELECT pizza_id, pizza_type_id, size, price
FROM pizzas
WHERE price IS NULL;

-- Phase 2: Filtering & Exploration
-- 1. Orders placed on '2015-01-01'
SELECT *
FROM orders
WHERE date = '2015-01-01';

-- 2.List pizzas with price descending 
SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC;

-- 3.Pizzas sold in sizes 'L' or 'XL'
SELECT DISTINCT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE p.size IN ('L', 'XL')
ORDER BY pt.name, p.size;

-- 4. Pizzas priced between $15.00 and $17.00
SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE p.price BETWEEN 15.00 AND 17.00
ORDER BY p.price;

-- 5.Pizzas with "Chicken" in the name
SELECT pizza_type_id, name, category
FROM pizza_types
WHERE name LIKE '%Chicken%';

-- 6.Orders on '2015-02-15' or placed after 8 PM (20:00)
SELECT order_id, date, time
FROM orders
WHERE date = '2015-02-15'
   OR time > '20:00:00'
ORDER BY date, time;

-- Phase 3: Sales Performance

-- 1.Total quantity of pizzas sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM order_details;

-- 2.Average pizza price
SELECT ROUND(AVG(price), 2) AS avg_pizza_price
FROM pizzas;

-- 3.Total order value per order
SELECT 
    o.order_id,
    ROUND(SUM(p.price * od.quantity), 2) AS total_order_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY o.order_id
ORDER BY total_order_value DESC
LIMIT 10;  -- remove LIMIT to see all

-- 4.Total quantity sold per pizza category
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity_sold DESC;

-- 5.Categories with more than 5,000 pizzas sold
SELECT 
    pt.category,
    SUM(od.quantity) AS total_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity) > 5000
ORDER BY total_sold DESC;

-- 6.Pizzas never ordered
SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
LEFT JOIN order_details od ON p.pizza_id = od.pizza_id
WHERE od.pizza_id IS NULL
ORDER BY pt.name;

-- 7.Price differences between different sizes of the same pizza
SELECT 
    pt.name,
    p1.size AS size1,
    p1.price AS price1,
    p2.size AS size2,
    p2.price AS price2,
    ROUND(p2.price - p1.price, 2) AS price_difference
FROM pizzas p1
JOIN pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id 
              AND p1.size < p2.size
JOIN pizza_types pt ON p1.pizza_type_id = pt.pizza_type_id
ORDER BY pt.name, p1.size;
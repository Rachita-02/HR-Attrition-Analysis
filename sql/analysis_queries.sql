-- ================================================
-- HR ATTRITION ANALYSIS - SQL QUERIES
-- Author: Rachita
-- Database: hr_attrition_db
-- ================================================

-- Query 1: Overall attrition rate
SELECT
    COUNT(*) AS total_employees,
    SUM("AttritionNum") AS employees_left,
    ROUND(SUM("AttritionNum")*100.0/COUNT(*), 2) AS attrition_rate_pct
FROM hr_data;

-- Query 2: Overtime impact on attrition
SELECT
    "OverTime",
    COUNT(*) AS total_employees,
    SUM("AttritionNum") AS employees_left,
    ROUND(SUM("AttritionNum")*100.0/COUNT(*), 2) AS attrition_pct
FROM hr_data
GROUP BY "OverTime"
ORDER BY attrition_pct DESC;

-- Query 3: Avg salary left vs stayed
SELECT
    "Attrition",
    ROUND(AVG("MonthlyIncome"), 0) AS avg_monthly_salary,
    ROUND(AVG("YearsAtCompany"), 1) AS avg_tenure_years
FROM hr_data
GROUP BY "Attrition";

-- Query 4: Attrition by salary slab
SELECT
    "SalarySlab",
    COUNT(*) AS total_employees,
    SUM("AttritionNum") AS employees_left,
    ROUND(SUM("AttritionNum")*100.0/COUNT(*), 2) AS attrition_pct
FROM hr_data
GROUP BY "SalarySlab"
ORDER BY attrition_pct DESC;

-- Query 5: Attrition by tenure group
SELECT
    "TenureGroup",
    COUNT(*) AS total_employees,
    SUM("AttritionNum") AS employees_left,
    ROUND(SUM("AttritionNum")*100.0/COUNT(*), 2) AS attrition_pct
FROM hr_data
GROUP BY "TenureGroup"
ORDER BY attrition_pct DESC;

-- Query 6: Risk categorization using CASE WHEN
SELECT
    "Department",
    "JobRole",
    "MonthlyIncome",
    "JobSatisfaction",
    "OverTime",
    CASE
        WHEN "JobSatisfaction" <= 2
        AND "OverTime" = 'Yes' THEN 'High Risk'
        WHEN "JobSatisfaction" = 3
        OR "OverTime" = 'Yes' THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM hr_data
WHERE "Attrition" = 'Yes'
ORDER BY "MonthlyIncome" ASC;

-- Query 7: Rank dept+jobrole using WINDOW FUNCTION
SELECT
    "Department",
    "JobRole",
    COUNT(*) AS total,
    SUM("AttritionNum") AS left_count,
    ROUND(SUM("AttritionNum")*100.0/COUNT(*), 2) AS attrition_pct,
    RANK() OVER (
        ORDER BY SUM("AttritionNum")*100.0/COUNT(*) DESC
    ) AS attrition_rank
FROM hr_data
GROUP BY "Department", "JobRole"
ORDER BY attrition_rank;

-- Query 8: Departments vs company average using CTE
WITH dept_attrition AS (
    SELECT
        "Department",
        ROUND(SUM("AttritionNum")*100.0/COUNT(*), 2) AS attrition_pct
    FROM hr_data
    GROUP BY "Department"
),
avg_attrition AS (
    SELECT ROUND(AVG(attrition_pct), 2) AS overall_avg
    FROM dept_attrition
)
SELECT
    d."Department",
    d.attrition_pct,
    a.overall_avg,
    CASE
        WHEN d.attrition_pct > a.overall_avg THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM dept_attrition d
CROSS JOIN avg_attrition a
ORDER BY d.attrition_pct DESC;

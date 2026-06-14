# HR Attrition Analysis — End to End Project

## 🎯 Problem Statement
IBM wants to understand why employees leave and identify
which departments and roles are at highest attrition risk
so HR team can take preventive action.

## 🛠️ Tools Used
- Python (Pandas, Matplotlib, Seaborn) — Data cleaning & EDA
- PostgreSQL — Data storage & SQL analysis  
- Power BI — Interactive dashboard

## 📊 Dataset
- Source: IBM HR Analytics Dataset (Kaggle)
- Size: 1470 employees, 35 columns
- Type: Employee demographics, satisfaction scores, attrition status

## 🔄 Project Workflow
Raw CSV → Python Cleaning → PostgreSQL → Power BI Dashboard

## 📁 Project Structure
HR_Attrition_Project/
├── data/
│   ├── WA_Fn-UseC_-HR-Employee-Attrition.csv
│   └── hr_data_cleaned.csv
├── notebooks/
│   └── hr_attrition_analysis.ipynb
├── sql/
│   └── analysis_queries.sql
├── screenshots/
│   ├── heatmap.png
│   └── dashboard.png
└── README.md

## 🐍 Python / Pandas — What I Did
- Loaded raw dataset (1470 rows, 35 columns)
- Cleaned column names using str.strip()
- Removed 10 duplicate Employee IDs
- Filled 57 missing values in YearsWithCurrManager with median
- Dropped 3 constant columns (EmployeeCount, Over18, StandardHours)
- Created AttritionNum column (Yes=1, No=0)
- Feature Engineering:
  - TenureGroup — bucketed YearsAtCompany into 4 groups
  - OverallSatisfaction — combined 3 satisfaction scores
  - HighRisk flag — employees with overtime + low satisfaction

## 🗄️ SQL / PostgreSQL — What I Did
- Created hr_attrition_db database
- Loaded cleaned data using SQLAlchemy (df.to_sql)
- Wrote 8 analytical queries covering:
  - Basic aggregations (COUNT, SUM, AVG, ROUND)
  - GROUP BY analysis for department, role, salary, tenure
  - CASE WHEN for risk categorization
  - WINDOW FUNCTION (RANK) for department ranking
  - CTE for benchmarking against company average

## 📈 Power BI — Dashboard Visuals
1. KPI Cards — Total Employees, Attrition Count,
               Attrition Rate, Avg Salary, Avg Tenure
2. Combo Chart — Attrition Count & Rate by Age Group
3. Bar Chart — Attrition by Job Role
4. Donut Chart — Attrition by Department
5. Donut Chart — Attrition by Gender
6. Donut Chart — Attrition by Education
7. Column Chart — Attrition by Salary Slab
8. Matrix — Overtime Impact by Department
9. Slicers — Department, Age Group, Salary Slab

## 💡 Key Business Insights
1. Overall attrition rate is 16.12% — 237 out of 1470 employees left
2. Sales department has highest attrition at 20.63%
3. Employees doing overtime have 30%+ attrition vs 10% without
4. Upto 5k salary slab has highest attrition — low pay = high exit
5. 26-35 age group has highest attrition count
6. Male employees leave more (63.29%) than female (36.71%)
7. Life Sciences education field has highest attrition (37.55%)
8. Sales Representatives have highest role-wise attrition (40 employees)

## 📸 Dashboard Screenshot
!HR Attrition Dashboard(screenshot) 

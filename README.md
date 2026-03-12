# loan-portfolio-risk-analysis
End-to-end data analysis project exploring loan portfolio risk, borrower behavior, and lending performance using SQL, Python, and Power BI.
# Loan Portfolio Risk & Performance Analysis

This project analyzes a consumer lending dataset to understand borrower behavior, loan distribution, repayment patterns, and portfolio risk.

The goal was to perform an **end-to-end analytics workflow**, starting from raw data preparation to building an interactive dashboard for business insights.

---

# Project Workflow

The analysis was completed in four stages:

### 1. Data Preparation (Python)

The raw dataset was cleaned and structured using Python.

Tasks performed:
- Handling missing values
- Creating additional analytical fields
- Structuring the dataset for relational modeling
- Preparing cleaned CSV files for database import

Tool used:
- Python (Pandas)

Notebook:
`data_preparation.ipynb`

---

### 2. Data Modeling (SQL)

The dataset was normalized into relational tables:

- customers
- loans
- payments
- credit_profile

This allowed analysis of borrower characteristics, loan performance, and repayment behaviour.

The relational structure was visualized using an **ER Diagram**.

![ER Diagram](Business_Analytics_ER-Diagrams.png)

---

### 3. Data Analysis (SQL)

Analytical queries were written to extract insights such as:

- Loan distribution by purpose
- Average interest rate by loan grade
- Delinquency risk patterns
- Borrower risk segmentation
- Portfolio exposure by credit grade

SQL file:
`banking_analytics.sql`

---

### 4. Data Visualization (Power BI)

The analyzed dataset was used to create an interactive dashboard that explores:

- Loan portfolio overview
- Borrower income vs loan size
- Repayment behaviour
- Risk distribution
- Portfolio exposure

---

# Dashboard – Portfolio Overview

![Dashboard Page 1](Business_Analytics_Dashboard_1.png)

This page highlights:

- Total loans issued
- Total portfolio value
- Interest rate distribution
- Loan purpose distribution
- Delinquency patterns
- Top borrowers

---

# Dashboard – Risk & Borrower Analysis

![Dashboard Page 2](Business_Analytics_Dashboard_2.png)

This page explores:

- Borrower income vs loan size
- Loan repayment patterns
- Risk distribution by credit grade
- Loan exposure across borrower segments

---

# Key Insights

• Debt consolidation loans dominate the portfolio  
• Higher credit grades are associated with lower interest rates  
• Most borrowers show low delinquency risk  
• Portfolio exposure is concentrated among mid-risk borrowers  
• Borrower income moderately correlates with loan size  

---

# Tools Used

- Python (Pandas) – Data preparation
- SQL (SSMS) – Data modeling and analysis
- Power BI – Data visualization
- ER Modeling – Schema design

---

# Author

**Atishay Jain**

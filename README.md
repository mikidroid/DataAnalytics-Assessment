DataAnalytics-Assessment

Overview

This repository contains solutions to a SQL proficiency assessment focused on customer account data, transaction behavior, and customer value estimation. The dataset includes user, savings, and investment information. Each SQL file solves a unique business problem with comments and efficient logic.


Assessment_Q1.sql - High-Value Customers with Multiple Products

*Objective:*  
Identify customers who have both at least one funded savings plan and one funded investment plan. Sort them by total deposits.

*Approach:*  
- Join users_customuser, savings_savingsaccount, and plans_plan on owner_id.
- Filter for regular savings (is_regular_savings = 1) and investment plans (is_a_fund = 1).
- Aggregate total deposits and return counts per customer.

---

Assessment_Q2.sql - Transaction Frequency Analysis

*Objective:*  
Classify customers into frequency tiers based on their average monthly transaction count.

*Approach:*  
- Count transactions and calculate active months per customer.
- Derive average transactions per month.
- Categorize into:  
  - High Frequency (≥10)  
  - Medium Frequency (3–9)  
  - Low Frequency (≤2)

*Output:*  
Customer counts and average transaction values per frequency tier.

---

Assessment_Q3.sql - Account Inactivity Alert

*Objective:*  
Identify all active savings or investment accounts with no inflow activity in the last 365 days.

*Approach:*  
- Use MAX(transaction_date) to find the last inflow.
- Calculate inactivity_days using DATEDIFF.
- Filter where inactivity exceeds 365 days.
- Include both savings and investment types using UNION.


Assessment_Q4.sql - Customer Lifetime Value (CLV) Estimation

*Objective:*  
Estimate each customer's CLV using a simplified profit model:
- Profit per transaction = 0.1% of transaction value
- CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction

*Approach:*  
- Calculate tenure from signup_date.
- Sum confirmed transactions per customer.
- Derive and rank customers by estimated CLV.

Challenges

- *Time-based calculations:* Handled using DATEDIFF() for both months and days.
- *Null values & division:* Prevented division errors using NULLIF() for safe calculations.
- *Efficient joins and filters:* Ensured accuracy and performance without subqueries or unnecessary scans.

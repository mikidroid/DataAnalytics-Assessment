-- Question 4: Customer Lifetime Value (CLV) Estimation

WITH txn_summary AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        SUM(s.confirmed_amount) / 100 AS total_value
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
),
tenure_calc AS (
    SELECT 
        id AS customer_id,
        name,
        DATEDIFF(MONTH, signup_date, CURRENT_DATE) AS tenure_months
    FROM users_customuser
),
clv_calc AS (
    SELECT 
        t.customer_id,
        t.name,
        t.tenure_months,
        tx.total_transactions,
        ROUND((tx.total_value * 0.001 / NULLIF(t.tenure_months, 0)) * 12, 2) AS estimated_clv
    FROM tenure_calc t
    JOIN txn_summary tx ON t.customer_id = tx.owner_id
)
SELECT * 
FROM clv_calc
ORDER BY estimated_clv DESC;

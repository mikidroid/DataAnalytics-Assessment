-- Question 2: Transaction Frequency Analysis

WITH txn_counts AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        DATEDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) + 1 AS active_months
    FROM savings_savingsaccount
    GROUP BY owner_id
),
frequency AS (
    SELECT 
        owner_id,
        total_transactions,
        active_months,
        CAST(total_transactions AS FLOAT) / NULLIF(active_months, 0) AS avg_txn_per_month
    FROM txn_counts
),
categorized AS (
    SELECT 
        CASE 
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txn_per_month
    FROM frequency
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;

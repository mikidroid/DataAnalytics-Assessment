-- Question 3: Account Inactivity Alert

SELECT 
    id AS plan_id,
    owner_id,
    'Savings' AS type,
    MAX(transaction_date) AS last_transaction_date,
    DATEDIFF(DAY, MAX(transaction_date), CURRENT_DATE) AS inactivity_days
FROM savings_savingsaccount
GROUP BY id, owner_id
HAVING DATEDIFF(DAY, MAX(transaction_date), CURRENT_DATE) > 365

UNION

SELECT 
    id AS plan_id,
    owner_id,
    'Investment' AS type,
    MAX(transaction_date) AS last_transaction_date,
    DATEDIFF(DAY, MAX(transaction_date), CURRENT_DATE) AS inactivity_days
FROM plans_plan
GROUP BY id, owner_id
HAVING DATEDIFF(DAY, MAX(transaction_date), CURRENT_DATE) > 365;

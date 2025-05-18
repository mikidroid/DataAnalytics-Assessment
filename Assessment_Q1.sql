SELECT
    u.id AS owner_id,
    u.name,
    COALESCE(s.savings_count, 0) AS savings_count,
    COALESCE(i.investment_count, 0) AS investment_count,
    COALESCE(s.total_savings, 0) + COALESCE(i.total_investment, 0) AS total_deposits
FROM users_customuser u
-- Savings plans aggregation
LEFT JOIN (
    SELECT
        owner_id,
        COUNT(DISTINCT id) AS savings_count,
        SUM(amount) AS total_savings
    FROM plans_plan
    WHERE plan_type_id = 1 -- savings plan type
      AND amount > 0
    GROUP BY owner_id
) s ON u.id = s.owner_id
-- Investment plans aggregation
LEFT JOIN (
    SELECT
        owner_id,
        COUNT(DISTINCT id) AS investment_count,
        SUM(amount) AS total_investment
    FROM plans_plan
    WHERE plan_type_id = 2 -- investment plan type
      AND amount > 0
    GROUP BY owner_id
) i ON u.id = i.owner_id
-- Savings accounts aggregation (optional, since we are counting plans above)
-- But since you said "funded savings plan" AND "funded investment plan", 
-- and the savings_savingsaccount table might represent actual funded accounts, let's also join:
INNER JOIN (
    SELECT DISTINCT owner_id
    FROM savings_savingsaccount
    WHERE amount > 0
) sa ON u.id = sa.owner_id
-- Filter only users with at least 1 savings and 1 investment plan
WHERE COALESCE(s.savings_count, 0) > 0
  AND COALESCE(i.investment_count, 0) > 0
ORDER BY total_deposits DESC;

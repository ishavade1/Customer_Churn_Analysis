USE customer_churn;

select * from churn;

-- Q1. Overall churn rate

select
	ROUND(100.0 * SUM(CASE when churn_value = 'Yes' then 1 else 0 end) / COUNT(*),2) as churn_rate
from churn;

-- Q2. Churn rate by contract type
select
	contract,
	ROUND(100.0 * SUM(CASE when churn_value = 1 then 1 else 0 end) / COUNT(*),2) as churn_rate
from churn
GROUP BY contract
ORDER BY churn_rate desc;


-- Q3. Churn rate by payment method
select
	payment_method,
	ROUND(100.0 * SUM(CASE when churn_value = 1 then 1 else 0 end) / COUNT(*),2) as churn_rate
from churn
GROUP BY payment_method
ORDER BY churn_rate desc;

-- Q4. Churn rate by internet service
select
	internet_service,
	ROUND(100.0 * SUM(CASE when churn_value = 1 then 1 else 0 end) / COUNT(*),2) as churn_rate
from churn
GROUP BY internet_service
ORDER BY churn_rate desc;

-- Q5. Average monthly charges for churned vs non-churned
SELECT 
    churn_value,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM churn
GROUP BY churn_value;

-- Q6. Which tenure group has highest churn?
SELECT 
    CASE 
        WHEN tenure_months <= 12 THEN '0-12 Months'
        WHEN tenure_months <= 24 THEN '12-24 Months'
        WHEN tenure_months <= 48 THEN '24-48 Months'
        ELSE '48+ Months'
    END AS tenure_group,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- Q7. Top 5 high-risk customer segments
SELECT 
    contract,
    internet_service,
    payment_method,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM churn
GROUP BY contract, internet_service, payment_method
ORDER BY churn_rate DESC
LIMIT 5;

-- Q8. Average tenure of churned vs non-churned
SELECT 
    churn_value,
    ROUND(AVG(tenure_months), 2) AS avg_tenure
FROM churn
GROUP BY churn_value;

-- Q9. Revenue loss due to churn
SELECT 
    ROUND(SUM(CASE WHEN churn_value = 1 THEN monthly_charges ELSE 0 END), 2) AS revenue_lost
FROM churn;

-- Q10. Which customers pay more but still churn?
SELECT 
    customer_id,
    monthly_charges
FROM churn
WHERE churn_value = 1
AND monthly_charges > (SELECT AVG(monthly_charges) FROM churn)
ORDER BY monthly_charges DESC;

-- Q11. Churn rate by senior citizens
select
	senior_citizen,
	ROUND(100.0 * SUM(CASE when churn_value = 1 then 1 else 0 end) / COUNT(*),2) as churn_rate
from churn
GROUP BY senior_citizen
ORDER BY churn_rate desc;

-- Q12. Churn rate by gender
select
	gender,
	ROUND(100.0 * SUM(CASE when churn_value = 1 then 1 else 0 end) / COUNT(*),2) as churn_rate
from churn
GROUP BY gender
ORDER BY churn_rate desc;

-- Q13. Rank payment methods by churn
SELECT 
    payment_method,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate,
    RANK() OVER (ORDER BY 
        ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) DESC
    ) AS rank_position
FROM churn
GROUP BY payment_method;

-- Q14. Retention rate by contract

SELECT 
    contract,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_rate
FROM churn
GROUP BY contract;

-- Q15. Which customers are at HIGH RISK of churning?
SELECT 
    customer_id,
    contract,
    tenure_months,
    monthly_charges
FROM churn
WHERE churn_value = 1
AND tenure_months < 12
AND contract = 'Month-to-month'
ORDER BY monthly_charges DESC;

-- Q16. How much revenue can be saved if churn is reduced by 10%?
SELECT 
    ROUND(SUM(monthly_charges) * 0.10, 2) AS potential_revenue_saved
FROM churn
WHERE churn_value = 1;

-- Q17. Which combination of services leads to highest churn?
SELECT 
    internet_service,
    online_security,
    tech_support,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM churn
GROUP BY internet_service, online_security, tech_support
ORDER BY churn_rate DESC
LIMIT 5;

-- Q18.  Are customers without support services more likely to churn?
SELECT 
    tech_support,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM churn
GROUP BY tech_support;

-- Q19.  Which payment + contract combo is most risky?
SELECT 
    contract,
    payment_method,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM churn
GROUP BY contract, payment_method
ORDER BY churn_rate DESC
LIMIT 5;

-- Q20.  What percentage of churn comes from new customers?
SELECT 
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM churn WHERE churn_value = 1), 2) AS new_customer_churn_percentage
FROM churn
WHERE churn_value = 1 AND tenure_months <= 12;

-- Q21. Identify loyal customers (low churn risk)
SELECT 
    customer_id,
    tenure_months,
    contract
FROM churn
WHERE tenure_months > 24
AND contract IN ('One year', 'Two year')
AND churn_value = 0;

-- Q22. Which segment gives highest revenue but also churns?
SELECT 
    internet_service,
    ROUND(SUM(monthly_charges),2) AS revenue,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate
FROM churn
GROUP BY internet_service
ORDER BY revenue DESC;

-- Q23. Which customers should be targeted for retention campaign?
SELECT 
    customer_id,
    tenure_months,
    monthly_charges
FROM churn
WHERE churn_value = 1
AND monthly_charges > (SELECT AVG(monthly_charges) FROM churn)
AND tenure_months < 12;

-- Q24. Do customers with multiple services churn less?
SELECT 
    multiple_lines,
    ROUND(100.0 * SUM(CASE WHEN churn_value = 1 THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate
FROM churn
GROUP BY multiple_lines;

-- Q25. When do customers usually churn?

SELECT 
    CASE 
        WHEN tenure_months <= 6 THEN '0-6 Months'
        WHEN tenure_months <= 12 THEN '6-12 Months'
        WHEN tenure_months <= 24 THEN '12-24 Months'
        ELSE '24+ Months'
    END AS churn_period,
    COUNT(*) AS churn_count
FROM churn
WHERE churn_value = 1
GROUP BY churn_period
ORDER BY churn_count DESC;
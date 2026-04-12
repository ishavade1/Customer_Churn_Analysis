📊 Customer Churn Analysis using SQL (PostgreSQL, MySQL)

📌 Project Overview
This project focuses on analyzing telecom customer churn data using SQL to identify patterns, high-risk customers, and key factors influencing churn.

The analysis is performed using PostgreSQL with 25+ business-driven SQL queries covering churn rate, customer segmentation, revenue impact, and retention strategies.

🎯 Objectives
- Calculate overall churn and retention rates
- Identify high-risk customer segments
- Analyze impact of contract type, payment method, and services on churn
- Evaluate revenue loss due to churn
- Support data-driven customer retention strategies

🛠️ Tools & Technologies
- SQL
- PostgreSQL and MySQL (RDBMS)

📂 Dataset
- Telecom Customer Churn Dataset
- Contains customer demographics, services, tenure, charges, and churn status


🔍 Key Analysis Performed

1. Churn Metrics
- Overall churn rate calculation
- Retention rate by contract type
- Churn comparison (churned vs non-churned customers)

2. Customer Segmentation
- Churn rate by:
  - Contract type
  - Payment method
  - Internet service
  - Gender & senior citizens
- Tenure-based churn grouping

3. Revenue Analysis
- Revenue loss due to churn
- High-paying customers who still churn
- Potential revenue saved if churn is reduced

4. Risk Identification
- High-risk customer segments using:
  - Contract + payment + service combinations
- Customers with:
  - Low tenure
  - High monthly charges
  - Month-to-month contracts

 5. Advanced SQL Analysis
- Ranking churn factors using window functions (RANK)
- Subqueries to identify above-average spending customers
- CASE statements for grouping tenure and churn periods
- Multi-column grouping for deep insights


📈 Key Insights
- Month-to-month contract customers show highest churn rate
- Customers with shorter tenure are more likely to churn
- Lack of support services (tech support, security) increases churn probability
- High-paying customers are also at risk if retention strategies are not applied
- Certain combinations of services and payment methods lead to higher churn


💡 Business Recommendations
- Offer incentives for long-term contracts
- Improve support services to reduce churn
- Target high-risk customers with personalized retention campaigns
- Focus on onboarding experience for new customers


📊 SQL Concepts Used
- Joins
- Subqueries
- Aggregations (SUM, AVG, COUNT)
- CASE statements
- Window functions (RANK)
- Group By & Filtering
- Data segmentation


📁 Project Structure
- `churn_analysis.sql` → Contains 25+ SQL queries
- `README.md` → Project documentation

🚀 Conclusion
This project demonstrates how SQL can be used to analyze customer churn, identify business risks, and generate actionable insights for improving customer retention.



USE credit_risk_project;

-- Q1. Portfolio overview
SELECT COUNT(*) AS total_loans,
       SUM(loan_amount) AS total_disbursed,
       AVG(loan_amount) AS avg_loan_amount,
       AVG(default_flag)*100 AS default_rate_pct
FROM loans WHERE loan_status = 'Approved';

-- Q2. Default rate by loan type
SELECT loan_type, COUNT(*) AS loans,
       ROUND(AVG(default_flag)*100,2) AS default_rate_pct,
       ROUND(SUM(loan_amount),2) AS requested_amount
FROM loans GROUP BY loan_type ORDER BY default_rate_pct DESC;

-- Q3. Credit-score risk bands
SELECT CASE WHEN b.credit_score < 580 THEN 'High Risk'
            WHEN b.credit_score < 670 THEN 'Medium Risk'
            ELSE 'Lower Risk' END AS risk_band,
       COUNT(*) AS borrowers,
       ROUND(AVG(l.default_flag)*100,2) AS default_rate_pct,
       ROUND(AVG(b.annual_income),0) AS avg_income
FROM borrowers b JOIN loans l ON b.borrower_id=l.borrower_id
GROUP BY risk_band ORDER BY default_rate_pct DESC;

-- Q4. Default rate by employment type
SELECT b.employment_type, COUNT(*) AS loans,
       ROUND(AVG(l.default_flag)*100,2) AS default_rate_pct
FROM borrowers b JOIN loans l ON b.borrower_id=l.borrower_id
GROUP BY b.employment_type ORDER BY default_rate_pct DESC;

-- Q5. Delinquency profile by loan type
SELECT l.loan_type, r.payment_status, COUNT(*) AS repayment_count,
       ROUND(AVG(r.days_past_due),1) AS avg_days_past_due,
       SUM(r.amount_due-r.amount_paid) AS payment_gap
FROM loans l JOIN repayments r ON l.loan_id=r.loan_id
GROUP BY l.loan_type, r.payment_status
ORDER BY avg_days_past_due DESC;

-- Q6. Top borrowers by outstanding repayment gap
SELECT b.borrower_id, b.credit_score, l.loan_type,
       SUM(r.amount_due-r.amount_paid) AS repayment_gap
FROM borrowers b JOIN loans l ON b.borrower_id=l.borrower_id
JOIN repayments r ON l.loan_id=r.loan_id
GROUP BY b.borrower_id, b.credit_score, l.loan_type
ORDER BY repayment_gap DESC LIMIT 20;

-- Q7. Monthly loan application trend
SELECT DATE_FORMAT(application_date,'%Y-%m') AS application_month,
       COUNT(*) AS applications, SUM(loan_amount) AS requested_value
FROM loans GROUP BY application_month ORDER BY application_month;

-- Q8. Ranking loan types by default rate
WITH loan_type_risk AS (
 SELECT loan_type, AVG(default_flag)*100 AS default_rate
 FROM loans GROUP BY loan_type
)
SELECT loan_type, ROUND(default_rate,2) AS default_rate_pct,
       DENSE_RANK() OVER (ORDER BY default_rate DESC) AS risk_rank
FROM loan_type_risk;

-- Q9. Approval funnel
SELECT loan_status, COUNT(*) AS applications,
       ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM loans),2) AS pct_of_applications
FROM loans GROUP BY loan_status ORDER BY applications DESC;

-- Q10. Flag loans for review (illustrative policy, not a lending decision)
SELECT l.loan_id, b.credit_score, b.annual_income, l.loan_amount,
       CASE WHEN b.credit_score < 580 OR l.loan_amount > b.annual_income*3
            THEN 'Manual Review'
            WHEN b.credit_score < 670 THEN 'Enhanced Review'
            ELSE 'Standard Review' END AS review_queue
FROM loans l JOIN borrowers b ON l.borrower_id=b.borrower_id;

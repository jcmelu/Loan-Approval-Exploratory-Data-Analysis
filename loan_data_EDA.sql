SELECT *
FROM loan_data;

-- Exploratory Data Analysis
-- 1. Approval rate by demographic (by gender, age, education, income, emp_exp)
-- 2. Does average credit score and credit history length differ approved and rejected loans?
-- 3. Which loan intent category has the highest approval rate?
-- 4. Top demographics of gender, age, education, income, emp_exp based on average and total loan amount?
-- 5. Segment customer based on credit history length and calculate the average loan interest rate and credit score.

-- 1.
SELECT person_gender, person_education, 
COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS approved_loans,
ROUND((CAST(SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*)), 2) AS approval_rate
FROM loan_data
GROUP BY person_gender, person_education
ORDER BY approval_rate DESC, total_loans DESC;

SELECT age_tier, 
COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS approved_loans,
ROUND((CAST(SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*)), 2) AS approval_rate
FROM loan_data
GROUP BY age_tier
ORDER BY approval_rate DESC, total_loans DESC;

SELECT income_tier,
COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS approved_loans,
ROUND((CAST(SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*)), 2) AS approval_rate
FROM loan_data
GROUP BY income_tier
ORDER BY approval_rate DESC, total_loans DESC;

SELECT emp_exp_tier,
COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS approved_loans,
ROUND((CAST(SUM(CASE WHEN loan_status = "1" THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*)), 2) AS approval_rate
FROM loan_data
GROUP BY emp_exp_tier
ORDER BY approval_rate DESC, total_loans DESC;


-- 2.
SELECT ROUND(AVG(credit_score),2) AS avg_credit_score,
ROUND(AVG(cb_person_cred_hist_length),2) AS avg_credit_history, 
loan_status
FROM loan_data
GROUP BY loan_status;

-- 3.
SELECT loan_intent, 
COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status = '1' THEN 1 ELSE 0 END) AS approved_loans,
ROUND((CAST(SUM(CASE WHEN loan_status = '1' THEN 1 ELSE 0 END) AS REAL) * 100/ COUNT(*)), 2) AS approval_rate
FROM loan_data
GROUP BY loan_intent
ORDER BY approval_rate DESC, total_loans DESC;

-- 4. 
SELECT person_education, 
ROUND(AVG(loan_amnt), 2) AS avg_loan, 
ROUND(SUM(loan_amnt), 2) AS total_loan
FROM loan_data
WHERE loan_status = '1'
GROUP BY person_education
ORDER BY AVG(loan_amnt) DESC, SUM(loan_amnt) DESC;

SELECT person_gender, 
ROUND(AVG(loan_amnt), 2) AS avg_loan, 
ROUND(SUM(loan_amnt), 2) AS total_loan
FROM loan_data
WHERE loan_status = '1'
GROUP BY person_gender
ORDER BY AVG(loan_amnt) DESC, SUM(loan_amnt) DESC;

SELECT age_tier, 
ROUND(AVG(loan_amnt), 2) AS avg_loan, 
ROUND(SUM(loan_amnt), 2) AS total_loan
FROM loan_data
WHERE loan_status = '1'
GROUP BY age_tier
ORDER BY AVG(loan_amnt) DESC, SUM(loan_amnt) DESC;

SELECT income_tier, 
ROUND(AVG(loan_amnt), 2) AS avg_loan, 
ROUND(SUM(loan_amnt), 2) AS total_loan
FROM loan_data
WHERE loan_status = '1'
GROUP BY income_tier
ORDER BY AVG(loan_amnt) DESC, SUM(loan_amnt) DESC;

SELECT emp_exp_tier, 
ROUND(AVG(loan_amnt), 2) AS avg_loan, 
ROUND(SUM(loan_amnt), 2) AS total_loan
FROM loan_data
WHERE loan_status = '1'
GROUP BY emp_exp_tier
ORDER BY AVG(loan_amnt) DESC, SUM(loan_amnt) DESC;

-- 5
SELECT credit_hist_length_tier, 
ROUND(AVG(loan_int_rate), 2) AS avg_int_rate,
ROUND(AVG(credit_score), 2) AS avg_credit_score
FROM loan_data
GROUP BY credit_hist_length_tier
ORDER BY AVG(loan_int_rate), AVG(credit_score);


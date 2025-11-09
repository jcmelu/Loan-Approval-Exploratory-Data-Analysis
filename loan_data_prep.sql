-- Date Prep and Clean up

-- Age: deleted entries where age was above 100
SELECT * 
FROM loan_data
WHERE person_age >= '90';

DELETE FROM loan_data
WHERE person_age >= 100;

-- Added tiers
SELECT MIN(person_age), MAX(person_age), 
MIN(person_income), MAX(person_income), 
MIN(person_emp_exp), MAX(person_emp_exp)
FROM loan_data;

-- Age tier
ALTER TABLE loan_data
ADD COLUMN age_tier VARCHAR(50);

UPDATE loan_data
SET age_tier =
	CASE
		WHEN person_age BETWEEN 20 AND 30 THEN '20-30'
		WHEN person_age BETWEEN 31 AND 40 THEN '31-40'
		WHEN person_age BETWEEN 41 AND 50 THEN '31-50'
		WHEN person_age BETWEEN 51 AND 60 THEN '51-60'
		ELSE '60+'
	END;

-- Income Tier
ALTER TABLE loan_data
ADD COLUMN income_tier VARCHAR(50);

ALTER TABLE loan_data ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

WITH percentiles AS (
    SELECT
        id,
        NTILE(4) OVER (ORDER BY person_income) as quartile_group
    FROM loan_data
)
UPDATE loan_data ld
JOIN percentiles p ON ld.id = p.id
SET ld.income_tier = CASE
    WHEN p.quartile_group = 1 THEN 'Low Income'
    WHEN p.quartile_group = 2 THEN 'Low-Middle Income'
    WHEN p.quartile_group = 3 THEN 'High-Middle Income'
    WHEN p.quartile_group = 4 THEN 'High Income'
    ELSE 'Uncategorized'
END;


-- Emp experience tier
ALTER TABLE loan_data
ADD COLUMN emp_exp_tier VARCHAR(50);

UPDATE loan_data
SET emp_exp_tier =
	CASE
		WHEN person_emp_exp BETWEEN 0 AND 15 THEN '0-15'
		WHEN person_emp_exp BETWEEN 16 AND 30 THEN '16-30'
		WHEN person_emp_exp BETWEEN 31 AND 45 THEN '31-45'
		WHEN person_emp_exp BETWEEN 46 AND 60 THEN '36-60'
		ELSE '60+'
	END;

-- Credit history length tier
SELECT MIN(cb_person_cred_hist_length), MAX(cb_person_cred_hist_length)
FROM loan_data;

ALTER TABLE loan_data
ADD COLUMN credit_hist_length_tier VARCHAR(50);

UPDATE loan_data
SET credit_hist_length_tier =
	CASE
		WHEN cb_person_cred_hist_length BETWEEN 0 AND 10 THEN '0-10'
		WHEN cb_person_cred_hist_length BETWEEN 11 AND 20 THEN '11-20'
		WHEN cb_person_cred_hist_length BETWEEN 21 AND 30 THEN '21-30'
		ELSE '30+'
	END;



#1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT 
    t1.industry,
    t1.payroll_year,
    t1.wage,
    t2.payroll_year AS prev_year,
    t2.wage AS next_wage,
    t1.wage - t2.wage AS difference,
    CASE
        WHEN (t1.wage - t2.wage) < 0 THEN 'salary is decreasing'
        ELSE 'salary is increasing or is the same'
    END AS increasing_decreasing
FROM t_katarina_verebova_project_sql_primary_final t1
LEFT JOIN t_katarina_verebova_project_sql_primary_final t2
    ON t1.industry_code = t2.industry_code
    AND t1.payroll_year = t2.payroll_year + 1
WHERE t2.payroll_year IS NOT NULL AND t2.wage IS NOT NULL
GROUP BY 
	t1.industry,
	t1.payroll_year
ORDER BY 
	t1.industry;
	
	





	
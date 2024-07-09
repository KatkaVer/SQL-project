/*Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, 
pokud HDP vzroste výrazněji v jednom roce, 
projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?*/

WITH wage_prices as(
SELECT 
    t1.payroll_year AS current_year,
    t2.payroll_year AS next_year,
    ROUND(AVG(t1.wage), 2) AS current_wage,
    ROUND(AVG(t2.wage), 2) AS next_wage,
    ROUND(((t2.wage - t1.wage) / t1.wage) * 100, 2) AS per_change_wage,
    AVG(t1.price) AS avg_price,
    AVG(t2.price) AS avg_next_price,
    ROUND(AVG((t2.price / t1.price - 1) * 100), 3) AS per_change_food
FROM
    t_katarina_verebova_project_sql_primary_final t1
JOIN 
    t_katarina_verebova_project_sql_primary_final t2
    ON t1.f_name = t2.f_name 
    AND t1.payroll_year = t2.payroll_year - 1
GROUP BY
	t1.payroll_year),
GDP as(
	SELECT
		s1.country,
		s1.YEAR AS 'current_year',
		s2.YEAR AS 'next_year',
		s1.GDP_mil_dollars AS GDP,
		ROUND(((s2.GDP_mil_dollars-s1.GDP_mil_dollars)/s1.GDP_mil_dollars *100), 2) AS perc_diff_GDP
	FROM t_katarina_verebova_project_sql_secondary_final s1
	JOIN t_katarina_verebova_project_sql_secondary_final s2
		ON s1.YEAR = s2.YEAR -1 
		AND s1.country = s2.country
	WHERE s1.country = 'Czech republic'
	AND s1.GDP_mil_dollars IS NOT NULL)
SELECT
    GDP.country,
    GDP.current_year,
    GDP.perc_diff_GDP,
    wage_prices.per_change_wage,
    wage_prices.per_change_food
FROM
    GDP
JOIN
    wage_prices
ON
    GDP.current_year = wage_prices.current_year
ORDER BY wage_prices.current_year;
  
	
	

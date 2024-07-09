/*Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?*/
	
SELECT 
   	t1.price,
	t1.f_code,
	t1.f_name, 
    t2.price  AS next_year_price,
    AVG(round(((t2.price/t1.price)-1)*100,2)) AS difference
FROM t_katarina_verebova_project_sql_primary_final t1
LEFT JOIN t_katarina_verebova_project_sql_primary_final t2
    ON t1.f_code = t2.f_code 
    AND t1.payroll_year = t2.payroll_year - 1
GROUP BY 
	t1.f_name
ORDER BY 
	difference ASC;
	
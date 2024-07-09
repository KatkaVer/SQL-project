/*Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší 
než růst mezd (větší než 10 %)?*/
SELECT 
    t1.payroll_year AS current_year,
    t2.payroll_year AS next_year,
    ROUND(AVG(t1.wage), 2) AS current_wage,
    ROUND(AVG(t2.wage), 2) AS next_wage,
    ROUND(((t2.wage - t1.wage) / t1.wage) * 100, 2) AS per_change_wage,
    AVG(t1.price) AS avg_price,
    AVG(t2.price) AS avg_next_price,
    ROUND(AVG((t2.price / t1.price - 1) * 100), 3) AS per_change_food,
    CASE 
        WHEN (ROUND(AVG((t2.price / t1.price - 1) * 100), 3)) > (ROUND(((t2.wage - t1.wage) / t1.wage) * 100, 2) + 10) THEN 'change of food is greater than wage'
        ELSE 'change of food smaller or equal than wage'
    END AS food_vs_wage_change
FROM
    t_katarina_verebova_project_sql_primary_final t1
JOIN 
    t_katarina_verebova_project_sql_primary_final t2
    ON t1.f_name = t2.f_name 
    AND t1.payroll_year = t2.payroll_year - 1
WHERE 
    t1.payroll_year IS NOT NULL 
GROUP BY 
    t1.payroll_year
ORDER BY 
    t1.payroll_year;
    
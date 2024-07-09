/*Kolik je možné si koupit litrů mléka a kilogramů chleba za první 
 *a poslední srovnatelné období v dostupných datech cen a mezd?*/
 
 
/*frist and last year
 * 2006 & 2018*/ 

SELECT 
	max (t.payroll_year),
	min (t.payroll_year)
FROM 
	t_katarina_verebova_project_sql_primary_final t;
	
/*food codes
 Chléb konzumní kmínový	- 111301 
 Mléko polotučné pasterované - 114201*/
	
SELECT 
	t.f_name, 
	t.f_code 
FROM 
	t_katarina_verebova_project_sql_primary_final t
group BY
	t.f_code;

/*2006, 2018*/
SELECT 
    t.f_name,
    t.wage,
    t.price,
    t.payroll_year,
    ROUND(AVG(t.wage), 2) AS avg_salary,
    ROUND((t.wage/price), 0) AS can_afford
FROM 
    t_katarina_verebova_project_sql_primary_final t
WHERE 
    t.f_code IN (114201, 111301 )
    AND t.industry_code  IS NULL
    AND t.payroll_year IN (2006, 2018)
GROUP BY 
	t.payroll_year,
	t.f_name;
   

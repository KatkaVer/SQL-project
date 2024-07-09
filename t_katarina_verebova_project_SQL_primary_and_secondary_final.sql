/*CREATE TABLE t_katarina_verebova_primary_final(*/

CREATE OR REPLACE TABLE t_katarina_verebova_project_SQL_primary_final AS (
SELECT 
	cpay.payroll_year,
	cpay.industry,
	cpay.industry_code,
	cpay.wage,
	cpay.value_type_code,
	cp.f_code,
	cp.f_name,
	cp.price
FROM (
/* food data details with esentials*/
SELECT
	year(cp.date_from) AS year_cp,
	round(avg(cp.value), 2) AS price,
	cpc.code AS f_code,
	cpc.name AS f_name,
	cpc.price_value AS price_value,
	cpc.price_unit AS price_unit,
	cp.region_code  AS r_code
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code
WHERE region_code IS NULL
GROUP BY 
	f_code,
	year(cp.date_from)
		)cp
/*conecting czechia payroll esentials to food data*/
INNER JOIN (
SELECT
	ROUND(AVG(cpay.value), 2) AS wage,
    cpay.industry_branch_code AS industry_code,
    cib.name AS industry,
    cpay.value_type_code AS value_type_code,
    cvt.name AS value_type_name,
    cpay.calculation_code AS calculation_code,
    cpc.name AS calculation_name,
    cpay.payroll_year AS payroll_year,
    cpay.unit_code AS unit_code,
    cu.name AS unit_name
FROM czechia_payroll cpay
LEFT JOIN czechia_payroll_industry_branch cib 
	ON cpay.industry_branch_code = cib.code
LEFT JOIN czechia_payroll_value_type cvt 
	ON cpay.value_type_code = cvt.code
LEFT JOIN czechia_payroll_calculation cpc 
	ON cpay.calculation_code = cpc.code
LEFT JOIN czechia_payroll_unit cu 
	ON cpay.unit_code = unit_code
WHERE cpay.value_type_code = 5958
	GROUP BY industry_code, payroll_year
) cpay
	ON cp.year_cp = cpay.payroll_year );
	
	


/*Secondary table	
countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok	*/
    
/*CREATE TABLE t_katarina_verebova_secondary_final(*/   
	
CREATE OR REPLACE TABLE t_katarina_verebova_project_SQL_secondary_final AS (
	SELECT c.country,
		c.capital_city, 
		e.year, 
	    round( e.GDP / 1000000, 2 ) as GDP_mil_dollars,
	    e.population,
	    e.gini
	FROM countries c 
	JOIN economies e 
	    ON c.country = e.country 
	    AND c.continent = "Europe"
	    );	
	



  
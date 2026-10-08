WITH unemployment_changes AS (
  SELECT 
    YEAR, 
    unemployment_rate,
    LAG(unemployment_rate) OVER 
      (ORDER BY YEAR) AS previous_year_rate,
    unemployment_rate 
    - LAG(unemployment_rate) OVER 
      (ORDER BY YEAR) AS yearly_change
  FROM economic_indicators
)
SELECT
  YEAR,
  unemployment_rate,
  previous_year_rate,
  yearly_change,
  CASE 
    WHEN yearly_change > 0 THEN 'Increased'
	WHEN yearly_change < 0 THEN 'Decreased'
	WHEN yearly_change = 0 THEN 'Unchanged'
  END AS unemployment_trend
FROM unemployment_changes
WHERE yearly_change > 0 
ORDER BY year ASC;

SELECT 
  CASE
    WHEN unemployment_rate >= 5 THEN 'High unemployment'
	ELSE 'Low unemployment'
  END AS unemployment_group,
  ROUND(AVG(investment_index)::numeric,2) AS avg_investment,
  ROUND(AVG(grp_log_growth)::numeric,3) AS avg_grp_growth,
  COUNT(*) AS years_count
FROM economic_indicators
GROUP BY 1;

SELECT * FROM economic_indicators
SELECT year, unemployment_diff, investment_diff, grp_log_growth
FROM economic_indicators
WHERE investment_diff < 0  OR grp_log_growth < 0
ORDER BY unemployment_diff DESC;

SELECT 
  CASE
    WHEN investment_diff < 0 THEN 'Investment declined'
	ELSE 'Investment did not declined'
  END AS investment_condition,
  ROUND(AVG(unemployment_diff)::numeric,3) AS avg_unemployment_change,
  COUNT(*) AS years_count
FROM economic_indicators
WHERE investment_diff IS NOT NULL
GROUP BY 1;

WITH yearly_analysis AS (
  SELECT
    year,
	unemployment_diff,
	investment_diff,
	grp_log_growth,
	LAG(unemployment_diff) OVER 
      (ORDER BY YEAR) AS previous_unemployment_change
  FROM economic_indicators
)
SELECT
  year,
  ROUND((unemployment_diff)::numeric,3),
  ROUND((investment_diff)::numeric,3),
  ROUND((grp_log_growth)::numeric,3),
  ROUND((previous_unemployment_change)::numeric,3),
  CASE 
    WHEN investment_diff < 0 
	  AND grp_log_growth < 0
	    THEN 'Both indicators declined'
	WHEN investment_diff < 0 THEN 'Investment declined'
	WHEN grp_log_growth < 0 THEN 'GRP declined'
	ELSE 'No decline'
  END AS economic_condition
FROM yearly_analysis
WHERE unemployment_diff IS NOT NULL
ORDER BY unemployment_diff DESC
LIMIT 5;


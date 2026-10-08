SELECT *
FROM economic_indicators
ORDER BY YEAR;

--coverage
SELECT 
  COUNT(*) AS total_rows,
  MIN(YEAR) AS first_year,
  MAX(YEAR) AS last_year
FROM economic_indicators;
--missing values
SELECT
  COUNT(*) FILTER (
    WHERE unemployment_rate IS NULL) AS missing_unemployment,
  COUNT(*) FILTER (
    WHERE investment_index IS NULL) AS missing_investment,
  COUNT(*) FILTER (
    WHERE grp_mln_rub IS NULL) AS missing_grp,
  COUNT(*) FILTER (
    WHERE working_age_population_thousands IS NULL) AS missing_population
FROM economic_indicators;

-- duplicate years
SELECT 
  year,
  COUNT(*) AS records_count
FROM economic_indicators
GROUP BY year
HAVING COUNT(*) > 1
ORDER BY year;

-- первые разницы
SELECT 
  year,
  unemployment_diff,
  investment_diff,
  grp_log_growth
FROM economic_indicators
WHERE unemployment_diff IS NULL 
  OR investment_diff IS NULL
  OR grp_log_growth IS NULL
ORDER BY year;
SELECT *
FROM economic_indicators
ORDER BY YEAR;

SELECT 
  COUNT(*) AS total_rows,
  MIN(YEAR) AS first_year,
  MAX(YEAR) AS last_year
FROM economic_indicators;

SELECT
  COUNT(*) FILTER (
    WHERE unemployment_rate IS NULL) AS missing_unemployment,
  COUNT(*) FILTER (
    WHERE grp_mln_rub IS NULL) AS missing_grp,
  COUNT(*) FILTER (
    WHERE working_age_population_thousands IS NULL) AS missing_population
FROM economic_indicators;

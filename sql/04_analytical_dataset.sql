CREATE OR REPLACE VIEW unemployment_analytics AS

WITH with_lag AS (
  SELECT
    year,
    unemployment_rate,
    unemployment_diff,
    investment_index,
    investment_diff,
    grp_mln_rub,
    grp_log_growth,
    average_salary,
    housing_price,
    working_age_population_thousands,
	LAG(unemployment_rate) OVER (ORDER BY year) AS prev_unemployment
  FROM economic_indicators
)
SELECT
  year,
  unemployment_rate,
  unemployment_diff,
  investment_index,
  investment_diff,
  grp_mln_rub,
  grp_log_growth,
  average_salary,
  housing_price,
  working_age_population_thousands,
  ROUND(
    (unemployment_rate::numeric - prev_unemployment::numeric)
    / NULLIF(prev_unemployment::numeric, 0)
    * 100,
    2
  ) AS unemployment_yoy_pct,
  CASE
    WHEN unemployment_diff > 0 THEN 'Increased'
	WHEN unemployment_diff < 0 THEN 'Decreased'
	WHEN unemployment_diff = 0 THEN 'Unchanged'
	ELSE 'No previuos year'
  END AS unemployment_trend,

  CASE
    WHEN investment_diff > 0 THEN 'Increased'
	WHEN investment_diff < 0 THEN 'Decreased'
	WHEN investment_diff = 0 THEN 'No change'
	ELSE 'No previuos year'
  END AS investment_trend,

  CASE
    WHEN grp_log_growth > 0 THEN 'Increased'
	WHEN grp_log_growth < 0 THEN 'Decreased'
	WHEN grp_log_growth = 0 THEN 'No change'
	ELSE 'No previuos year'
  END AS grp_trend
FROM with_lag;

SELECT *
FROM unemployment_analytics
ORDER BY year DESC;
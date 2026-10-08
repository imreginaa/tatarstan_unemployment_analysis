**English** | [Русский](README_RU.md)
# Unemployment Analysis in the Republic of Tatarstan

End-to-end data analytics project exploring the dynamics of unemployment and its relationship with key macroeconomic indicators in the Republic of Tatarstan from 2000 to 2025.

The project combines data preparation and exploratory analysis in Python, analytical queries in PostgreSQL, Bayesian regression modeling, scenario analysis, and an interactive Power BI dashboard.

## Project Objective

The objective of this project is to analyze how changes in key economic indicators are associated with changes in the unemployment rate in the Republic of Tatarstan.

The analysis focuses primarily on:

- investment dynamics;
- GRP growth;
- unemployment dynamics over time;
- economic conditions associated with increases and decreases in unemployment.

The project also demonstrates a complete analytical workflow from raw data preparation to SQL analysis, statistical modeling, and dashboard visualization.

## Tech Stack
- Python: pandas, NumPy, Matplotlib, Seaborn
- Statistical Modeling: PyMC, ArviZ
- Database: PostgreSQL
- SQL: data quality checks, analytical queries, CTEs, window functions, conditional aggregation, analytical views
- BI & Visualization: Power BI
- Development Environment: Jupyter Notebook, VS Code, pgAdmin

## Analytical Pipeline
The project follows an end-to-end analytical workflow:

`Raw Excel Data` -> `Python Data Preparation` -> `Exploratory Data Analysis` -> `PostgreSQL` -> `SQL Analytical Layer` -> `Bayesian Modeling` -> `Scenario Analysis` -> `Power BI Dashboard`

### Workflow

1. Raw quarterly economic data is loaded and cleaned in Python.
2. Quarterly observations are aggregated to the annual level.
3. Analytical features such as first differences and logarithmic growth rates are calculated.
4. Exploratory data analysis is performed to examine trends and relationships between economic indicators.
5. The processed dataset is loaded into PostgreSQL.
6. SQL is used for data quality checks, historical analysis, window calculations, and creation of an analytical view.
7. Bayesian linear regression is used to estimate statistical associations between unemployment changes, investment dynamics, and GRP growth.
8. Model diagnostics and residual analysis are performed.
9. Illustrative economic scenarios are evaluated using the fitted model.
10. The PostgreSQL analytical view is connected to Power BI to create an interactive dashboard.

## Project Structure

```text
tatarstan-unemployment-analysis/
|
|-- data/
|   |-- raw/
|   |   |-- datanew.xlsx
|   |-- processed/
|       |-- tatarstan_economic_data_clean.csv
|
|-- notebook/
|   |-- 01_data_preparation.ipynb
|   |-- 02_eda.ipynb
|   |-- 03_bayesian_model.ipynb
|   |-- 04_model_validation.ipynb
|   |-- 05_scenario_forecast.ipynb
|
|-- sql/
|   |-- 01_create_tables.sql
|   |-- 02_data_quality.sql
|   |-- 03_analytical_queries.sql
|   |-- 04_analytical_dataset.sql
|
|-- dashboard/
|   |-- tatarstan_unemployment_dashboard.pbix
|   |-- dashboard_preview.png
|
|-- reports/
|-- README.md
|-- requirements.txt
```

## Key Findings

### Unemployment Dynamics

The unemployment rate in the Republic of Tatarstan shows a clear long-term downward trend, decreasing from **12.1% in 2000 to 1.73% in 2025**.

Despite the overall decline, several periods were characterized by temporary increases in unemployment. The most notable increases in the analyzed period occurred in **2009** and **2020**, which coincided with deterioration in both investment dynamics and GRP growth.

### Relationship with Economic Indicators

Analysis of annual changes showed that:

- changes in unemployment and investment dynamics have a correlation of approximately **-0.60**;

- changes in unemployment and GRP growth have a stronger correlation of approximately **-0.77**;

- salary and housing price growth showed weaker relationships with annual unemployment changes.

These results suggest that weaker investment dynamics and lower GRP growth tend to be associated with increases in unemployment.

The relationships should be interpreted as **statistical associations rather than causal effects**.

## Bayesian Regression Model

A Bayesian linear regression model was used to estimate the relationship between annual unemployment changes and selected macroeconomic indicators.

### Target Variable

- Annual change in unemployment rate (`unemployment_diff`)

### Predictors

- Annual change in the investment index (`investment_diff`)

- Logarithmic GRP growth (`grp_log_growth`)

The predictors were standardized before model estimation.

The model was estimated using **PyMC** with the **NUTS (No-U-Turn Sampler)** algorithm.

### Posterior Estimates

| Parameter | Mean | SD | 94% HDI |
|---|---:|---:|---:|
| Intercept | -0.411 | 0.082 | [-0.563, -0.259] |
| Investment change | -0.216 | 0.093 | [-0.397, -0.045] |
| GRP growth | -0.411 | 0.094 | [-0.582, -0.232] |
| Sigma | 0.406 | 0.067 | [0.291, 0.528] |

Both selected predictors have negative posterior coefficients. Within the analyzed historical data, stronger investment dynamics and higher GRP growth were associated with lower annual changes in unemployment.

MCMC diagnostics showed **R-hat values of approximately 1.00** and high effective sample sizes, indicating satisfactory convergence of the sampling procedure.

## Model Validation

Model performance and residual behavior were evaluated using several diagnostics.

- **In-sample MAE:** 0.287 percentage points
- **In-sample RMSE:** 0.360 percentage points
- **Ljung-Box test (lag 5):** p-value = 0.170

The Ljung-Box test did not provide statistically significant evidence of residual autocorrelation at the tested lags.

MAE and RMSE reported above represent **in-sample model fit** and should not be interpreted as out-of-sample forecasting performance.

 ## Scenario Analysis

The fitted Bayesian model was also used for illustrative what-if scenario analysis.

Three hypothetical economic scenarios were considered:

| Scenario | Investment Change | GRP Log Growth |
|---|---:|---:|
| Base | 0.0 | 0.08 |
| Optimistic | +10.0 | 0.12 |
| Stress | -10.0 | 0.00 |

The estimated annual changes in the unemployment rate were:

| Scenario | Estimated Annual Unemployment Change |
|---|---:|
| Base | -0.286 p.p. |
| Optimistic | -0.710 p.p. |
| Stress | +0.374 p.p. |

Under the optimistic scenario, stronger investment dynamics and GRP growth are associated with a larger decline in unemployment.

Under the stress scenario, weaker economic conditions are associated with an increase in unemployment.

These scenarios are **illustrative what-if simulations rather than forecasts of actual future economic conditions**.


## SQL Analysis

The processed annual dataset was loaded into **PostgreSQL** to create a separate analytical data layer.

SQL was used to:

- perform data quality and missing-value checks;
- analyze annual unemployment and macroeconomic dynamics;
- compare current values with previous years using window functions;
- classify economic conditions using `CASE` expressions;
- identify periods with the largest increases in unemployment;
- create a reusable analytical view for Power BI.

The final `unemployment_analytics` view combines the main economic indicators with calculated features such as year-over-year unemployment change and categorical trend indicators.

The SQL analysis highlighted **2009 and 2020** as the largest unemployment increases in the dataset. In both years, investment dynamics and GRP growth were negative.


## Power BI Dashboard

An interactive Power BI dashboard was created using the analytical PostgreSQL view as its data source.

The dashboard includes:

- latest unemployment rate and annual change KPIs;
- unemployment dynamics from 2000 to 2025;
- annual changes in unemployment;
- relationship between investment dynamics and unemployment changes;
- relationship between GRP growth and unemployment changes;
- an interactive year filter.

The dashboard provides a compact visual summary of the main findings identified during the Python and SQL analysis.

### Dashboard Preview

![Power BI Dashboard](dashboard/dashboard_preview.png)

## Conclusions

The analysis identified several important patterns in unemployment dynamics in the Republic of Tatarstan between 2000 and 2025.

- The unemployment rate demonstrated a strong long-term decline, from 12.1% in 2000 to 1.73% in 2025.
- Annual unemployment changes were negatively associated with both investment dynamics and GRP growth.
- GRP growth showed the strongest relationship with unemployment changes among the selected predictors.
- The largest unemployment increases occurred in 2009 and 2020, when both investment dynamics and GRP growth were negative.
- Bayesian regression results supported the negative association between the selected economic indicators and annual unemployment changes.
- Scenario analysis demonstrated how different combinations of investment dynamics and GRP growth could be associated with different unemployment trajectories.

Overall, the project demonstrates how Python, SQL, statistical modeling, and BI tools can be combined into a single analytical workflow.

## Limitations

The results should be interpreted with several limitations in mind:

- The annual dataset contains only 26 observations (2000–2025), which limits the statistical power of the analysis.
- The analysis is based on observational macroeconomic data and does not establish causal relationships.
- Macroeconomic indicators may be affected by common trends and external economic shocks.
- The scenario analysis uses hypothetical assumptions and should not be interpreted as an official economic forecast.
- Working-age population data is unavailable for the final two years and was not imputed.

## How to Run

### 1. Clone the repository

```bash
git clone <repository-url>
cd tatarstan-unemployment-analysis
```

### 2. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 3. Run the notebook

The notebooks are organized in the recommended execution order:

```text
01_data_preparation.ipynb
02_eda.ipynb
03_bayesian_model.ipynb
04_model_validation.ipynb
05_scenario_forecast.ipynb
```

### 4. PostgreSQL

Create a PostgreSQL database and execute the SQL scripts in the following order:

```text
01_create_tables.sql
02_data_quality.sql
03_analytical_queries.sql
04_analytical_dataset.sql
```

Import `data/processed/tatarstan_economic_data_clean.csv` into the `economic_indicators` table after creating the table.

### 5. Power BI

The Power BI report is available in:

```text
dashboard/tatarstan_unemployment_dashboard.pbix
```

The dashboard was built using the PostgreSQL analytical view `unemployment_analytics`.

## Author

**Regina Abdulmazitova**

Mathematics and Computer Science graduate  
Data Analytics Portfolio Project

**Tools:** Python · PostgreSQL · SQL · PyMC · Power BI




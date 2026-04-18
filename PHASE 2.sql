USE uk_high_street;

-- View 1: Closures by region
CREATE OR REPLACE VIEW v_closures_by_region AS
SELECT 
    county,
    company_status,
    COUNT(*) AS total_closures
FROM company_closures
WHERE county IS NOT NULL AND county != ''
GROUP BY county, company_status
ORDER BY total_closures DESC;

-- View 2: Closures by retail category
CREATE OR REPLACE VIEW v_closures_by_category AS
SELECT 
    sic_text,
    company_status,
    COUNT(*) AS total_closures
FROM company_closures
GROUP BY sic_text, company_status
ORDER BY total_closures DESC;

-- View 3: Rolling 3-month avg retail spend
CREATE OR REPLACE VIEW v_rolling_spend AS
SELECT 
    time_period,
    geography,
    retail_category,
    value,
    ROUND(AVG(value) OVER (
        PARTITION BY geography, retail_category
        ORDER BY time_period
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_3m_avg
FROM ons_retail_sales;

-- View 4: YoY change in retail spend
CREATE OR REPLACE VIEW v_yoy_spend AS
SELECT 
    time_period,
    geography,
    retail_category,
    value,
    LAG(value, 12) OVER (
        PARTITION BY geography, retail_category
        ORDER BY time_period
    ) AS value_prev_year,
    ROUND(
        (value - LAG(value, 12) OVER (
            PARTITION BY geography, retail_category
            ORDER BY time_period
        )) / LAG(value, 12) OVER (
            PARTITION BY geography, retail_category
            ORDER BY time_period
        ) * 100, 2
    ) AS yoy_pct_change
FROM ons_retail_sales;

-- Verify
SHOW FULL TABLES WHERE Table_type = 'VIEW';





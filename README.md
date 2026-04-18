# 🏪 UK High Street Health Monitor

An end-to-end data analytics portfolio project analysing whether consumer spending decline predicts high street business closures across the UK.

Built with **Python · MySQL · Prophet · Power BI** across 5 phases — from raw data ingestion to an interactive dashboard.

---

## 🔍 Key Findings

- **London** recorded the highest retail closure count (5,000+) between 2020–2024, followed by the North West and West Midlands
- **Mobile phone retail** (SIC 47421) and **carpet/flooring** (SIC 47530) show the strongest negative correlation with BOE rate rises (r = −0.62), suggesting these discretionary sectors are most rate-sensitive
- **Retail spend predicts closures with a lag of ~0 months** (r = 0.32 at lag 0, stabilising across lags) — indicating closures respond quickly to spending shifts
- The Prophet forecast projects UK retail spend to **remain broadly flat** through 2026–2027, with a narrow 95% CI around RSI ~100

---

## 🗂️ Project Structure

```
uk-high-street/
│
├── data/                          # Raw source data (not tracked — see Data Sources)
│   ├── dissolutions_YYYY_MM.csv   # Companies House bulk data (~2.8GB)
│   ├── ons_retail_sales.csv       # ONS Retail Sales Index
│   └── boe_base_rate.csv          # Bank of England base rate history
│
├── notebooks/
│   ├── PHASE_1.ipynb              # Data ingestion → MySQL
│   ├── PHASE_3_4.ipynb            # Prophet forecasting + Pearson correlation
│
├── sql/
│   └── PHASE_2.sql                # MySQL views (CTEs, window functions)
│
├── outputs/
│   ├── phase3_forecast.png        # Prophet forecast chart
│   ├── phase3_correlation.png     # BOE vs closures correlation chart
│   ├── P4_region_losses.csv       # Regional closure counts
│   ├── P4_sector_decline.csv      # Sector-level closure counts
│   ├── P4_spend_closure_lags.csv  # Lag correlation results
│   └── retail_spend_forecast.csv  # Prophet forecast values
│
├── assets/                        # Dashboard screenshots for README
│
└── README.md

```

---

## ⚙️ Tech Stack

| Layer | Tools |
|---|---|
| Data ingestion | Python, pandas, mysql-connector |
| Database | MySQL 8.4, SQLAlchemy |
| SQL analysis | CTEs, window functions (LAG, AVG OVER) |
| Forecasting | Facebook Prophet, BOE rate as external regressor |
| Correlation | Pearson r (scipy.stats / numpy fallback) |
| Visualisation | matplotlib, Power BI (Azure Maps, Area Chart) |

---

## 📁 Data Sources

| Source | Dataset | Link |
|---|---|---|
| Companies House | Bulk company data (dissolutions) | [download.companieshouse.gov.uk](https://download.companieshouse.gov.uk/en_output.html) |
| ONS | Retail Sales Index (monthly) | [ons.gov.uk](https://www.ons.gov.uk/businessindustryandtrade/retailindustry/datasets/retailsales) |
| Bank of England | Base rate history | [bankofengland.co.uk](https://www.bankofengland.co.uk/monetary-policy/the-interest-rate-bank-rate) |

---
## 📈 Phase Breakdown

| Phase | Description | Output |
|---|---|---|
| 1 | Raw CSV → MySQL ingestion (pandas chunked read, SIC47 filter) | 3 tables: `company_closures`, `ons_retail_sales`, `boe_base_rate` |
| 2 | SQL analysis layer (CTEs, window functions) | 4 views: closures by region/category, rolling spend, YoY change |
| 3 | Prophet time series forecast (BOE rate as regressor) | 12-month retail spend forecast + chart |
| 3 | Pearson correlation: BOE rate vs closures by SIC sector | Correlation bar chart |
| 4 | Regional + sector analysis, lag study | 3 output CSVs |
| 5 | Power BI dashboard (4 pages) | Interactive dashboard |

---

## 🧑‍💻 Author

**Chirag Chaudhary**  
Nottingham Trent University  
IBM Data Analyst Professional Certificate  

---

## 📄 Licence

MIT — free to use and adapt with attribution.

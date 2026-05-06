# **homelessness-analytics**
This analysis assesses the public‑sector costs of family homelessness, including temporary accommodation and NHS use. It also estimates savings from early intervention and calculates the Council’s return on investment in prevention.

## **HOMELESSNESS ANALYTICS & COST MODELLING**
A Comprehensive R Workflow for Trend Analysis, Forecasting, Prevention Modelling & ROI Evaluation

This repository contains a complete analytical workflow for understanding:
- Homelessness trends
- Modelling future scenarios
- Evaluating the financial impact of prevention strategies 

The project uses two datasets: 
- Homelessness Causes Dataset – used for trend analysis, year‑on‑year change, cause composition, and forecasting.
- Cost of Homelessness Dataset – used for cost modelling, counterfactual prevention scenarios, and ROI analysis. 

The analysis is designed for use by: 
- Local authorities
- Commissioning teams policy analysts
- And data professionals who need evidence‑based insights to support strategic planning and early‑intervention investment.

## **PROJECT OVERVIEW**
- A. Trend Analysis of Homelessness Causes: Reshapes raw data into long format, Visualises multi‑year trends across all causes,  Summarises average, minimum, and maximum change per cause, Produces stacked area charts showing cause composition over time.

- B. Forecasting Future Homelessness (Multiple Causes): Converts each cause into a time series, Fits ARIMA models using auto.arima(), Forecasts 5‑year projections for selected causes, Builds a multi‑panel dashboard using patchwork, Includes a dedicated forecast for Domestic Ejection.

- C. Cost Modelling & Prevention Scenarios: Cleans and parses currency fields (e.g., £1,234 → 1234), Computes average and total homelessness‑related costs, Models cost savings under prevention scenarios (10%, 25%, 50%), Visualises savings in £ millions.

- D. ROI (Return on Investment) Modelling: Estimates households prevented under each scenario, Applies intervention cost ranges (£1,500–£3,000 per household), Calculates total intervention cost, Computes ROI = cost savings ÷ intervention cost, Produces a structured ROI table for decision‑makers.

## **TECNOLOGIES & LIBRARIES**
This project uses the following R packages: 
- tidyverse – data manipulation
- janitor – cleaning column names
- lubridate – date handling
- forecast – ARIMA modelling & forecasting
- patchwork – dashboard layout
- scales – axis formatting
- readr / read.csv – data import
- dplyr - data manipulation
- tidyr - data reshaping
- ggplot2 - visualisation

## **VISUALISATIONS**
- Multi‑year trend lines
- Stacked area composition chart
- Forecast dashboard (multiple causes)
- Domestic ejection forecast
- Cost‑savings bar chart

## **TABLES**
A. Year‑on‑year change summary 
B. Prevention scenario savings 
C. ROI table

## **USE CASES**
This Analysis Supports: 
- Commissioning & service planning
- Early‑intervention business cases
- Budget allocation & cost‑avoidance modelling
- Policy development
- Performance reporting
- Strategic decision‑making

The project is particularly relevant for:
- Local authorities
- Housing & homelessness teams
- Children’s services
- Public health
- Data & insights teams

## **HOW TO RUN** 
This repository contains the full analysis code used for trending, forecasting, cost modelling, and ROI calculations.
The analysis can be reproduced using the analysis.R script; however, the underlying datasets are not included in this repository due to data‑sharing restrictions.
- Install the required R packages
- Place the authorised dataset in the data/ folder
- Open and run analysis.R
- Outputs will be generated in outputs/plots and outputs/tables

Users without access to the original dataset can still review the code, workflow, and example outputs.

## **SUMMARY** 
This project provides a complete analytical toolkit for understanding homelessness trends, forecasting future demand, and evaluating the financial impact of prevention strategies. It combines data science, forecasting, economics, and public‑sector insight into a single, reproducible workflow.

This project analyses homelessness trends, forecasting, cost modelling, prevention scenarios, and ROI modelling using R.

## **Project Structure**
```
homelessness-analytics/
├── data/                     # Raw and cleaned datasets (not all tracked if sensitive)
├── scripts/                  # R scripts for modular analysis
├── outputs/
│   ├── plots/                # Saved visualisations (trend, forecasts, cost plots)
│   └── tables/               # Saved summary tables (year‑on‑year change summary,costs, counterfactuals, ROI)
├── README.md                 # Project documentation
└── analysis.R                # Main analysis script

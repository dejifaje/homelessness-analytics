# homelessness-analytics
This analysis assesses the public‑sector costs of family homelessness, including temporary accommodation and NHS use. It also estimates savings from early intervention and calculates the Council’s return on investment in prevention.

HOMELESSNESS ANALYTICS & COST MODELLING
A Comprehensive R Workflow for Trend Analysis, Forecasting, Prevention Modelling & ROI Evaluation

This repository contains a complete analytical workflow for understanding homelessness trends, modelling future scenarios, and evaluating the financial impact of prevention strategies. 

The project uses two datasets: Homelessness Causes Dataset – used for trend analysis, year‑on‑year change, cause composition, and forecasting. Cost of Homelessness Dataset – used for cost modelling, counterfactual prevention scenarios, and ROI analysis. 

The analysis is designed for use by local authorities, commissioning teams, policy analysts, and data professionals who need evidence‑based insights to support strategic planning and early‑intervention investment.

PROJECT OVERVIEW
A. Trend Analysis of Homelessness Causes: Reshapes raw data into long format, Visualises multi‑year trends across all causes,  Summarises average, minimum, and maximum change per cause, Produces stacked area charts showing cause composition over time.

B. Forecasting Future Homelessness (Multiple Causes): Converts each cause into a time series, Fits ARIMA models using auto.arima(), Forecasts 5‑year projections for selected causes, Builds a multi‑panel dashboard using patchwork, Includes a dedicated forecast for Domestic Ejection.

C. Cost Modelling & Prevention Scenarios: Cleans and parses currency fields (e.g., £1,234 → 1234), Computes average and total homelessness‑related costs, Models cost savings under prevention scenarios (10%, 25%, 50%), Visualises savings in £ millions.

D. ROI (Return on Investment) Modelling: Estimates households prevented under each scenario, Applies intervention cost ranges (£1,500–£3,000 per household), Calculates total intervention cost, Computes ROI = cost savings ÷ intervention cost, Produces a structured ROI table for decision‑makers.

TECNOLOGIES & LIBRARIES
This project uses the following R packages 
A. tidyverse – data manipulation 
B. janitor – cleaning column names 
C. lubridate – date handling
D. forecast – ARIMA modelling & forecasting 
E. patchwork – dashboard layout 
F. scales – axis formatting 
G. readr / read.csv – data import 
H. dplyr - data manipulation 
I. tidyr - data reshaping 
J. ggplot2 - visualisation

VISUALISATIONS
A. Multi‑year trend lines
B. Stacked area composition chart 
C.Forecast dashboard (multiple causes) 
D. Domestic ejection forecast E. 
Cost‑savings bar chart

TABLES 
A. Year‑on‑year change summary 
B. Prevention scenario savings 
C. ROI table

USE CASES
This Analysis Supports: 
A. Commissioning & service planning 
B. Early‑intervention business cases 
C. Budget allocation & cost‑avoidance modelling 
D. Policy development 
E. Performance reporting 
F. Strategic decision‑making

It is particularly relevant for:
A. Local authorities 
B. Housing & homelessness teams 
C. Children’s services 
D. Public health 
E. Data & insights teams

SUMMARY 
This project provides a complete analytical toolkit for understanding homelessness trends, forecasting future demand, and evaluating the financial impact of prevention strategies. It combines data science, forecasting, economics, and public‑sector insight into a single, reproducible workflow.

# Homelessness Analytics Project
This project analyses homelessness trends, forecasting, cost modelling, prevention scenarios, and ROI modelling using R.

## Project Structure
```text
homelessness-analytics/
├── data/                     # Raw and cleaned datasets (not all tracked if sensitive)
├── scripts/                  # R scripts for modular analysis
├── outputs/
│   ├── plots/                # Saved visualisations (trend, forecasts, cost plots)
│   └── tables/               # Saved summary tables (year‑on‑year change summary,costs, counterfactuals, ROI)
├── README.md                 # Project documentation
└── analysis.R                # Main analysis script


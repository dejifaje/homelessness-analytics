# Forecast for domestic ejection


# Fit ARIMA model
model <- auto.arima(ejection_ts)

# Forecast next 5 years
forecast_ejection <- forecast(model, h = 5)

# Plot forecast
autoplot(forecast_ejection) +
  labs(title = " Five Years Forecast: Domestic Ejection Cases",
       x = "Year", y = "Projected Cases")



# Forecast for other causes on dashboard

selected_causes <- c("Dispute_.Violent_or_.Non_Violent", "Tenancy_.Loss_LA", "Tenancy_.Loss_RSA", "Tenancy_.Loss_PRS", "Discharged._from_.Institution", "Other")

forecast_plots <- list()

for (cause in selected_causes) {
  cause_data <- long_data %>%
    filter(cause == !!cause) %>%
    mutate(year = as.numeric(year),
           count = as.numeric(count)) %>%
    arrange(year)
  
  ts_data <- ts(cause_data$count, start = min(cause_data$year), frequency = 1)
  model <- auto.arima(ts_data)
  fc <- forecast(model, h = 5)
  
  p <- autoplot(fc) +
    labs(title = paste("Forecast:", gsub("_", " ", cause)),
         x = "Year", y = "Cases") +
    theme_minimal()
  
  forecast_plots[[cause]] <- p
}

dashboard <- wrap_plots(forecast_plots, ncol = 2)
dashboard
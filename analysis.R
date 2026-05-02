# First Data(Causes of Homelessness)

# Data Preparation
homeless_data <- read.csv("file path.csv", header = TRUE, skip = 1)
glimpse(homeless_data)
summary(homeless_data)
# reshape Data 
long_data <- homeless_data %>%
  pivot_longer(cols = -Year, names_to = "Cause", values_to = "Count")

# Trend Analysis
# check trend
ggplot(long_data, aes(x = Year, y = Count, color = Cause)) +
  geom_line(size = 1.2) +
  labs(title = "Trends in Causes of Homelessness (2013–2025)",
       x = "Year", y = "Number of Cases") +
  scale_y_continuous(
  labels = scales::label_comma(),                 # Correct function call
  breaks = pretty(long_data$Count, n = 6)         # Reduces number of tick marks
) +
  theme_minimal(base_size = 6) +
  theme(
    axis.text.y = element_text(size = 6),   # Adjust label size
    plot.title = element_text(face = "bold", size = 12),
    axis.title = element_text(face = "bold", size = 12),
    legend.position = "bottom",
    legend.text = element_text(size = 12, colour = "white"),
legend.title = element_text(size = 14, face = "bold", colour = "white")

  )

  theme_minimal()

# Year on year Change for the causes
summary_table <- long_data %>%
  group_by(Cause) %>%
  arrange(Year) %>%
  mutate(
    Change = Count - lag(Count),
    percent_change = round((Change / lag(Count)) * 100, 2)
  ) %>%
  summarise(
    avg_percent_change = mean(percent_change, na.rm = TRUE),
    min_percent_change = min(percent_change, na.rm = TRUE),
    max_percent_change = max(percent_change, na.rm = TRUE),
    .groups = "drop"
  )

print(summary_table)

# Cause Composition
ggplot(long_data, aes(x = Year, y = Count, fill = Cause)) +
  geom_area(alpha = 0.8, position = "stack") +
  labs(
    title = "Cause Composition of Homelessness Over Time",
    x = "Year",
    y = "Number of Cases",
    fill = "Cause"
  ) +
  scale_y_continuous(
    breaks = c(0, 1000, 2000, 3000, 4000),     # Y-axis breaks
    labels = label_comma()                     # Format Y-axis labels with commas
  ) +
  scale_x_continuous(
    breaks = seq(2012, 2025, by = 1)           # X-axis shows each year
  ) +
  theme_minimal(base_size = 6) +
  theme(
    axis.text.x = element_text(size = 6),
    axis.text.y = element_text(size = 6),     # Ensures Y-axis labels are visible
    axis.title.x = element_text(face = "bold", size = 12),
    axis.title.y = element_text(face = "bold", size = 12),
    plot.title = element_text(face = "bold", size = 12),
    legend.position = "bottom"
    
 )

# Prepare data for forecasting
# Reshape to long format and clean names
long_data <- homeless_data %>%
  pivot_longer(cols = -Year, names_to = "Cause", values_to = "Count") %>%
  clean_names()
# Check available cause names
unique(long_data$cause)
# Filter correctly
ejection_data <- long_data %>%
  filter(str_trim(cause) == "Domestic_.Ejection")
# Ensure numeric
ejection_data$year <- as.numeric(ejection_data$year)
ejection_data$count <- as.numeric(ejection_data$count)
# Create time series
ejection_ts <- ts(ejection_data$count,
                  start = min(ejection_data$year),
                  frequency = 1)

# Forecast multiple causes of homelessness and present the results in a single dashboard in R?
# Future forecast for other causes on dashboard
selected_causes <- c("Dispute_.Violent_or_.Non_Violent", "Tenancy_.Loss_LA", "Tenancy_.Loss_RSA", "Tenancy_.Loss_PRS", "Discharged._from_.Institution", "Other")

library(forecast)
library(ggplot2)

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

library(patchwork)

dashboard <- wrap_plots(forecast_plots, ncol = 2)
dashboard

# Forecast for domestic ejection
library(forecast)
# Fit ARIMA model
model <- auto.arima(ejection_ts)
# Forecast next 5 years
forecast_ejection <- forecast(model, h = 5)
# Plot forecast
autoplot(forecast_ejection) +
  labs(title = " Five Years Forecast: Domestic Ejection Cases",
       x = "Year", y = "Projected Cases")



# Second Data(Cost of Homelessness)

# Data Preparation.
# Read file, skip the title row
df_raw <- read_csv("file path.csv",
                   skip = 1, locale = locale(encoding = "latin1"))
# Clean up column names
df <- janitor::clean_names(df_raw)
# Vectorised currency parser
parse_currency <- function(x) {
  x <- as.character(x)                          # Ensure it's character
  x <- iconv(x, from = "", to = "UTF-8")        # Fix encoding issues
  x <- gsub("[^0-9.]", "", x)                   # Remove £, commas, etc.
  x <- ifelse(x == "", NA, x)                   # Replace empty strings with NA
  as.numeric(x)
}
# Convert columns to proper types
df <- df %>%
  mutate(
    total_monthly_cost_of_temporary_accommodation = parse_currency(total_monthly_cost_of_temporary_accommodation),
    total_monthly_cost_to_nhs = parse_currency(total_monthly_cost_to_nhs),
    total_cost_of_homelessness = parse_currency(total_cost_of_homelessness)
  )

# Check result
glimpse(df)

# Cost Modelling Summary
summary_stats <- df %>%
  summarise(
    avg_temp_accommodation = mean(total_monthly_cost_of_temporary_accommodation, na.rm = TRUE),
    avg_nhs_cost            = mean(total_monthly_cost_to_nhs, na.rm = TRUE),
    avg_total_cost          = mean(total_cost_of_homelessness, na.rm = TRUE),
    total_cost              = sum(total_cost_of_homelessness, na.rm = TRUE)
  )

print(summary_stats)

# Counterfactual Modelling
# Define prevention scenarios
prevention_levels <- c(0.10, 0.25, 0.50)

counterfactual <- map_dfr(prevention_levels, function(p) {
  savings <- df %>%
    summarise(
      savings = sum(total_cost_of_homelessness, na.rm = TRUE) * p
    ) %>%
    pull(savings)
  
  tibble(
    prevention_level = paste0(p*100, "%"),
    cost_savings = savings
  )
})

print(counterfactual)

# Visualisation of cost saving
library(ggplot2)

ggplot(counterfactual, aes(x = prevention_level, y = cost_savings/1e6)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Visualisation of Cost Savings under Prevention Scenarios",
    x = "Prevention Level",
    y = "Savings (£ millions)"
  )

# ROI Modelling
# Assume prevention intervention cost range (£1,500 – £3,000 per household)
# For simplicity, let's use average number of families in data as baseline
avg_households <- mean(df$all_families_with_chilldren_actual_in_temp_accommodation, na.rm = TRUE)

roi_table <- expand_grid(
  prevention_rate = prevention_levels,
  intervention_cost = c(1500, 3000)
) %>%
  mutate(
    # Number of households prevented
    households_prevented = avg_households * prevention_rate,
    # Total intervention cost
    prevention_total_cost = households_prevented * intervention_cost,
    # Cost savings (using total homelessness cost)
    cost_savings = sum(df$total_cost_of_homelessness, na.rm = TRUE) * prevention_rate,
    # ROI
    roi = cost_savings / prevention_total_cost
  )

print(roi_table)


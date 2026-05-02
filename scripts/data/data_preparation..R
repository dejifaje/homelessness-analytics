# Data 1 For Trend Analysis and Forecasting
# Read file, skip the title row
homeless_data <- read.csv("C:/Users/dejif/OneDrive - University of Stirling/Documents/Homeless Data/Data.csv", header = TRUE, skip = 1)
glimpse(homeless_data)
summary(homeless_data)
names(homeless_data)

# reshape Data 
long_data <- homeless_data %>%
  pivot_longer(cols = -Year, names_to = "Cause", values_to = "Count")


# prepare data for forecasting
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

# Plot
plot(ejection_ts, main = "Domestic Ejection Over Time",
     xlab = "Year", ylab = "Count", col = "blue", lwd = 2)



# Data 2 for Cost Modelling and ROI Modelling
# Read file, skip the title row
df_raw <- read_csv("C:/Users/dejif/OneDrive - University of Stirling/Documents/Homeless Data/Book.csv",
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
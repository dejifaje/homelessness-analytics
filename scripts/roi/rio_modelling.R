
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

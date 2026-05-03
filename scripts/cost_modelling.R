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
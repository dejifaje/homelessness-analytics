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
    legend.position = "bottom"
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



# Cause Composition of Homelessness Over Time
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

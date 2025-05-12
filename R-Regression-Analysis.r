library(readxl)
library(ggplot2)

# Load the dataset from Excel
data <- read_excel("extracted_data.xlsx")  # Update the path
head(data)
colnames(data)
# Run the linear regression model
model <- lm(Disease_Progression_Markers ~ Bacterial_Load, data = data)

# View the summary of the model
summary(model)

p <- ggplot(data, aes(x = Bacterial_Load, y = Disease_Progression_Markers)) +
  geom_point(color = "blue", size = 4) +  # Larger, blue points
  geom_smooth(method = "lm", color = "red", fill = "gray", alpha = 0.3) +  # Trend line & confidence interval
  geom_text(aes(label = Tumor_Type), vjust = -1, size = 3, color = "black") +  # Smaller labels
  labs(
    title = "Bacterial Load vs. Disease Progression",
    subtitle = "Linear Regression Analysis with Confidence Interval",
    x = "Bacterial Load (%)",
    y = "Disease Progression Markers",
    caption = "Data Source: Your Study"
  ) +
  theme_minimal() +  # Clean theme
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    axis.title = element_text(face = "bold")
  )

# Display the plot
print(p)

sink("regression_results.txt")
print(summary(model))
sink()

ggsave("regression_plot.png", width = 6, height = 4)
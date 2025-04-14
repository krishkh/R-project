# Load libraries
library(ggplot2)
library(dplyr)
library(car)        # for ANOVA and linear model support
library(lmtest)     # for testing regression models

# Load cleaned dataset
df <- read.csv(here::here("Data", "Clean", "RSCH8230_CleanedData.csv"))

# Summary statistics
#print(summary(df))

# Structure of the data
#print(str(df))

# Create a simple binary group: High vs Low Schooling
df$SchoolingGroup <- ifelse(df$Schooling >= median(df$Schooling, na.rm = TRUE), "High", "Low")
df$SchoolingGroup <- as.factor(df$SchoolingGroup)

# Check group sizes
print(table(df$SchoolingGroup))

# Perform t-test to compare Life Expectancy by Schooling Group
t_test_result <- t.test(Life.expectancy ~ SchoolingGroup, data = df)
print(t_test_result)

# Simple linear regression model: predict Life Expectancy from GDP, Schooling, Alcohol
model.full <- lm(Life.expectancy ~ GDP + Schooling + Alcohol + HIV.AIDS, data = df)
print(summary(model.full))
model.refined <- lm(Life.expectancy ~ GDP + Schooling + HIV.AIDS, data = df)
print(summary(model.refined))



# Visualization 1: Histogram of Life Expectancy
ggplot(df, aes(x = Life.expectancy)) +
  geom_histogram(fill = "skyblue", color = "black", bins = 30) +
  labs(title = "Distribution of Life Expectancy", x = "Life Expectancy", y = "Frequency")
print(last_plot())  # Explicitly print the plot
# Visualization 2: Boxplot by Schooling Group
ggplot(df, aes(x = SchoolingGroup, y = Life.expectancy, fill = SchoolingGroup)) +
  geom_boxplot() +
  labs(title = "Life Expectancy by Schooling Group", x = "Group", y = "Life Expectancy") +
  theme_minimal()
print(last_plot())  # Explicitly print the plot
# Export Model Summary to CSV
write.csv(summary(model)$coefficients, here::here("Output", "Model_Summary.csv"))

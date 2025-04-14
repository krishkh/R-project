# installed the packages readxl, DataExplorer, here, openxlsx

# Load required libraries which we installed above

library(DataExplorer)  # for generating data profiling reports
library(here)          # for managing file paths
library(openxlsx)      # for exporting cleaned data to Excel

# Set path to the raw data file
raw_data_path <- here("Data", "Raw", "RSCH8230_Final Project_data.csv")

# Load the raw data into a dataframe
df.raw <- read.csv(raw_data_path)

# View the first few rows of the dataset to check
# print(head(df.raw))

# Set the output directory for the profiling report
output_dir <- here("Output")

# Here we create a profiling report for the raw data in HTML format
#create_report(data = df.raw,
 #             output_file = "DataProfilingReport_Raw.html",
  #            output_dir = output_dir)

# Check the structure of the dataset (data types)
# str(df.raw)

# Summary of each column (check for numeric, categorical, etc.)
# print(summary(df.raw))

# Count missing values in each column
# print(colSums(is.na(df.raw)))

# Convert character columns to numeric (if needed)
df.raw$Adult.Mortality <- as.numeric(df.raw$Adult.Mortality)
df.raw$percentage.expenditure <- as.numeric(df.raw$percentage.expenditure)
df.raw$BMI <- as.numeric(df.raw$BMI)
df.raw$Status <- as.factor(df.raw$Status)
df.raw$Country <- as.factor(df.raw$Country)

# we are gonna clean all these columns with their mean values, because it seems doable 
# and these columns look a bit important

cols_to_fix <- c("Life.expectancy", "Alcohol", "HIV.AIDS", "GDP", "Population", 
                 "Schooling", "Income.composition.of.resources", "Total.expenditure", "Adult.Mortality","percentage.expenditure","BMI")

for (col in cols_to_fix) {
  df.raw[[col]][is.na(df.raw[[col]])] <- mean(df.raw[[col]], na.rm = TRUE)
}

# we are dropping X because that is literally a junk column
df.raw$X <- NULL

str(df.raw)

#print(colSums(is.na(df.raw)))
# Export cleaned data to CSV
write.csv(df.raw, here("Data", "Clean", "RSCH8230_CleanedData.csv"), row.names = FALSE)




# Load necessary libraries
library(caret)
library(randomForest)

# Load the data
housing_data <- read.csv("housing_data.csv")

# Inspect the data
summary(housing_data)

# Convert categorical variables to factors
housing_data$location <- as.factor(housing_data$location)

# Train-test split
set.seed(123)
train_index <- createDataPartition(housing_data$maxbudget, p=0.7, list=FALSE)
train_data <- housing_data[train_index,]
test_data <- housing_data[-train_index,]

# Train a random forest model to predict location based on budget, rooms, and rent
rf_model <- randomForest(location ~ totalrent + individualrent + maxbudget + rooms, data=train_data, ntree=100)

# Predictions
predictions <- predict(rf_model, test_data)

# Model accuracy
confusionMatrix(predictions, test_data$location)

# Feature importance
importance(rf_model)

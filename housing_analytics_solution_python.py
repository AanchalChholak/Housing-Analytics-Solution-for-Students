
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report

# Load the dataset
# Assume 'housing_data.csv' contains columns: 'totalrent', 'individualrent', 'maxbudget', 'rooms', 'roommates', 'location', 'transport', 'conveniencestore', 'pharmacy', 'gymnasium', 'distance'
housing_data = pd.read_csv('housing_data.csv')

# Basic statistics of the dataset
print(housing_data.describe())

# Distribution of total rent and individual rent
plt.figure(figsize=(10, 6))
sns.histplot(housing_data['totalrent'], kde=True, color='blue', label='Total Rent')
sns.histplot(housing_data['individualrent'], kde=True, color='green', label='Individual Rent')
plt.legend()
plt.title('Distribution of Total Rent and Individual Rent')
plt.show()

# Correlation between rent and roommates
plt.figure(figsize=(10, 6))
sns.scatterplot(x='roommates', y='totalrent', data=housing_data)
plt.title('Total Rent vs Roommates')
plt.show()

# Scatter plot for Individual Rent vs Roommates
plt.figure(figsize=(10, 6))
sns.scatterplot(x='roommates', y='individualrent', data=housing_data, color='orange')
plt.title('Individual Rent vs Roommates')
plt.show()

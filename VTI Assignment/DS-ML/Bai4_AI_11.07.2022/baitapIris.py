from unittest import result
import numpy as np
from numpy import nan
import pandas as pd

from sklearn.experimental import enable_iterative_imputer
from sklearn.linear_model import BayesianRidge

from sklearn.impute import KNNImputer, SimpleImputer, IterativeImputer

df = pd.read_csv('Iris.csv')

# nullcheck = df.isnull().sum()
# print(nullcheck)

# drop rows with missing data
# df.dropna(inplace=True)

#statistic imputation
# for rows in range(df.shape[1]):
#     n_miss = df[[rows]].isnull().sum()
#     perc = n_miss / df.shape[0] * 100
#     print('%d Missing : %d (%.1f%%)' % (rows, n_miss, perc))

#define obj
# data1 = [[12, np.nan, 34], [10, 32, np.nan],
#         [np.nan, 11, 20]]

# obj = SimpleImputer(missing_values = np.nan, strategy = 'mean')
# data = df[['Id', 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm']]
# obj = obj.fit(data)
# data = obj.transform(data)
# print(data)

#define imputer
# imputer = KNNImputer(n_neighbors = 5, weights = 'distance', metric = 'nan-euclidean')
# data = df[['Id', 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm']]
# imputer = imputer.fit(df)
# data = imputer.transform(df)
# print(data)

##########
imputer = IterativeImputer(estimator=BayesianRidge(), imputation_order='ascending')
data = df[['Id', 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm']]
#fit on the dataset
imputer = imputer.fit(data)
#transform the dataset
data = imputer.transform(data)
print(data)
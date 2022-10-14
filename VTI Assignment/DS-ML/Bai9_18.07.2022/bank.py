import numpy as np
import pandas as pd
from sklearn.preprocessing import OneHotEncoder

df = pd.read_csv('Banking_Marketing.csv')
print(df)
print(df.dropna())

#Bai 3

data_column_category = df.select_dtypes(exclude=[np.number]).columns
print(data_column_category)

#Bai 4

data_column_number = df.select_dtypes(include=[np.number]).columns
print(data_column_number)

data1 = df[data_column_category]

# Bai5
encoder = OneHotEncoder(sparse=False)
#transform data
onehot = encoder.fit_transform(data1)
print(onehot)


# Bai6
encoder = OneHotEncoder(drop='first', sparse=False)
#transform data
onehot = encoder.fit_transform(data1)
print(onehot)

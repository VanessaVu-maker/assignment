import numpy as np
import pandas as pd

df = pd.read_excel('exercise1.xlsx')
print(df)

# 1. Write a Pandas program to detect missing values of a given DataFrame. Display True or False.
# print(df.isnull())
print(df.isna())

# 2. Write a Pandas program to identify the columns of a given DataFrame which have at least one missing value
print(df.isna().any())
# 3. Write a Pandas program to count the number of missing values in each column of a given DataFrame.
print(df.isna().sum())
# 4. Write a Pandas program to find and replace the missing values in a given DataFrame which do not have any valuable information.
rep = df.fillna(0)
print(rep)
# 5. Write a Pandas program to drop the rows where at least one element is missing in a given DataFrame.
# print(df.dropna())
# 6. Write a Pandas program to drop the columns where at least one element is missing in a given DataFrame.
# print(df.dropna(axis=1))
# 7. Write a Pandas program to drop the rows where all elements are missing in a given DataFrame.
print(df.dropna(how='all'))


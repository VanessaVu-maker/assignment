import pandas as pd
import numpy as np

sample = pd.Series([2, 8, 4, -6], index=['a','b','c','d'])
# print(sample)

sampleDataFrame = {'Country': ['Singapore', 'Australia', 'Vietnam',],
                    'Capital': ['Singapore', 'Canberra', 'Hanoi',],
                    'Population': [19, 45, 90]
                    }
df = pd.DataFrame(sampleDataFrame, columns=['Country', 'Capital', 'Population'])

# print(df[1:])

# df1 = pd.DataFrame(sampleDataFrame, columns=['Country'])
# print (df1)
# print (df1.dtypes)

# df2 = df.at[2,'Country']
# print(df2)

# df3 = df.at[1,'Population']
# print(df3)

# df4 = df.values
# print(df)

# df5 = df.axes
# print(df5)

# print(sample.ndim)
# print(df.size)
# print(sample.size)
# print(df.shape)
# print(df.memory_usage())

# print(df.iloc[0, 2])

# print(df[df['Population']>45])
# df['Population'] = 100

# Create 1 array size(3,4), value from 0-12
# arr = pd.DataFrame(np.arange(12).reshape(3,4), columns=['A', 'B', 'C', 'D'])
# print(arr)

# # arr1 = arr.drop(['C','D'], axis=1)
# # print(arr1)

# arr2 = arr.drop([0, 1])
# print(arr2)

# arr3 = pd.DataFrame([1,2,3,4,5], index=[100,4,67,38,52], columns=['A'])
# print(arr3)

# # arr4_sort = arr3.sort_index(ascending=True)
# # print(arr4_sort)

# arr6_sortValue = arr3.sort_values(by = 'A', ascending=False)
# print(arr6_sortValue)

s3 = pd.Series([7, -2, 3, np.nan], index=['a', 'b', 'c', 'd'])
# s4 = pd.DataFrame([[np.nan, 2, np.nan, 0], [3,4,np.nan, 1], [np.nan, 5, np.nan, 7]], columns = list("ABCD"))
# s5 = s4.fillna(0)
# print(s5)

# print(s3)
# s7 = pd.Series([np.nan, 4, np.nan, 1], index=['x', 'y', 'z', 't'])
# print(s7.add(s3, fill_value=0))

### read_csv(phai co link csv da)
# a4 = pd.read_csv("http://winterolympicsmedals.com/medals.csv", nrows=10, usecols=(1,5,7))
# print(a4)

# a6 = pd.read_table('dataSample.txt', sep="\t")
# print(a6)


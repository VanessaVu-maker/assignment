import numpy as np
import pandas as pd

# data = np.genfromtext('ch3_data2.csv', delimeter=',', names=True)
# print(data)

data1 = pd.DataFrame({'name':['Hoang Dao Thuy', 'Tran Quoc Tuan'],
                    'year': [26, 28],
                    'sex': ['woman','man']
                    })

# data1.to_csv('ExportToFile.csv', index=True)

# data1.to_excel('ExportToFile.xlsx', index=False)

# data1.to_json('ExportToFileJson.json')

# x = data1.shape
# print(x)

# index = data1.index
# print(index)

# list_column = data1.columns
# print(list_column)

# info = data1.info()
# print(info)

# desc = data1.describe()
# print(desc)

# cout = data1.count()
# print(cout)

# Sum = data1.sum()
# print(Sum)

# P = data1.cumsum()
# print(P)

# minX = data1.min()
# maxX = data1.max()
# print(minX)
# print(maxX)

# Me = data1.mean()
# print(Me)

Med = data1.median()
print(Med)
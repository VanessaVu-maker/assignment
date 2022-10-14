from numpy import asarray
from sklearn.preprocessing import OrdinalEncoder, OneHotEncoder

# #define data
# data = asarray([['red'],['green'],['blue']])
# print (data)

# #define ordinal encoding
# encoder = OrdinalEncoder()

# #transform data
# result = encoder.fit_transform(data)
# print(result)

# data2 = asarray([['red'],['green'],['blue'],['gray'],['red']])
# print(data2)

# #define one hot encoding
# encoder = OneHotEncoder(sparse=False)
# #transform data
# onehot = encoder.fit_transform(data2)
# print(onehot)


data3 = asarray([['red'],['green'],['blue']])
print(data3)

#define one hot encoding
encoder = OneHotEncoder(drop='first', sparse=False)
#transform data
onehot = encoder.fit_transform(data3)
print(onehot)

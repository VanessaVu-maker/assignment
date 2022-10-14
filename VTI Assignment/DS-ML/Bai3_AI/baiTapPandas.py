import numpy as np
import pandas as pd

df = pd.read_csv('Automobile_data.csv')

# Bai 1: In ra 5 hang dau tien va 5 hang cuoi cung
# print(df.head(5))
# print(df.tail(5))

# Bai 2: Thay the gia tri cac cot chua n.a, Nan, ?
# df.fillna(0)
# df.replace({'?','0'})

#Bai 3: Tin ten hang xe hoi dat tien nhat
# df_max = df[['company', 'price']][df.price == df['price'].max()]
# print(df_max)

# Bai 4: In tat ca thong tin cua Toyota
# car_group = df.groupby('company')
# toyota_list = car_group.get_group('toyota')
# print(toyota_list)

# Bai 5: Dem tong so xe cua moi cong ti
# car_count = df['company'].value_counts()
# print(car_count)

# Bai 6: Tim chiec xe co gia cao nhat cua moi cong ti
# car_max = df.groupby('company')['price'].max()
# print(car_max)

# Bai 7: Tim quang duong trung binh cua moi cong ti 
# car_average = df.groupby('company')['average-mileage'].mean()
# print(car_average)

# Bai 8: Sap xep tat ca cac o to theo cot Gia
# sort =  df[['company', 'price']].sort_values('price')
# print(sort)

# Bai 9: Ghep 2 dataframe bang nhung dk khac nhau
# GermanCars = pd.DataFrame(
#     {
#         'Company': ['Ford', 'Mer', 'BMW', 'Audi'],
#         'Price': [111111, 222222, 333333, 444444]
#     }
# )

# JapanCars = pd.DataFrame(
#     {
#         'Company': ['Toyota', 'Honda', 'Nissan', 'Mitsubishi'],
#         'Price': [111111, 222222, 333333, 444444]
#     }
# )

# frames = [GermanCars, JapanCars]
# result = pd.concat(frames)

# print(result)

# Bai 10: Hop nhat 2 dataframe
car_price = pd.DataFrame(
    {
        'Company': ['Toyota', 'Honda', 'BMW', 'Audi'],
        'Price': [111111, 222222, 333333, 444444]
    },
    index = [0, 1, 2, 3]
)

car_horsepower = pd.DataFrame(
     {
        'Company': ['Toyota', 'Honda', 'BMW', 'Audi'],
        'Horsepower': [141, 80, 182, 160]
    },
    index = [0, 1, 2, 3]   
)

frames = car_price.merge(car_horsepower)
print(frames)
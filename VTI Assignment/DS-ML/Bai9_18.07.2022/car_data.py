import numpy as np
import pandas as pd

df = pd.read_csv('Cars_Data.csv')
print(df)
# Bai 1: Lam min du lieu file csv data va cap nhat file do

# Bai 2: TIm xem gia cua hang o to nao la dat nhat

# df_max = df[['brand', 'price']][df.price == df['price'].max()]
# print(df_max)

# Bai 3: In tat ca thong tin cua Nissan
# car_group = df.groupby('brand')
# nissan_list = car_group.get_group('nissan')
# print(nissan_list)

# Bai 4: TInh tong so o to cua moi hang
# car_count = df['brand'].value_counts()
# print(car_count)

# Bai 5: Tim chiec xe co gia cao nhat cua moi cong ti
# car_max = df.groupby('brand')['price'].max()
# print(car_max)

# Bai 6: Tim quang duong trung binh cua moi cong ti 
car_average = df.groupby('brand')['mileage'].mean()
print(car_average)


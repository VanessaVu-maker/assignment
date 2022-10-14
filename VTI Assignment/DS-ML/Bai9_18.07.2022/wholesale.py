from lib2to3.pgen2.pgen import DFAState
import numpy as np
import pandas as pd
from sklearn.preprocessing import MinMaxScaler, StandardScaler

# 1.	Data Transformation
# Sử dụng dữ liệu mẫu file : Wholesale customers data.csv để thực hành:

df = pd.read_csv('Wholesale customers data.csv')
print(df)

# Bài 1: Kiểm tra xem có dữ liệu bị thiếu hay không nếu có, hãy bỏ dữ liệu bị thiếu. Su dung MinMaxScaler()
# Bài 2: Thực hiện chia tỷ lệ Chuẩn hóa. Để làm như vậy, hãy sử dụng lớp MinMaxScaler () từ sklearn.preprocessing và triển khai phương thức fit_transorm ()

# tạo bộ scaler
scaler = MinMaxScaler()
# fit scaler vào data
scaler.fit(DFAState)
# fit và transform đồng thời
normalized = scaler.fit_transform(df)
# quay lại miền giá trị cũ
inverse = scaler.inverse_transform(normalized)

# Bài 3: Kiểm tra xem có dữ liệu bị thiếu hay không nếu có, hãy bỏ dữ liệu bị thiếu. Su dung StandardScaler()
# Bài 4: Thực hiện chia tỷ lệ Chuẩn hóa. Để làm như vậy, hãy sử dụng lớp StandardScaler() từ sklearn.preprocessing và triển khai phương thức fit_transorm ()


# create scaler
scaler = StandardScaler()
# fit and transform in one step
standardized = scaler.fit_transform(df)
# inverse transform
inverse = scaler.inverse_transform(standardized)

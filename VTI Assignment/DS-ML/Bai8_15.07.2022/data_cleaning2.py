from numpy import asarray
from sklearn.preprocessing import MinMaxScaler

data = asarray([[100, 0.001],
                [8, 0.05],
                [50, 0.005],
                [88, 0.07],
                [4, 0.01]]

)

print(data)

scaler = MinMaxScaler()

scaled = scaler.fit_transform(data)
print(scaled)
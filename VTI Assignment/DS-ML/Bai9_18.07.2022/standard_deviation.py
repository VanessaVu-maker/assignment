from numpy.random import seed
from numpy.random import randn
from numpy import mean
from numpy import std

seed(1)
#generate data
data = 5 * randn(10000) + 50

data_mean = mean(data)
data_std = std(data)

cut_off = data_std * 3
lower = data_mean - cut_off
upper = data_mean + cut_off

#define outliers
outliers = [x for x in data if x < lower or x > upper]
print('identified outliers : %d' % len(outliers))

outliers_removed = [x for x in data if x >= lower and x <= upper]
print('No - outlier observation  : %d' % len(outliers_removed))

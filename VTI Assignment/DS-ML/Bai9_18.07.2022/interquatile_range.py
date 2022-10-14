from numpy.random import seed
from numpy.random import randn
from numpy import percentile

seed(1)

data = 5 * randn(10000) + 50

Q1, Q3 = percentile(data, 25), percentile(data, 75)
IQR = Q3 - Q1
print('Interquartile : Q1 = %.3f, Q3 = %.3f, IQR = %.3f' % (Q1, Q3, IQR))

#calculate the outlier cutoff
cut_off = IQR * 1.5
lower, upper = Q1 - cut_off, Q3 + cut_off

#identify outliers
outliers = [x for x in data if x < lower or x > upper]
print('Identified outliers: %d' % len(outliers))

#remove outliers
outliers_removed = [x for x in data if x >= lower and x <= upper]
print('Non-outliers observation : %d' % len(outliers_removed))
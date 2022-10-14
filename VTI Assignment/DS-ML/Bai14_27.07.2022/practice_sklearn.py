from locale import normalize
from sklearn import neighbors, datasets, preprocessing
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import Normalizer, LabelEncoder

from sklearn.linear_model import LinearRegression
from sklearn.svm import SVC
from sklearn.naive_bayes import GaussianNB

from sklearn.decomposition import PCA
from sklearn.cluster import KMeans

from sklearn.metrics import classification_report, adjusted_rand_score, homogeneity_score, v_measure_score
from sklearn.metrics import confusion_matrix, mean_absolute_error, mean_squared_error

import numpy as np

X = np.random.random((10,5))
y = np.array(['M', 'N', 'F', 'F', 'M', 'F', 'M', 'M', 'F', 'F','F'])
X[X < 0.7] = 0

iris = datasets.load_iris()
X, y = iris.data[:, :2], iris.target
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=33)
scaler = preprocessing.StandardScaler().fit(X_train)


#Standardization
standardized_X = scaler.transform(X_train)
standardized_X_test = scaler.transform(X_test)

# print(standardized_X)
# print(standardized_X_test)

#Normalization
scaler2 = Normalizer().fit(X_train)
normalized_X = scaler2.transform(X_train)
normalized_X_test = scaler2.transform(X_test)

# print(normalized_X)
# print(normalized_X_test)

#Encoded Categorical Feature
enc = LabelEncoder()
y = enc.fit_transform(y)

# print(y)

# Missing Data
# imp = Imputer(missing_values = 0, strategy = 'mean', axis=0)
# imp.fit_transform(X_train)

knn = neighbors.KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train, y_train)
y_pred = knn.predict(X_test)
print(y_pred)
accuracy_score(y_test, y_pred)


# print(y_pred)

# Create ML Model - SUPERVISED LEARNING
# 1.Linear Regression
lr = LinearRegression(normalize=True)
lr.fit(X, y)
y_pred = lr.predict(X_test)


# 2.Support Vector Machines
# svc = SVC(kernel='linear')
# svc.fit(X_train, y_train)
# y_pred = svc.predict(np.random.random((2,5)))
# print(y_pred)

# 3.Naive Bayes
gnb = GaussianNB()

# 4. KNN
knn = neighbors.KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train, y_train)
y_pred = knn.predict(X_test)
# print(y_pred)


# Create ML Model - UNSUPERVISED LEARNING
# 1. Principal Component Analysis (PCA)
pca = PCA(n_components = 0.95)
pca_model = pca.fit_transform(X_train)


#2. K means
k_means = KMeans(n_clusters=3, random_state=0)
k_means.fit(X_train)
y_pred = k_means.predict(X_test)
print(y_pred)

#EVALUATE

print(classification_report(y_test, y_pred))

print(confusion_matrix(y_test, y_pred))

import pandas as pd
from sklearn.model_selection import KFold, train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix

filename = 'pima-indians-diabetes.csv'
names = ['preg', 'plas', 'pres', 'skin', 'test', 'mass', 'pedi', 'age', 'class']
dataframe = pd.read_csv(filename, names = names)

arr = dataframe.values
X = arr[:, 0:8]
Y = arr[:,8]

kfold = KFold(n_splits=10, random_state=None)
model = LogisticRegression()
scoring = 'accuracy'
results = cross_val_score(model, X, Y, cv=  kfold, scoring = scoring)
print("Accuracy: %.3f " % results.mean())
print("Accuracy: (%.3f) " % results.std())
print("Error Rate: %.3f" % (1 - results.mean() ))

test_size = 0.33
seed = 7
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = test_size, random_state=seed)
model.fit(X_train, Y_train)
predicted = model.predict(X_test)
matrix = confusion_matrix(Y_test, predicted)
print(matrix)
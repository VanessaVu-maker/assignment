import pandas as pd
from sqlalchemy import Table, Column, Integer, MetaData, create_engine, String
engine = create_engine('sqlite:///memory.db', echo = True)
meta = MetaData()
students = Table(
    'students', meta,
    Column('id', Integer, primary_key = True),
    Column('name', String),
    Column('lastname', String),
)

conn = engine.connect()
meta.create_all(engine)

conn.execute(students.insert(),[
    {'name':'Hoang Dao', 'lastname':'Thuy'},
    {'name':'Le Quang', 'lastname':'Dao'},
    {'name':'Tran Quoc', 'lastname':'Tuan'},
])

### 3 lenh duoi kha tuong duong nhau

# obj = pd.read_sql("SELECT * FROM students;", engine)
# print(obj)

# obj2 = pd.read_sql_table('students', engine)
# print(obj2)

obj3 = pd.read_sql_query("SELECT * FROM students;", engine)
print(obj3)

### Export dataset to csv

obj4 = obj3.to_sql('mySQL', engine)
print(obj4)


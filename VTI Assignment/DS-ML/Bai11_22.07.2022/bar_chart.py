import plotly.express as px
import pandas as pd
import numpy as np
import plotly.graph_objects as go

df = pd.read_csv('Cars_Data.csv')
data_bar = px.bar(df, x='brand', y='price', hover_data=['price', 'brand'], color = 'price')
data_bar.show()
# from pathlib import Path
# import openpyxl as xl
import plotly.express as px
import pandas as pd
import numpy as np
import plotly.graph_objects as go


# data_excel = pd.read_excel("Cars_Data.xlsx")

# wb = xl.load_workbook(data_excel)
# fig = go.Figure()
# for sheet in wb.worksheets:
#     df = pd.read_excel(data_excel, sheet_name = sheet.title)
#     fig = fig.add_traces(px.line(df, x='Unnamed:0', y='Unnamed:2').update_traces(name=sheet.tittle, showlegend=True).data)

# fig.show()


# data = px.line(x=["Jan", "Feb", "March", "Apr", "May", "Jun"], y=[45.6, 47, 56, 34, 59, 66])

# data.show()

# #Bar chart
# data_bar_chart = px.bar(x=["a","b","c"], y=[1,4,7])
# data_bar_chart.show()


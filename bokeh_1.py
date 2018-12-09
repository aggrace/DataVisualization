import numpy as np

from bokeh.io import show
from bokeh.layouts import column
from bokeh.models import ColumnDataSource, RangeTool
from bokeh.plotting import figure,output_file
#from bokeh.sampledata.stocks import AAPL
import pandas as pd
from bokeh.models import LinearAxis, Range1d
#TOOLS = "pan,wheel_zoom,box_zoom,reset,save,box_select"

temp_usage = pd.read_csv('~/Desktop/temusage.csv')

dates = np.array(temp_usage['date'], dtype=np.datetime64)
source = ColumnDataSource(data=dict(date=dates, close=temp_usage['freq']))

source2 = ColumnDataSource(data=dict(date=dates, close=temp_usage['ave_temp']))

p = figure(plot_height=600, plot_width=1200, tools="", toolbar_location=None,
           x_axis_type="datetime", x_axis_location="above",
           background_fill_color="#efefef", x_range=(dates[0], dates[656]), title='The bike usage and temperature change over time')
    

p.line('date', 'close', source=source, legend='Bike usage')
p.yaxis.axis_label = 'Number of bike usage'
p.y_range = Range1d(500, 20000)


p.extra_y_ranges = {"Temperature": Range1d(start=0, end=100)}
p.add_layout(LinearAxis(y_range_name="Temperature",axis_label="Temperature"), 'right')
p.line('date', 'close', source = source2, y_range_name='Temperature', color='red', legend='Temperature')

select = figure(title="The bike usage and temperature change over time",
                plot_height=130, plot_width=800, y_range=p.y_range,
                x_axis_type="datetime", y_axis_type=None,
                tools="", toolbar_location=None, background_fill_color="#efefef")

range_rool = RangeTool(x_range=p.x_range)
range_rool.overlay.fill_color = "navy"
range_rool.overlay.fill_alpha = 0.2

select.line('date', 'close', source=source)
select.ygrid.grid_line_color = None
select.add_tools(range_rool)
select.toolbar.active_multi = range_rool

output_file("usage_temp.html", title="The bike usage and temperature change over time")

show(column(p, select))

#print(p.x_range)

from bokeh.io import show, output_file
from bokeh.models import ColumnDataSource,Whisker
from bokeh.palettes import Spectral7
from bokeh.plotting import figure
import pandas as pd
from bokeh.models import LinearAxis, Range1d
from bokeh.models import HoverTool

TOOLS = 'box_zoom,pan,save,hover,reset,tap,wheel_zoom'


output_file("type_usage.html")


type_usage = pd.read_csv("~/Desktop/wtypeusage.csv")

weather_type = ['clear-day','cloudy', 'fog','partly-cloudy-day','partly-cloudy-night','rain','snow']
source = ColumnDataSource(data=dict(weather_type=type_usage['icon'], counts=type_usage['num'], usage=type_usage['usage'],color=Spectral7))

source2 = ColumnDataSource(data=dict(weather_type=type_usage['icon'], counts=type_usage['num'],usage=type_usage['usage']))

p = figure(x_range=type_usage['icon'], y_range=(0,400), plot_height=700, plot_width=900,title="Bike usage among different weather type",
           toolbar_location=None, tools=TOOLS)


p.vbar(x='weather_type', top='counts', width=0.9, color='color', legend="weather_type", source=source)
p.yaxis.axis_label = 'Number of days'

p.extra_y_ranges = {"Usage": Range1d(start=1000, end=12000)}
p.add_layout(LinearAxis(y_range_name="Usage",axis_label="bike usage per day"), 'right')
p.line('weather_type', 'usage', source = source2, y_range_name='Usage', color='purple', legend='Usage',line_width=2)

hover = p.select(dict(type=HoverTool))
hover.tooltips = [
        ("weather_type", "@weather_type"),
        ("days", "@counts"),
        ("bike usage", "@usage"),
        ]

p.xgrid.grid_line_color = None
p.legend.orientation = "horizontal"
p.legend.location = "top_center"

show(p)



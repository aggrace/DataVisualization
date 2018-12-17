import pandas as pd
import plotly.plotly as py
import plotly.graph_objs as go
import plotly
import geopy
from geopy.geocoders import MapBox
import re

## Return city and state names given latitude and longitude, here we use MapBox as geocoder
def cityandstate(lat, lon, maps):
    point = geopy.point.Point(latitude = lat, longitude = lon)
    location = maps.reverse(point)
    pattern = re.compile(r"""(\b[A-Za-z ]+), (District of Columbia|Virginia|Maryland) (\d{5})""")
    city = re.search(pattern, location.address).groups()[0]
    if "District of Columbia" in location.address:
        return city, "DC"
    if "Virginia" in location.address:
        return city, "VA"
    if "Maryland" in location.address:
        return city, "MD"

if __name__ == "__main__":
    
    ## API keys for plotly and MapBox
    plotly.tools.set_credentials_file(username='liyigao', api_key='6EmMOoSuy5cfO0f6PLyK')
    mapbox_access_token = "pk.eyJ1IjoibGl5aWdhbyIsImEiOiJjam15eDNmMm0zdGw1M3BxYzFxNHZ2YXdxIn0.C6dn-M82VyIrmjr2m-FaJA"
    
    ## location dataset, remove meaningless columns, add number of docks for analysis and station information for plotly
    cabiLoc = pd.read_csv("Capital_Bike_Share_Locations.csv", sep = ",")
    cabiLoc["NUMBER_OF_DOCKS"] = cabiLoc["NUMBER_OF_BIKES"] + cabiLoc["NUMBER_OF_EMPTY_DOCKS"]
    cabiLoc["STATION_INFO"] = cabiLoc["TERMINAL_NUMBER"].map(str) + ": " + cabiLoc["ADDRESS"]
    cabiLoc = cabiLoc.drop(["OBJECTID", "ID", "INSTALLED", "LOCKED", "INSTALL_DATE", "REMOVAL_DATE", "TEMPORARY_INSTALL", "X", "Y", "SE_ANNO_CAD_DATA"], axis = 1)

    ## Scatter plot on MapBox in plotly
    data = [
        go.Scattermapbox(
            lat = cabiLoc["LATITUDE"],
            lon = cabiLoc["LONGITUDE"],
            mode = "markers",
            marker = dict(
                size = 9
                ),
            text = cabiLoc["STATION_INFO"],
            )
        ]

    
    layout = go.Layout(
        autosize = True,
        hovermode = "closest",
        mapbox = dict(accesstoken = mapbox_access_token,
                      bearing = 0,
                      center = dict(lat = 38.900905,
                                    lon = -77.044784),
                      pitch = 0,
                      zoom = 10),
    )

    fig = dict(data = data, layout = layout)
    py.plot(fig, filename = "Capital Bikeshare Locations")

    ## add city and state features
    mapbox = MapBox(api_key = mapbox_access_token)
    cabiLoc["CITY"] = ""
    for index, row in cabiLoc.iterrows():
        cabiLoc["CITY"].iloc[index], cabiLoc["OWNER"].iloc[index] = cityandstate(lat = row["LATITUDE"], lon = row["LONGITUDE"], maps = mapbox)
        
    ## Manually change 31062 station to Arlington, VA
    rooseveltID = cabiLoc.index[cabiLoc["TERMINAL_NUMBER"] == 31062]
    cabiLoc["CITY"].iloc[rooseveltID] = "Arlington"
    cabiLoc["OWNER"].iloc[rooseveltID] = "VA"
    cabiLoc.to_csv("Capital Bikeshare Locations Clean.csv", index = False)

from pathlib import Path
import datetime
import json
import pandas as pd
from statistics import variance

path = Path(r'C:\Users\Medad\PycharmProjects\MastersProject\datadump')


bikes = {}
for e in path.glob('helbiz_*.json'):
    json_data = json.loads(e.read_text())

    for i in json_data["data"]["bikes"]:
        bikes[i["bike_id"]] = bikes.get(i["bike_id"], []) + [float(i["lat"])]


    #pd_temp = pd.DataFrame(json_data["data"]["bikes"])
    #print(pd_temp.head(4))

for bike in bikes:
    #print(bikes[bike])
    print(variance(bikes[bike]))
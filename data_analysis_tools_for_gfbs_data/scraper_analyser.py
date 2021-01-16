import json
from pathlib import Path
from statistics import variance

path = Path(r'datadump')

bikes = {}

# Choose either "helbiz_*.json" or "bird_*.json"
for e in path.glob('lime_*.json'):
    json_data = json.loads(e.read_text())
    for i in json_data["data"]["bikes"]:
        bikes[i["bike_id"]] = bikes.get(i["bike_id"], []) + [i]

for bike in bikes:
    try:
        #print(*bikes[bike],sep="\n")
        positions = [float(i["lon"]) for i in bikes[bike]]
        print(bike,":",variance(positions),":",positions)
    except:
        pass
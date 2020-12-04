import json
from pathlib import Path
from statistics import variance

path = Path(r'D:\Github_data\MastersProject\datadump')

bikes = {}

# Choose either "helbiz_*.json" or "bird_*.json"
for e in path.glob('helbiz_*.json'):
    json_data = json.loads(e.read_text())
    for i in json_data["data"]["bikes"]:
        bikes[i["bike_id"]] = bikes.get(i["bike_id"], []) + [i]

for bike in bikes:
    print(bike)
    print(*bikes[bike],sep="\n")
    print(variance([i["lon"] for i in bikes[bike]]))

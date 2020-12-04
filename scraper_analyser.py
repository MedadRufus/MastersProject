import json
from pathlib import Path
from statistics import variance

path = Path(r'D:\Github_data\MastersProject\datadump')

bikes = {}

# Choose either "helbiz_*.json" or "bird_*.json"
for e in path.glob('helbiz_*.json'):
    json_data = json.loads(e.read_text())
    for i in json_data["data"]["bikes"]:
        #print(i)
        bikes[i["bike_id"]] = bikes.get(i["bike_id"], []) + [
            {"lat": float(i["lat"]),
             "lon": float(i["lon"]),
             "in_use": int(i["in_use"]),
             "idle_time": int(i["idle_time"]),
             "is_reserved":int(i["is_reserved"])
        }]

for bike in bikes:
    print(bike)
    print(*bikes[bike],sep="\n")
    print(variance([i["lon"] for i in bikes[bike]]))
    # print(bikes[bike])

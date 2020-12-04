import json
from pathlib import Path
from statistics import variance

path = Path(r'D:\Github_data\MastersProject\datadump')

bikes = {}

# Choose either "helbiz_*.json" or "bird_*.json"
for e in path.glob('helbiz_*.json'):
    json_data = json.loads(e.read_text())
    print(json_data)
    for i in json_data["data"]["bikes"]:
        
        bikes[i["bike_id"]] = bikes.get(i["bike_id"], []) + [
            {"lat": float(i["lat"]),
             "lon": float(i["lon"]),
             "in_use": int(i["in_use"]),
             "is_reserved":int(i["is_reserved"])
        }]

for bike in bikes:
    print(bikes[bike])
    print(variance([i["is_reserved"] for i in bikes[bike]]))
    # print(bikes[bike])

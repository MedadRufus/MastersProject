from pathlib import Path
import datetime
import json
import pandas as pd

path = Path(r'C:\Users\Medad\PycharmProjects\MastersProject\datadump')


df = pd.DataFrame()
for e in path.glob('helbiz_*.json'):
    json_data = json.loads(e.read_text())
    pd_temp = pd.DataFrame(json_data["data"]["bikes"])
    print(pd_temp)

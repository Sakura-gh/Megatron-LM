import pyarrow.parquet as pq
import pandas as pd

# table = pq.read_table('./data/train-00000-of-05534-b8fc5348cbe605a5.parquet')
table = pq.read_table('./wiki/train-00000-of-00041.parquet')
df = table.to_pandas()
json_data = df.to_json(orient='records', lines=True)
with open('./wiki/wiki.json', 'w') as f:
    f.write(json_data)
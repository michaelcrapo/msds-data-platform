'''
Loading data into BigQuery `raw` table
'''

import pandas
from google.cloud import bigquery
import os
import glob
from pathlib import Path

client = bigquery.Client()

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,
    skip_leading_rows=1,
    autodetect=True
)


for file_path in glob.glob('data/olist_data/*.csv'):
    file_name = Path(file_path).stem
    table_id = f'msds-data-platform.raw.{file_name}'
    with open(file_path, 'rb') as source_file:
        job = client.load_table_from_file(source_file, table_id, job_config=job_config)
    print(file_path)

job.result()

def main():
    pass

if __name__=='__main__':
    main()


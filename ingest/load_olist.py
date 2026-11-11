'''
Loading data into BigQuery `raw` table
'''
from google.cloud import bigquery
from pathlib import Path
import csv

def build_string_schema(file_path: Path) -> list[bigquery.SchemaField]:
    """ read a csv's header row and return one string field per column """
    with open(file_path, newline='', encoding='utf-8-sig') as f:
        header = next(csv.reader(f))
    
    return [bigquery.SchemaField(column.strip(), 'STRING') for column in header]

def build_job_config(file_path: Path) -> bigquery.LoadJobConfig:
    """Load config for one CSV: all-STRING schema, replace the table on rerun."""
    return bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,
        schema=build_string_schema(file_path),
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
        allow_quoted_newlines=True,
    )

def table_name_from_stem(stem):
    return stem.removeprefix('olist_').removesuffix('_dataset')

def main():
    client = bigquery.Client()
    data_dir = Path(__file__).resolve().parent / 'data' / 'olist_data'
    files = sorted(data_dir.glob("*.csv"))
    if not files:
        raise FileNotFoundError(f"No CSV files found in {data_dir}")

    for file_path in files:
        table_id = f"{client.project}.raw.{table_name_from_stem(file_path.stem)}"
        with open(file_path, 'rb') as source_file:
            job = client.load_table_from_file(
                source_file, 
                table_id, 
                job_config=build_job_config(file_path)
            )
            job.result()
            #  table = client.get_table(table_id)
            # print(f"Loaded {table.num_rows} rows into {table_id}")

if __name__=='__main__':
    main()

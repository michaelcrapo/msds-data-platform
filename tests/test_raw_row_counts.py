import csv
from pathlib import Path

import pytest
from google.cloud import bigquery

from ingest.load_olist import table_name_from_stem

DATA_DIR = Path(__file__).resolve().parent.parent / "data" / "olist_data"
CSV_FILES = sorted(DATA_DIR.glob("*.csv"))

def count_csv_rows(file_path: Path) -> int:
    """Count data rows, excluding the header; handles line breaks inside quotes."""
    with open(file_path, newline="", encoding="utf-8-sig") as f:
        return sum(1 for _ in csv.reader(f)) - 1
    
@pytest.fixture(scope="module")
def client():
    return bigquery.Client()


def test_csv_files_exist():
    assert CSV_FILES, f"No CSV files found in {DATA_DIR}"

@pytest.mark.parametrize("file_path", CSV_FILES, ids=lambda p: p.stem)
def test_row_counts_match(client, file_path):
    table_id = f"{client.project}.raw.{table_name_from_stem(file_path.stem)}"
    table_rows = client.get_table(table_id).num_rows
    assert table_rows == count_csv_rows(file_path)


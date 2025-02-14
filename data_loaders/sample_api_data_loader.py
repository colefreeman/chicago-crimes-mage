import requests
import polars as pl
from typing import Dict, Any


@data_loader
def load_sample_api_data(**kwargs) -> pl.DataFrame:
    """
    Loads sample data from JSONPlaceholder API and returns a Polars
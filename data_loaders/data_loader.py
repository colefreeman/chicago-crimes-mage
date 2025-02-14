import json
import requests
from typing import Dict, Any

import polars as pl


@data_loader
def load_sample_data(**kwargs) -> pl.DataFrame:
    # Using JSONPlaceholder API as a sample public API
    api_url = kwargs.get('api_url', 'https://jsonplaceholder.typicode.com/posts')
    
    try:
        response = requests.get(api_url)
        response.raise_for_status()
        data = response.json()
        
        # Convert JSON data to Polars DataFrame
        df = pl.DataFrame(data)
        return df
        
    except requests.RequestException as e:
        raise Exception(f"Failed to fetch data from API: {str(e)}")
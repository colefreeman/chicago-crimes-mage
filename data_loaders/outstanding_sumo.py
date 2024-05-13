import io
import pandas as pd
import requests
from datetime import datetime, timedelta
from mage_ai.data_preparation.decorators import data_loader, test
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api():
    url = 'https://data.cityofchicago.org/resource/ijzp-q8t2.csv'
    app_token = 'yDYVZji7yOFWqIjs3gRCQU1Om'
    params = {
        '$$app_token': app_token,
        '$order': 'updated_on DESC',
        '$limit': 10000
    }

    response = requests.get(url, headers={'X-App-Token': app_token}, params=params)
    
    if response.status_code == 200:
        # Read the CSV data directly from the response with default column names
        chicago_crimes_bronze = pd.read_csv(io.StringIO(response.text))
        return chicago_crimes_bronze
    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")
        return pd.DataFrame()


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

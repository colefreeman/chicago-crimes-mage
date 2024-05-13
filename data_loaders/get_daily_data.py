import io
import pandas as pd
import requests
from datetime import datetime, timedelta
from mage_ai.data_preparation.decorators import data_loader, test
from mage_ai.data_preparation.decorators import data_loader
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(**kwargs):
    # Construct the API URL and headers
    url = 'https://data.cityofchicago.org/resource/ijzp-q8t2.csv'
    app_token = 'yDYVZji7yOFWqIjs3gRCQU1Om'
    
    # Assuming the API can filter by the 'updated_on' date,
    # construct the query to fetch records from the most recent day available.
    # This example attempts to fetch records for the last day, adjust accordingly.
    most_recent_date = datetime.strftime(datetime.now() - timedelta(days=1), '%Y-%m-%d')
    params = {
        '$$app_token': app_token,
        '$where': f"updated_on >= '{most_recent_date}'",
        '$limit': 400000  # Adjust the limit as per your requirement or API constraints
    }
    
    response = requests.get(url, params=params)

    if response.status_code == 200:
        # Load the data directly into a DataFrame
        data = pd.read_csv(io.StringIO(response.text))
        return data
    else:
        # Handle error cases
        print(f"Failed to retrieve data. Status code: {response.status_code}")
        return pd.DataFrame()  # Return an empty DataFrame in case of failure

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

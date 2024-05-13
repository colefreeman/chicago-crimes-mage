import io
import pandas as pd
import requests
from datetime import datetime, timedelta

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(raw_crimes_data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here

    # Ensure 'updated_on' is a datetime type
    raw_crimes_data['updated_on'] = pd.to_datetime(raw_crimes_data['updated_on'])

    # Find the maximum date in the 'updated_on' column
    max_date = raw_crimes_data['updated_on'].max()

    # Filter the DataFrame to only include rows with the max_date
    chicago_crimes_bronze = raw_crimes_data[raw_crimes_data['updated_on'] == max_date]

    return chicago_crimes_bronze


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

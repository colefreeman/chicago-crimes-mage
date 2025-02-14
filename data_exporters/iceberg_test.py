from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.iceberg_s3 import Iceberg
from pandas import DataFrame
from polars import DataFrame as PolarsDataFrame
from typing import Union
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_iceberg_table_in_s3(
    df: Union[DataFrame, PolarsDataFrame],
    **kwargs
) -> None:
    """
    Template for exporting data to an Iceberg table in S3.

    Specify your AWS credentials (i.e. AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY,
    and AWS_REGION) in your project's io_config.yaml file or your environment variables.
    """
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    namespace = 'default'   # Specify the namespace for the Iceberg catalog

    # Specify the S3 bucket to export to (can be nested)
    bucket_name = 'your_bucket_name'
    table_name = 'your_table_name'

    Iceberg.with_config(
        ConfigFileLoader(config_path, config_profile),
        bucket_name=bucket_name,
        namespace=namespace,
    ).export(
        df,
        bucket_name,
        table_name,
    )
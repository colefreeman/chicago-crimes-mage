import os
from datetime import datetime
from typing import Generator, Any
import pandas as pd
from google.cloud import bigquery


@data_exporter
def export_to_bigquery( pd.DataFrame, **kwargs) -> None:
    # Initialize BigQuery client
    client = bigquery.Client()

    try:
        # Get target table from the data
        target_table = data['target_table'].iloc[0]

        # Remove metadata columns
        df_clean = data.drop(columns=['target_table', 'source_file', 'load_timestamp'])

        # Define table reference
        table_ref = bigquery.TableReference.from_string(target_table)

        # Define job config
        job_config = bigquery.LoadJobConfig(
            write_disposition=bigquery.WriteDisposition.WRITE_APPEND,
            schema_update_options=[
                bigquery.SchemaUpdateOption.ALLOW_FIELD_ADDITION
            ]
        )

        # Load data to BigQuery
        load_job = client.load_table_from_dataframe(
            df_clean,
            table_ref,
            job_config=job_config
        )

        # Wait for job to complete
        load_job.result()

    except Exception as e:
        raise Exception(f"Failed to export data to BigQuery: {str(e)}")
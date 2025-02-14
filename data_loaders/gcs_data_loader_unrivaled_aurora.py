import glob
import os
from datetime import datetime
from typing import Generator, Any
import pandas as pd
from google.cloud import storage


@data_loader
def load_gcs_data(**kwargs) -> Generator[pd.DataFrame, None, None]:
    # Get pipeline variables
    bucket_name = kwargs.get('bucket_name')
    prefix = kwargs.get('prefix', '')
    file_pattern = kwargs.get('file_pattern', '*')
    target_table = kwargs.get('target_table')

    # Initialize GCS client
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)

    # List matching files
    blobs = bucket.list_blobs(prefix=prefix)
    matching_files = [b for b in blobs if glob.fnmatch.fnmatch(b.name, file_pattern)]

    if not matching_files:
        raise Exception(f"No files found matching pattern {file_pattern} in {bucket_name}/{prefix}")

    # Process each file
    for blob in matching_files:
        # Download to temp file
        temp_path = f"/tmp/{os.path.basename(blob.name)}"
        blob.download_to_filename(temp_path)

        try:
            # Read data
            df = pd.read_csv(temp_path)

            # Convert all columns to string
            for col in df.columns:
                df[col] = df[col].astype(str)

            # Add metadata columns
            df['target_table'] = target_table
            df['source_file'] = blob.name
            df['load_timestamp'] = datetime.now().isoformat()

            yield df

        finally:
            # Cleanup
            if os.path.exists(temp_path):
                os.remove(temp_path)
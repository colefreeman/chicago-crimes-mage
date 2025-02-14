if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
import pandas as pd
from typing import List, Dict

@transformer
def transform_data(data: pd.DataFrame, *args, **kwargs) -> List[pd.DataFrame]:
    """
    Transforms each chunk by adding 'risk_score_2' based on 'cardiac_risk_score'.
    """
    data = data.copy()
    # Ensure 'cardiac_risk_score' is treated as a string to handle possible non-numeric values
    data['cardiac_risk_score'] = data['cardiac_risk_score'].astype(str)

    # Apply transformation logic
    def assign_risk_score(row):
        cardiac_risk_score = row['cardiac_risk_score']
        patient_id = row.get('patient_id')

        if cardiac_risk_score:
            try:
                score = float(cardiac_risk_score)
                if score < 5:
                    risk_category = 'High risk'
                elif 5 <= score <= 7:
                    risk_category = 'Medium risk'
                elif score > 7:
                    risk_category = 'Low risk'
                else:
                    risk_category = 'Unknown'

                return risk_category

            except ValueError:
                return 'Invalid score'
        else:
            return 'No score'

    data['serious_event_risk'] = data.apply(assign_risk_score, axis=1)
    return data
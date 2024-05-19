import pandas as pd
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data['name'] =  data['name'].astype('str')
    data['authors'] = data['authors'].astype(str)
    data['publisher_vn'] = data['publisher_vn'].astype(str)
    data['manufacturer'] = data['manufacturer'].astype(str)
    data['dich_gia'] = data['dich_gia'].astype(str)
    data['publication_date'] = pd.to_datetime(data['publication_date'])
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

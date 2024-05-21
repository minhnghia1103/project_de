from mage_ai.io.file import FileIO
import pandas as pd
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_file(*args, **kwargs):
    filepath = '/home/src/crawled_data_book.csv'
    df = pd.read_csv(filepath)
    book_tiki_type = {
        'id': pd.Int64Dtype(),
        'price': float,
        'quantity': pd.Int64Dtype(),
        'rating_average': float,
        'number_of_page': pd.Int64Dtype()
    }

    parse_dates = ['publication_date']

    return pd.read_csv(filepath, sep=",", dtype=book_tiki_type, parse_dates=parse_dates)

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

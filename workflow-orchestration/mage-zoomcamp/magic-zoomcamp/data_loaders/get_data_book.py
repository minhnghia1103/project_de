import io
import pandas as pd
import requests
import time
import random 
from tqdm import tqdm
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'en,en-US;q=0.9,vi;q=0.8',
        'Referer': 'https://tiki.vn/chu-thuat-hoi-chien-tap-5-p192115858.html?spid=192115861',
        'x-guest-token': '5IlnSZdwcO9bWks3maJuTYXC8NE4xpFQ'
    }

    params = (
        ('platform', 'web'),
        ('spid', 192115861),
        ('version', 3),
        #('include', 'tag,images,gallery,promotions,badges,stock_item,variants,product_links,discount_tag,ranks,breadcrumbs,top_features,cta_desktop'),
    )


    def parser_product(json):
        d = dict()
        d['id'] = json.get('id')
        d['name'] = json.get('name')
        d['price'] = json.get('price')
        authors = json.get('authors')
        if authors:
            author_names = [author.get('name') for author in authors]
            d['authors'] = ', '.join(author_names)
        d['quantity'] = json.get('all_time_quantity_sold')
        d['rating_average'] = json.get('rating_average')

        specifications = json.get('specifications')
        if specifications:
            for spec in specifications:
                attributes = spec.get('attributes')
                if attributes:
                    for attr in attributes:
                        code = attr.get('code')
                        value = attr.get('value')
                        if code and value:
                            if code == 'publisher_vn':
                                d['publisher_vn'] = value
                            elif code == 'publication_date':
                                d['publication_date'] = value
                            elif code == 'dich_gia':
                                d['dich_gia'] = value
                            elif code == 'number_of_page':
                                d['number_of_page'] = value
                            elif code == 'manufacturer':
                                d['manufacturer'] = value

        return d

    df_id = pd.read_csv('books_id.csv')
    p_ids = df_id.id.to_list()
    print(p_ids)
    result = []
    for pid in tqdm(p_ids, total=len(p_ids)):
        response = requests.get('https://tiki.vn/api/v2/products/{}'.format(pid), headers=headers, params=params)
        if response.status_code == 200:
            print('Crawl data {} success !!!'.format(pid))
            result.append(parser_product(response.json()))
        time.sleep(2)

    return pd.DataFrame(result)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

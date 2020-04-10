## Prepare data

1. Load demo data e-commerce

2. Create transform :

```json
PUT _transform/ecommerce_by_day
{
  "source": {
    "index": [ "kibana_sample_data_ecommerce" ],
    "query": { "match_all": {} }
  },
  "dest": { "index": "transform_kibana_sample_data_ecommerce" },
  "pivot": {
    "group_by": {
      "country_iso_code": {
        "terms": { "field": "geoip.country_iso_code" }
      },
      "order_date": {
        "date_histogram": { "field": "order_date", "calendar_interval": "1d" }
      }
    },
    "aggregations": {
      "taxful_price_sum": {
        "sum": { "field": "products.taxful_price" }
      }
    }
  }
}
```

```json
POST _transform/ecommerce_by_day/_start
```
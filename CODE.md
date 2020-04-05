### By URL

```vega-lite
{
  "data": {
    "url": "http://192.168.1.10:9200/kibana_sample_data_ecommerce/_search?q=order_date:<now-1d+AND+order_date:>=now-2d",
    "format": {
      "type": "json",
      "property": "hits.hits"
    }
  },
  "mark": "bar",
  "encoding": {
    "y": {
      "field": "_source.geoip.country_iso_code",
      "type": "ordinal",
      "title": "By country (code)"
    },
    "x": {
      "field": "_source.taxful_total_price",
      "aggregate": "sum",
      "type": "quantitative",
      "title": "Sales yesterday"
    }
  }
}
```

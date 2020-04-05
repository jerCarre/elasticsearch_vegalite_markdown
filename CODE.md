### 

```vega-lite
{
  "width": 500,
  "height": 300,
  "data": {
    "url": "http://192.168.1.10:9200/transform_kibana_sample_data_ecommerce/_search?q=order_date:<now-1d+AND+order_date:>=now-2d",
    "format": {
      "type": "json",
      "property": "hits.hits"
    }
  },
  "mark": "bar",
  "encoding": {
    "x": {
      "field": "_source.taxful_price_sum",
      "type": "quantitative",
      "title": "Sales yesterday"
    },
    "y": {
      "field": "_source.country_iso_code",
      "type": "ordinal",
      "title": "By country (code)"
    }
  }
}
```



```vega-lite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v4.json",
  "width": 500,
  "height": 300,
  "data": {
    "url": "https://vega.github.io/vega-lite/examples/data/us-10m.json",
    "format": {
      "type": "topojson",
      "feature": "counties"
    }
  },
  "transform": [{
    "lookup": "id",
    "from": {
      "data": {
        "url": "https://vega.github.io/vega-lite/examples/data/unemployment.tsv"
      },
      "key": "id",
      "fields": ["rate"]
    }
  }],
  "projection": {
    "type": "albersUsa"
  },
  "mark": "geoshape",
  "encoding": {
    "color": {
      "field": "rate",
      "type": "quantitative"
    }
  }
}
```

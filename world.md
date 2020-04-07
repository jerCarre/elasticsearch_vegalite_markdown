## world

```vega-lite
{
  "$schema": "https://vega.github.io/schema/vega/v5.json",
  "width": 900,
  "height": 500,
  "autosize": "none",
  "projections": [
    {
      "name": "projection",
      "type": "mercator"
    }
  ],
  "data": [
    {
      "name": "world",
      "url": "https://vega.github.io/vega/data/world-110m.json",
      "format": {
        "type": "topojson",
        "feature": "countries"
      }
    }
  ],
  "marks": [
    {
      "type": "shape",
      "from": {"data": "world"},
      "encode": {
        "enter": {
          "strokeWidth": {"value": 0.5},
          "stroke": {"value": "#bbb"},
          "fill": {"value": "#e5e8d3"}
        }
      },
      "transform": [
        { "type": "geoshape", "projection": "projection" }
      ]
    }
  ]
}
```

## iso 3166 a2

```vega-lite
{
  "$schema": "https://vega.github.io/schema/vega/v5.json",
  "width": 900,
  "height": 500,
  "autosize": "none",
  "projections": [
    {
      "name": "projection",
      "type": "mercator"
    }
  ],
  "data": [
    {
      "name": "world",
      "url": "https://raw.githubusercontent.com/capta-journal/map/master/world/topojson/ne_110m_admin_0_countries.json",
      "format": {
        "type": "topojson",
        "feature": "countries"
      },
      "transform": [{
        "lookup": "id",
        "from": {
          "data": {
            "name": "sales",
            "url": "/home/jerome/projets/elasticsearch_vegalite_markdown/data2.json",
            "format": {"type": "json"}
          },
          "key": "_source.country_iso_code",
          "fields": ["_source.taxful_price_sum"]
        }
      }],
    }
  ],
  "marks": [
    {
      "type": "shape",
      "from": {"data": "world"},
      "encode": {
        "enter": {
          "strokeWidth": {"value": 0.5},
          "stroke": {"value": "#bbb"},
          "fill": {"value": "#e5e8d3"}
        }
      },
      "transform": [
        { "type": "geoshape", "projection": "projection" }
      ]
    }
  ]
}
```
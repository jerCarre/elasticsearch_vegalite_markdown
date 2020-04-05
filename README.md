# Exemple d'utilisation Elasticsearch + Vega + markdown

```json
POST _xpack/sql?format=csv
{
  "query": "SELECT count(*) AS count, geoip.continent_name AS continent from kibana_sample_data_ecommerce GROUP bY geoip.continent_name ORDER BY count",
  "filter": {
        "range": {
            "order_date": {
                "gte" : "now-1d/d",
                "lt" : "now/d"
            }
        }
    }
}

kibana_sample_data_ecommerce/_search?q=order_date:<now-1d AND order_date:>=now-2d
```

### By File

```vega-lite
{
  "data": {
    "url": "/home/jerome/projets/elk_vega_md/data.csv",
    "format": {
      "type": "csv"
    }
  },
  "mark": "bar",
  "encoding": {
    "y": {
      "field": "continent",
      "type": "ordinal",
      "title": "By continent"
    },
    "x": {
      "field": "count",
      "type": "quantitative",
      "title": "Sales yesterday"
    }
  }
}
```

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
    },
    "tooltip": [
      {"field": "_source.geoip.country", "type": "nominal", "title": "Name"}
    ]
  }
}
```

```vega-lite
{
  "$schema": "https://vega.github.io/schema/vega/v5.json",
  "description": "A configurable map of countries of the world.",
  "width": 900,
  "height": 500,
  "autosize": "none",

  "signals": [
    {
      "name": "type",
      "value": "mercator",
      "bind": {
        "input": "select",
        "options": [
          "albers",
          "albersUsa",
          "azimuthalEqualArea",
          "azimuthalEquidistant",
          "conicConformal",
          "conicEqualArea",
          "conicEquidistant",
          "equalEarth",
          "equirectangular",
          "gnomonic",
          "mercator",
          "naturalEarth1",
          "orthographic",
          "stereographic",
          "transverseMercator"
        ]
      }
    },
    { "name": "scale", "value": 150,
      "bind": {"input": "range", "min": 50, "max": 2000, "step": 1} },
    { "name": "rotate0", "value": 0,
      "bind": {"input": "range", "min": -180, "max": 180, "step": 1} },
    { "name": "rotate1", "value": 0,
      "bind": {"input": "range", "min": -90, "max": 90, "step": 1} },
    { "name": "rotate2", "value": 0,
      "bind": {"input": "range", "min": -180, "max": 180, "step": 1} },
    { "name": "center0", "value": 0,
      "bind": {"input": "range", "min": -180, "max": 180, "step": 1} },
    { "name": "center1", "value": 0,
      "bind": {"input": "range", "min": -90, "max": 90, "step": 1} },
    { "name": "translate0", "update": "width / 2" },
    { "name": "translate1", "update": "height / 2" },

    { "name": "graticuleDash", "value": 0,
      "bind": {"input": "radio", "options": [0, 3, 5, 10]} },
    { "name": "borderWidth", "value": 1,
      "bind": {"input": "text"} },
    { "name": "background", "value": "#ffffff",
      "bind": {"input": "color"} },
    { "name": "invert", "value": false,
      "bind": {"input": "checkbox"} }
  ],

  "projections": [
    {
      "name": "projection",
      "type": {"signal": "type"},
      "scale": {"signal": "scale"},
      "rotate": [
        {"signal": "rotate0"},
        {"signal": "rotate1"},
        {"signal": "rotate2"}
      ],
      "center": [
        {"signal": "center0"},
        {"signal": "center1"}
      ],
      "translate": [
        {"signal": "translate0"},
        {"signal": "translate1"}
      ]
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
    },
    {
      "name": "graticule",
      "transform": [
        { "type": "graticule" }
      ]
    }
  ],

  "marks": [
    {
      "type": "shape",
      "from": {"data": "graticule"},
      "encode": {
        "update": {
          "strokeWidth": {"value": 1},
          "strokeDash": {"signal": "[+graticuleDash, +graticuleDash]"},
          "stroke": {"signal": "invert ? '#444' : '#ddd'"},
          "fill": {"value": null}
        }
      },
      "transform": [
        { "type": "geoshape", "projection": "projection" }
      ]
    },
    {
      "type": "shape",
      "from": {"data": "world"},
      "encode": {
        "update": {
          "strokeWidth": {"signal": "+borderWidth"},
          "stroke": {"signal": "invert ? '#777' : '#bbb'"},
          "fill": {"signal": "invert ? '#fff' : '#000'"},
          "zindex": {"value": 0}
        },
        "hover": {
          "strokeWidth": {"signal": "+borderWidth + 1"},
          "stroke": {"value": "firebrick"},
          "zindex": {"value": 1}
        }
      },
      "transform": [
        { "type": "geoshape", "projection": "projection" }
      ]
    }
  ]
}
```

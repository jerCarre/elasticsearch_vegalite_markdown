curl -X POST "http://localhost:9200/kibana_sample_data_ecommerce/_search" -H 'Content-Type: application/json' -d'
{
  "size" : 1000,
  "query" : {
    "range" : {
      "order_date" : {
        "from" : "now-1d/d",
        "to" : "now/d",
        "include_lower" : true,
        "include_upper" : false,
        "boost" : 1.0
      }
    }
  },
  "_source" : {
    "includes" : [
      "taxful_total_price",
      "geoip.country_iso_code"
    ]
  }
}
' > data_raw.json

curl -X POST "http://localhost:9200/transform_kibana_sample_data_ecommerce/_search" -H 'Content-Type: application/json' -d'
{
  "size" : 1000,
  "query" : {
    "range" : {
      "order_date" : {
        "from" : "now-1d/d",
        "to" : "now/d",
        "include_lower" : true,
        "include_upper" : false,
        "boost" : 1.0
      }
    }
  }
}
' > data_transform.json

curl -X POST "http://localhost:9200/_xpack/sql?format=csv" -H 'Content-Type: application/json' -d'
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
' > data.csv



---

title: Au rapport chef !
author: Jérôme Carré

---

## Genèse



Les émissions culinaires sont très à la mode : "et si je mélangeais des huîtres avec du caramel ça devrait être bon ..." ! C'est de ce type d'idée bizarre qu'est naît cet article : "Si je mets des data `Elasticsearch` dans un diagramme `vega-lite`, dans un bloc de code `Markdown` ça devrait être ~~bon~~ pros !"

L'idée a aussi était inspirée d'un outil : [Marktext](https://marktext.app/). C'est un éditeur wysiwyg de `Markdown` qui sait interpréter en live le `vega-lite` ! Il est gratuit, opensource et multi-plateforme (c'est de l'electron) !

## Les bases

Un petit rappel des outils que l'on va mettre en œuvre :

**Elasticsearch** :

**Markdown** :

**Vega-lite** :

## A l'origine ... les data

Pour avoir une situation de reporting réaliste, on doit avoir des données représentatives d'une activité métier.  `Elastic Stack` fournit justement des données de démonstration pour cela : d'e-commerce, de navigation aérienne, de trafic web. On choisira les données d'e-commerce. Chaque enregistrement trace l'achat d'un consommateur, avec les produits achetés, la localisation de l'acheteur...

Une requête intéressante à afficher serait : le montant des ventes d'hier par pays.

 On prépare donc une belle requête elasticsearch pour que les données arrivent pré-traitées dans `vega-lite` :

```json
POST _sql?format=csv
{
  "query": "SELECT SUM(taxful_total_price) AS total_price, geoip.country_iso_code AS country 	FROM kibana_sample_data_ecommerce GROUP bY geoip.country_iso_code ORDER BY count",
  "filter": { "range": {
            	"order_date": {
                	"gte" : "now-2d/d",
                	"lte" : "now-1d/d"
} } } }
```

> On choisit d'utiliser l'API SQL car elle permet de simplifier l'écriture de la requête et de choisir le format de sortie (ex: CSV).

Il ne reste plus qu'à mettre cette URL et sa payload dans la partie data de `vega-lite` ... **Échec** !! `vega-lite` ne permet pas de passer une payload ni de choisir le verbe http ... on ne peut passer qu'une simple URL !

Pour dépasser cette limitation, nous avons deux possibilités :

1. on transforme les données dans `Elasticsearch`
2. on manipule les données dans `vega-lite`

Nous allons explorer les deux solutions.

### Transformation !!

Depuis la version 7.2, `Elasticsearch` propose l'API *[transform](https://www.elastic.co/guide/en/elasticsearch/reference/current/transform-apis.html)*. Elle permet de transformer, regrouper des données à la volée (ou en batch) et de les stocker dans un nouvel index. Nous n'aurons plus qu'à interroger ce nouvel index avec une simple requête et le tour est joué. Les *transform* peuvent être manipulés par API ou par un écran dans Kibana.

Dans notre cas, on va utiliser *transform* pour faire la somme des achats par pays par jour :

```json
PUT _transform/ecommerce_by_day
{
  "source": {
    "index": [
      "kibana_sample_data_ecommerce"
    ],
    "query": {
      "match_all": {}
    }
  },
  "dest": {
    "index": "kibana_sample_data_ecommerce_transform"
  },
  "pivot": {
    "group_by": {
      "geoip.country_iso_code": {
        "terms": {
          "field": "geoip.country_iso_code"
        }
      },
      "order_date": {
        "date_histogram": {
          "field": "order_date",
          "calendar_interval": "1d"
        }
      }
    },
    "aggregations": {
      "products.taxful_price.sum": {
        "sum": {
          "field": "products.taxful_price"
        }
      }
    }
  }
}
```



### Manipulation



## Ooooh la belle courbe

Evidemment un camembert !!



## Au rapport chef !!

La markdown dans marktext

export

asciidoctor

## Limitations

URL single line => authent ?
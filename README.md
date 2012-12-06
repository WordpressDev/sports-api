# Simple Sport Syndication API

----

Here we provide a simple JSON API into a small subset of the content published on http://www.bbc.co.uk/sport/

This API is intened for prototyping purposes and provides a number of JSON views on the data. The service should be treated as experimental.

## Available Data

----

The data available for each article is as follows:

* **title**
* **description**
* **body**
* **published** (date)
* **url**
* **places** A list of auto extracted places mentioned in the article, linked to DBpedia entities and including lat / lon coordinates (experimental)
* **people** A list of auto extracted people mentioned in the article, linked to DBpedia entities
* **organisations** A list of auto extracted organisations mentioned in the article, linked to DBpedia entities

##Endpoints

----

### /search

A simple search interface to the data, providing pagination, date ranges, sections and simple geo location search. Max results size is 20 articles per request.

* [/search?published_after=2012-11-02&published_before=2012-11-03](/search?published_after=2012-11-02&published_before=2012-11-03)
* [/search?section=football](/search?section=football)
* [/search?section=football&location=53.466667,-2.233333&distance=15](/search?section=football&location=53.466667,-2.233333&distance=15)

#### Query Params

* **page** page number, defaults to 1
* **section** scope query by section
* **published\_after** date, e.g. 2012-11-01
* **published\_before** date, e.g. 2012-11-02
* **location** A pair of lat / lon coordiantes, e.g. 53.466667,-2.233333
* **distance** A distance (radius) in miles from the above location coordinate

#### Example Response

    {
      "articles" : [
        {
          "title" : "Stoke boss Tony Pulis rules out Asmir Begovic sale in January",
          "published" : "2012-12-06T12:16:41Z",
          ...
        },
        ...
      ]
    }

### /sections

A list of sections available in the API.

#### Example response

[/sections](/sections)

    {
      "sections" : [
        {
          "title" : "Football",
          "identifier" : "football"
        },
        ...
      ]
    }

### /sections/:identifier

A feed of the latest articles captured in the given section, max 20 articles.

[/sections/football](/sections/football)

#### Example Response

    {
      "articles" : [
        {
          "title" : "Stoke boss Tony Pulis rules out Asmir Begovic sale in January",
          "published" : "2012-12-06T12:16:41Z",
          ...
        },
        ...
      ]
    }

## Support

Matt dot Haynes at bbc dot co dot uk

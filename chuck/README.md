# chuck

<!-- badges: start -->
<!-- badges: end -->

## Infrastructure

### golem/chuck

Shiny apps that reads and write in a mongo instance at : 

```r
mongo_port <- Sys.getenv("MONGOPORT", 27017)
mongo_url <- Sys.getenv("MONGOURL", "mongodb://127.0.0.1")
mongo_db <- Sys.getenv("MONGODB", "chuck")
mongo_collection <- Sys.getenv("MONGOCOLLECTION", "norris")
launch_mongo(
  collection = mongo_collection, 
  db = mongo_db, 
  url = sprintf(
    "%s:%s", 
    mongo_url,
    mongo_port
  )
)
```

### Mongo

``` 
docker run -v $(pwd)/db:/data/db -p 12334:27017 -d mongo:3.4 
```

```
R -e "Sys.setenv(MONGOPORT = 12334);pkgload::load_all();run_app()"
```

```
R -e "Sys.setenv(MONGOPORT = 12334, MONGODB = 'hey', MONGOCOLLECTION = 'you');pkgload::load_all();run_app()"
```
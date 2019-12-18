# Chuck 

`Chuck` is a 10x Shiny app designed as a playground for deploying Shiny apps to Docker / Kubernetes.

It contains a Shiny app that needs a Mongo DB backend to work. The connection information are passed with environment variables. 

The app simply pulls a random Joke from the Chuck Norris API (<http://api.icndb.com/jokes/random>), and allow you to save it to the mongo db instance, or skip. 

The UI also allows you to retrieve information from the MongoDB instance. 

## Infrastructure

### chuck

The Shiny apps that reads and write in a mongo instance at : 

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

## Build 

```
git clone https://github.com/ColinFay/chuck && cd chuck && docker build -t colinfay/chuck .
# OR 
docker pull colinfay/chuck
docker pull mongo:3.4 
```

## Launch 

```
docker network create chucknet

docker run -v $(pwd)/db:/data/db -p 27017:27017 -d --name mongo --net chucknet mongo:3.4

docker run -e MONGOPORT=27017 -e MONGOURL=mongo -e MONGODB=pouet -e MONGOCOLLECTION=pouet -p 3838:3838 --name chuck --net chucknet -d colinfay/chuck && sleep 2 && open http://localhost:3838

# TRY ANOTHER MONGODB & SHINY PORT

docker run -e PORT=1234 -e MONGOPORT=27017 -e MONGOURL=mongo -e MONGODB=pif -e MONGOCOLLECTION=paf -p 1234:1234 --name chuckbis --net chucknet -d colinfay/chuck && sleep 2 && open http://localhost:1234
```


## Stop 

```
docker stop chuck && docker rm chuck
docker stop chuckbis && docker rm chuckbis
docker stop mongo && docker rm mongo && rm -rf $(pwd)/db
docker network rm chucknet
```


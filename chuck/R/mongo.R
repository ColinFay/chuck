launch_mongo <- function(
  session = getDefaultReactiveDomain(), 
  collection = "norris", 
  db = "chuck", 
  url = "127.0.0.1", 
  port = 27017
){
  session$userData$mongo <- mongolite::mongo(
    collection =  collection, 
    db = db, 
    url = sprintf(
      "mongodb://%s:%s", 
      url,
      port
    )
  )
  
  session$userData$mongo_stats <- list(
    collection = collection, 
    db = db, 
    url = url, 
    port = port
  )
}

get_mongo <- function(session = getDefaultReactiveDomain()){
  session$userData$mongo
}
get_mongo_stats <- function(session = getDefaultReactiveDomain()){
  session$userData$mongo_stats
}
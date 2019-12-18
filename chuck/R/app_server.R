#' @import shiny
#' @import mongolite
app_server <- function(input, output,session) {

  mongo_port <- Sys.getenv("MONGOPORT", 27017)
  mongo_url <- Sys.getenv("MONGOURL", "127.0.0.1")
  mongo_db <- Sys.getenv("MONGODB", "chuck")
  mongo_collection <- Sys.getenv("MONGOCOLLECTION", "norris")
  cli::cat_rule("mongo_port")
  cli::cat_line(mongo_port)
  cli::cat_rule("mongo_url")
  cli::cat_line(mongo_url)
  cli::cat_rule("mongo_db")
  cli::cat_line(mongo_db)
  cli::cat_rule("mongo_collection")
  cli::cat_line(mongo_collection)
  
  launch_mongo(
    collection = mongo_collection, 
    db = mongo_db, 
    url = mongo_url, 
    port = mongo_port
  )
  
  callModule(
    mod_main_server, 
    "main_ui_1"
  )
}

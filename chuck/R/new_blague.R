#' @importFrom jsonlite fromJSON
new_joke <- function(){
  res <- fromJSON(
    "http://api.icndb.com/jokes/random"
  )
  if(res$type != "success"){
    return(
      list(
        joke = "Error while retrieving the joke"
      )
    )
  } else {
    return(res$value)
  }
}
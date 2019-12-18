# Module UI

#' @title   mod_main_ui and mod_main_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_main
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_main_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      align = "center",
      h2("CHUCK NORRIS JOKE"), 
      uiOutput(ns("joke")), 
      col_6(
        align = "center",
        actionButton(
          inputId = ns("no"),
          class = "emo", 
          HTML("&#128530;")
        ),
        tags$p("NOP, NOT FUNNY, SKIP")
      ),
      col_6(
        align = "center",
        actionButton(
          inputId = ns("yes"),
          class = "emo", 
          HTML("&#128514;")
        ),
        tags$p("LMAO, SAVE TO THE DB")
      ), 
      col_12(
        HTML("&nbsp;"),
        tags$div(
          align = "left",
          verbatimTextOutput(ns("tbl"))
        )
      ), 
      col_6(
        align = "center",
        actionButton(
          inputId = ns("showdbinfo"),
          "Show DB info"
        )
      ),
      col_6(
        align = "center",
        actionButton(
          inputId = ns("showdb"),
          "Show DB content"
        )
      )
    )
  )
}

# Module Server

#' @rdname mod_main
#' @export
#' @keywords internal

mod_main_server <- function(
  input, 
  output, 
  session
){
  ns <- session$ns
  
  bla <- reactiveValues(gue = new_joke())
  
  observeEvent( input$no, {
    bla$gue <- new_joke()
  })
  
  observeEvent( input$yes, {
    get_mongo()$insert(
      bla$gue
    )
    bla$gue <- new_joke()
  })
  
  output$joke <- renderUI({
    tags$h3(
      HTML(
        bla$gue$joke
      )
    )
  })
  
  output$tbl <- renderPrint({
    bla$gue
    cli::cat_rule("Number of Jokes saved in the DB:")
    cli::cat_line(get_mongo()$count())
    cli::cat_line("")
    cli::cat_rule("Information about the DB:")
    purrr::iwalk(
      get_mongo_stats(), ~ cli::cat_bullet(
        paste(.y, ":", .x)
      )
    )
  })
  
  observeEvent(input$showdbinfo, {
    showModal(modalDialog(
      size = "l",
      title = "Infos",
        renderPrint(
          get_mongo()$info()
        )
    ))
  })
  
  observeEvent(input$showdb, {

    showModal(modalDialog(
      size = "l",
      title = "Infos",
      renderTable({
        purrr::map_df(get_mongo()$find(), as.character)
      })
    ))
  })
}



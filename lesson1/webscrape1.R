#UI Output/Namespace Section----
webscrape1UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("webscrape1_ui"))
}

#Module Section----
webscrape1 <- function(input, output, session) {
  
  #UI Section----
  
  output$webscrape1_ui <- renderUI({
    
    tagList(
      h2("Time Series: Step 1"),
      
      div(
        fluidRow(
          
          box(width = 10, title = "GDP Data from Federal Reserve Economic Database",
              dygraphs::dygraphOutput(session$ns("webscrape"))
              
          )
        )
      )
    )
    
  })
  
  #Server Section----
  
  url <- 'https://money.cnn.com/data/world_markets/asia/'
  webpage <- read_html(url)
  
  table_html <- html_nodes(webpage,'#section_latestnews li')
  table_text <- html_text(table_html)
  table_text <- trimws(table_text)
  table_data <- data.frame(table_data)
  
}
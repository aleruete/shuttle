#UI Output/Namespace Section----
timeseries1UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("timeseries1_ui"))
}

#Module Section----
timeseries1 <- function(input, output, session) {
  
  #UI Section----
  
  output$timeseries1_ui <- renderUI({
    
    tagList(
      h2("Time Series: Step 1"),
      
      div(
        fluidRow(
          
          box(width = 10, title = "GDP Data from Federal Reserve Economic Database",
              dygraphs::dygraphOutput(session$ns("timeseries"))
              
          )
        )
      )
    )
    
  })
  
  #Server Section----
  
  macrodata <- reactive({
    
    tidyquant::tq_get("GDPC1", get = "economic.data", from = "1960-01-01", to = "2019-01-01")
    
  })
  
  output$timeseries <- dygraphs::renderDygraph({
    
    macrodata() %>%
      column_to_rownames(var = "date") %>%
      xts::as.xts() %>%
      dygraphs::dygraph() %>%
      dygraphs::dyAxis("y", label = "US GDP") %>%
      dygraphs::dyRangeSelector()
    
  })
  
  
}
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
          box(width = 2,
              
              dateInput(session$ns("start_date"), "Start Date", value = "1960-01-01"),
              dateInput(session$ns("end_date"), "End Date", value = Sys.Date()),
              actionButton(session$ns("update"), "Update")
          ),
          
          box(width = 10, title = "GDP Data from Federal Reserve Economic Database",
              dygraphs::dygraphOutput(session$ns("timeseries"))
              
          )
        )
      )
    )
    
  })
  
  #Server Section----
  
  macrodata <- eventReactive(input$update, {
    
    tidyquant::tq_get("GDPC1", get = "economic.data", from = input$start_date, to = input$end_date)
    
  })
  
  output$timeseries <- dygraphs::renderDygraph({
    req(macrodata)
    
    macrodata() %>%
      tibble::column_to_rownames(., var = "date") %>%
      xts::as.xts() %>%
      dygraphs::dygraph() %>%
      dygraphs::dyRangeSelector()
    
  })
  
  
}
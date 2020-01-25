#UI Output/Namespace Section----
timeseries2UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("timeseries2_ui"))
}

#Module Section----
timeseries2 <- function(input, output, session) {
  
  #UI Section----
  
  output$timeseries2_ui <- renderUI({
    
    tagList(
      h2("Time Series: Step 2"),
      
      div(
        fluidRow(
          box(width = 2,
              
              textInput(session$ns("symbol"), "Stock Symbol", value = "AMZN"),
              dateInput(session$ns("start_date"), "Start Date", value = "2015-01-01"),
              dateInput(session$ns("end_date"), "End Date", value = Sys.Date()),
              actionButton(session$ns("update"), "Update")
          ),
          
          box(width = 10,
              dygraphs::dygraphOutput(session$ns("timeseries_graph")),
              hr(),
              plotOutput(session$ns("timeseries_chart"))
              
          )
        )
      )
    )
    
  })
  
  #Server Section----
  
  stockdata <- eventReactive(input$update, {
    
    tidyquant::tq_get(input$symbol, get = "stock.prices", from = input$start_date, to = input$end_date)
    
  })
  
  # Creating the candlestick graph using the dygraphs package
  # Great place to learn more about dygraphs https://rstudio.github.io/dygraphs/
  output$timeseries_graph <- dygraphs::renderDygraph({
    req(stockdata)
    
    stockdata() %>%
      select(date,open,high,low,close) %>%
      tibble::column_to_rownames(var = "date") %>%
      xts::as.xts() %>%
      dygraphs::dygraph(main = toupper(input$symbol)) %>%
      dygraphs::dyAxis("y", label = "Stock Price") %>%
      dygraphs::dyCandlestick() %>% # can add compress = TRUE here if you want quarterly/monthly candles
      dygraphs::dyRangeSelector()
    
  })
  
  # Creating the candlestick chart using the chartSeries package
  # A good first place to start for charSeries https://www.quantmod.com/examples/charting/
  output$timeseries_chart <- renderPlot({
    req(stockdata)

    stockdata() %>%
      select("date","open","high","low","close","volume") %>%
      tibble::column_to_rownames(., var = "date") %>%
      as.xts() %>%
      chartSeries(.,
                  name = toupper(input$symbol),
                  type = "candlesticks",
                  col.vol = FALSE,
                  multi.col = FALSE,
                  TA=list(addVo()),
                  theme = chartTheme('white',bg.col='#FFFFFF',fg.col="#555555"
                                     ,up.border='#0449CB',up.col='#0449CB'
                                     ,dn.border='#C12626',dn.col='#C12626'
                                     ,area="#FFFFFF")

      )

  })
  
  
}
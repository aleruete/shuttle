require(dygraphs)

#UI Output/Namespace Section----
timeseries3UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("timeseries3_ui"))
}

#Module Section----
timeseries3 <- function(input, output, session) {
  
  #UI Section----
  
  output$timeseries3_ui <- renderUI({
    
    tagList(
      h2("Time Series: Step 3"),
      
      div(
        fluidRow(
          box(width = 2,
              
              textInput(session$ns("symbol"), "Stock Symbol", value = "AMZN"),
              dateInput(session$ns("start_date"), "Start Date", value = "2015-01-01"),
              dateInput(session$ns("end_date"), "End Date", value = Sys.Date()),
              actionButton(session$ns("update"), "Update")
          ),
          
          box(width = 10,
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
  
  # So the stock name reacts to the update button
  stockname <- eventReactive(input$update, {
    input$symbol
  })
  
  # stuff <- function(df){
  #   df[,6]
  # }
  # 
  # dxscoreTA <- newTA(FUN   = stuff, # chartSeries will pass whole dataset,
  #                    # I just want to process the last column
  #                    type   = 'h',
  #                    legend.name = "My_TA",
  #                    col   = "blue"
  # )
  
  # Creating the candlestick chart using the chartSeries package
  # A good first place to start for charSeries https://www.quantmod.com/examples/charting/
  output$timeseries_chart <- renderPlot({
    req(stockdata)

    stockdata() %>%
      select("date","open","high","low","close","volume") %>%
      column_to_rownames(., var = "date") %>%
      xts::as.xts() %>%
      chartSeries(.,
                  name = toupper(stockname()),
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
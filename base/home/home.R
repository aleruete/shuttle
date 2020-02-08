require(tidyquant)

homeUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("home_ui"))
}

home <- function(input, output, session) {
  
  
  output$home_ui <- renderUI({
    
    tagList(
      # h2("Welcome to Shuttle!"), MIGHT WANT TO PUT SOME HEADER HERE
      
      div(
        
        fluidRow(
          tags$style("
.nav-tabs-custom .nav-tabs li.active:hover a, .nav-tabs-custom .nav-tabs li.active a {
  color: #FE01B2;
}

.nav-tabs-custom .nav-tabs li.active {
  border-top-color: #555;
}
"),
          # tags$head(tags$style(HTML(".content { padding-left: 0;}"))), #removes extra padding from home page but messes up other modules
          column(8, div(style = "padding-left: 15px; padding-right: 15px;",
                 fluidRow( div(style = "padding-bottom: 15px;",
                   
                   tabBox(
                     id = session$ns("welcome_box"),
                     width = 5,
                     tabPanel(class = "home-tab",
                              title = span(tagList(icon("rocket")), "Getting Started"),  value = "start",
                              fluidRow(
                                column(
                                  12, htmlOutput(session$ns("start"))
                                ))),
                     tabPanel(class = "home-tab", style = "overflow-y:scroll;",
                              title = "About", value = "about", icon = icon("feather-alt"),
                              fluidRow(
                                column(12, htmlOutput(session$ns("about")))
                              )
                     ),
                     tabPanel(class = "home-tab",
                              title = "SDS", value = "sds", icon = icon(c("frog","kiwi-bird","truck-monster") %>% sample(., 1)),
                              fluidRow(
                                column(
                                  12, htmlOutput(session$ns("sds"))
                                ))),
                     tabPanel(class = "home-tab",
                              title = "Links", value = "links", icon = icon("plus"),
                              fluidRow(
                                column(
                                  12, htmlOutput(session$ns("links"))
                                )))
                     
                   ),
                   #Creates the scrollbar in the About tab          
                   tags$head(
                     tags$style(
                       HTML('
/* width */
::-webkit-scrollbar {
  width: 8px;
}

/* Track */
::-webkit-scrollbar-track {
  border-radius: 8px;
  background: #f1f1f1;
}

/* Handle */
::-webkit-scrollbar-thumb {
  border-radius: 8px;
  background: #888;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #555;
}
    '))),
                   column(7,
                          fluidRow(class = "shuttle-box-1",
                                   tags$head(tags$style("
                  #weather-container * {
                  display: inline;
                     }")), #weather-container is the name of the css object from Dark Sky
                                   div(id = "weather-container",
                                       icon("clock"),
                                       textOutput(session$ns("currentTime")),
                                       div(style = "padding-left: 15px;",
                                           icon("calendar-plus")),
                                       textOutput(session$ns("currentDay")),
                                       div(style = "padding-left: 15px;",
                                           icon("calendar-alt")),
                                       textOutput(session$ns("currentDate")), class = "date"),
                          fluidRow(class = "shuttle-box-2",
                                   column(4,
                                          selectizeInput(
                                            inputId = session$ns("control_gnews1"),
                                            label = NULL,
                                            selected = "topnews",
                                            choices = c("Top News" = "topnews",
                                                        "Sports" = "sports",
                                                        "Technology" = "technology",
                                                        "Business" = "business",
                                                        "Science" = "science",
                                                        "Health" = "health")
                                          )
                                          
                                   ),
                                   column(4,
                                          selectizeInput(
                                            inputId = session$ns("control_gnews2"),
                                            label = NULL,
                                            selected = "technology",
                                            choices = c("Top News" = "topnews",
                                                        "Sports" = "sports",
                                                        "Technology" = "technology",
                                                        "Business" = "business",
                                                        "Science" = "science",
                                                        "Health" = "health")
                                          )
                                          
                                   ),
                                   column(4,
                                          tags$div(tags$head(tags$style(HTML('.js-irs-0 .irs-min, .js-irs-0 .irs-max, .js-irs-0 .irs-single{
            visibility: hidden !important;}
.js-irs-0 .irs-bar-edge{border: 1px solid #FE01B2; background: #FE01B2;}
.js-irs-0 .irs-bar{border-top: 1px solid #FE01B2; border-bottom: 1px solid #FE01B2; background: #FE01B2;}
.js-irs-0{margin-top: -10px;}
    '))),
                                                   sliderInput(session$ns("articles1"),
                                                               label = NULL,
                                                               ticks = FALSE,
                                                               min = 3,
                                                               max = 8,
                                                               value = 5)
                                                   
                                                   
                                          ))
                                   
                          ),
                          hr(),
                          fluidRow(class = "shuttle-box-2",
                                   column(4,
                                          selectizeInput(
                                            inputId = session$ns("ticker_search"),
                                            label = "S&P500 Ticker",
                                            selected = ticker_list() %>% sample(., 1),
                                            choices = ticker_list(),
                                            multiple = FALSE,
                                            options = list(
                                              searchField = c("label","value")
                                            )
                                          )
                                   ),
                                   column(4, tags$style(HTML(".datepicker {z-index:99999 !important;}")),
                                          dateInput(session$ns("start_date"), label = "Start Date", value = "2017-01-01")
                                   ),
                                   column(4, tags$style(HTML(".datepicker {z-index:99999 !important;}")),
                                          dateInput(session$ns("end_date"), label = "End Date", value = Sys.Date())
                                   )
                                   
                          )
                          ),
                          div(style = "padding-top: 15px;",
                            fluidRow(class = "space-for-rent-box",
                                     div(textOutput(session$ns("spaceForRent")), class = "space-for-rent-header")))
                          
                                     
                   ))),

                 div(style = "padding-left: 15px; padding-top: 15px;", #adds the 15px padding for the stock ticker row
                 fluidRow(class = "shuttle-box-4",
                          column(12,
                                 plotOutput(session$ns("ticker_plot")) %>% shinycssloaders::withSpinner(color = "#FE01B2"))))
                 )),
          column(4, div(style = "padding-right: 15px;", # Only need padding-right bc the box to the left has padding already
                        fluidRow(
                          
                          column(6, div(style = "padding-right: 7px;",
                                        fluidRow(class = "shuttle-box-1",
                                                 div(textOutput(session$ns("header1")), class = "header-box-1"),
                                                 div(uiOutput(session$ns("gnews1")), class = "google-news")))),
                          column(6,
                                 div(style = "padding-left: 8px;",
                                     fluidRow(class = "shuttle-box-1",
                                              div(textOutput(session$ns("header2")), class = "header-box-1"),
                                              div(uiOutput(session$ns("gnews2")), class = "google-news"))
                                     
                                 ))
                        )
          ))
          
        )
      ))
    
  })
  
  output$about <- renderUI({includeMarkdown(paste0("base/home/about.md"))})
  
  output$sds <- renderUI({includeMarkdown(paste0("base/home/sds.md"))})
  
  output$start <- renderUI({includeMarkdown(paste0("base/home/start.md"))})
  
  output$links <- renderUI({includeMarkdown(paste0("base/home/links.md"))})

  
  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste0(strftime(Sys.time(),"%r %Z"))
  })
  
  output$currentDay <- renderText({
    invalidateLater(1000, session)
    paste0(strftime(Sys.time(),"%A"))
  })
  
  output$currentDate <- renderText({
    invalidateLater(1000, session)
    paste0(strftime(Sys.time(),"%B %e, %Y"))
  })
  
  output$spaceForRent <- renderText({
    "Space For Rent"
  })


  
  # Google News Feed
  
  gfeed1 <- reactiveValues(choice = "?hl=en-US&gl=US&ceid=US:en")
  
  gfeed2 <- reactiveValues(choice = "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen")
  
  observeEvent(input$control_gnews1, {

    if(input$control_gnews1 == "sports"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText("Sports")
    }
    else if(input$control_gnews1 == "technology"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText("Technology")
    }
    else if(input$control_gnews1 == "business"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText("Business")
    }
    else if(input$control_gnews1 == "entertainment"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText("Entertainment")
    }
    else if(input$control_gnews1 == "science"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp0Y1RjU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText("Science")
    }
    else if(input$control_gnews1 == "health"){
      gfeed1$choice <- "/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText("Health")
    }
    else{
      gfeed1$choice <- "?hl=en-US&gl=US&ceid=US:en"
      output$header1 <- renderText("Top News")
    }


  })
  
  observeEvent(input$control_gnews2, {

    if(input$control_gnews2 == "sports"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText("Sports")
    }
    else if(input$control_gnews2 == "technology"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText("Technology")
    }
    else if(input$control_gnews2 == "business"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText("Business")
    }
    else if(input$control_gnews2 == "entertainment"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText("Entertainment")
    }
    else if(input$control_gnews2 == "science"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp0Y1RjU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText("Science")
    }
    else if(input$control_gnews2 == "health"){
      gfeed2$choice <- "/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText("Health")
    }
    else{
      gfeed2$choice <- "?hl=en-US&gl=US&ceid=US:en"
      output$header2 <- renderText("Top News")
    }
    
    
  })
  
  refresh <- reactiveTimer(30000)
  
  observe({
    req(length(input$articles1)>0)
    refresh() #refreshes the extract
    
    tb <- googleRSS(paste0("https://news.google.com/rss",gfeed1$choice)) %>%
      select("item_title","item_link") %>%
      lapply(., function(x) gsub("[[:cntrl:]]", "", x)) %>% #removes the euro and tm symbol
      lapply(., function(x) gsub("\u00E2", "'", x)) %>% #removes the a-hat
      as_tibble()
    
    headline <- gsub(" -.*","",tb$item_title)
    outlet <- gsub(".*- ","",tb$item_title)
    
    lapply(seq_len(input$articles1), function(i) {
      output[[paste0("gnews1", i)]] <- renderUI({
        paste0('<h5>',outlet[i],'</h5>','<a href=','"',tb$item_link[i],'"',' target="_blank">',headline[i],'</a>') %>%
          HTML()
      })
    })
  })
  
  output$gnews1 <- renderUI({
    lapply(as.list(seq_len(input$articles1)), function(i) {
      
      fluidRow(
        column(12,
               htmlOutput(session$ns(paste0("gnews1", i))),
               hr()
        )
      )
    })
  })
  
  observe({
    req(length(input$articles1)>0)
    refresh() #refreshes the extract
    
    tb <- googleRSS(paste0("https://news.google.com/rss",gfeed2$choice)) %>%
      select("item_title","item_link") %>%
      lapply(., function(x) gsub("[[:cntrl:]]", "", x)) %>% #removes the euro and tm symbol
      lapply(., function(x) gsub("\u00E2", "'", x)) %>% #removes the a-hat
      as_tibble()
    
    headline <- gsub(" -.*","",tb$item_title)
    outlet <- gsub(".*- ","",tb$item_title)
    
    lapply(seq_len(input$articles1), function(i) {
      output[[paste0("gnews2", i)]] <- renderUI({
        paste0('<h5>',outlet[i],'</h5>','<a href=','"',tb$item_link[i],'"',' target="_blank">',headline[i],'</a>') %>%
          HTML()
      })
    })
  })
  
  output$gnews2 <- renderUI({
    lapply(as.list(seq_len(input$articles1)), function(i) {
      
      fluidRow(
        column(12,
               htmlOutput(session$ns(paste0("gnews2", i))),
               hr()
        )
      )
    })
  })
  
  
  
ticker_data <- reactive({
  
  tq_get(input$ticker_search, curl.options = list(ssl_verifypeer = 0), get = "stock.prices", from = input$start_date, to = input$end_date)
  
})


output$ticker_plot <- renderPlot({
  req(input$ticker_search > 0 & input$start_date > 0 & input$end_date > 0)
  
  ticker_data() %>%
    select("date","open","high","low","close","volume") %>%
    tibble::column_to_rownames(., var = "date") %>%
    xts::as.xts() %>%
    chartSeries(.,
                name = toupper(input$ticker_search),
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

#THIS NEEDS BETTER WRITTEN CODE
ticker_list <- reactive({
  
  url <- 'https://en.wikipedia.org/wiki/List_of_S%26P_500_companies'
  webpage <- read_html(url)
  
  table_html <- html_nodes(webpage,'#constituents td')
  table_data <- html_text(table_html)
  table_data <- trimws(table_data)
  table_data <- data.frame(table_data)
  
  
  nrows <- nrow(table_data)
  nrows <- ((nrows/9)-1)
  
  tickers <- NULL
  tickers <- data.frame(
    symbol=character(),
    security=character(),
    secfilings=character(),
    gics_sector=character(),
    gics_subsector=character(),
    headquarters=character(),
    dateadded=character(),
    cik=character(),
    founded=character(),
    stringsAsFactors=FALSE
  )
  
  for(i in 0:nrows) {
    for (j in 1:9){
      n <- as.integer(i*9 + j)
      tickers[i+1,j] <- as.character(table_data[n,])
    }
  }
  
  tickers_vec <- tickers$symbol
  names(tickers_vec) <- tickers$security
  
  return(tickers_vec)
  
})
  

}
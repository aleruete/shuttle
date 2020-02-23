require(tidyquant)

homeUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("home_ui"))
}

home <- function(input, output, session) {

  output$home_ui <- renderUI({
    
    tagList(

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
          column(8, div(style = "padding-left: 15px; padding-right: 15px;",
                        fluidRow(
                          column(9, 
                                 fluidRow(
                                   column(12,
                                          class = "shuttle-box-1",
                                          htmlOutput(session$ns("weather")))),
                                 div(style = "padding-top: 15px;",
                                 fluidRow(
                                   column(12, class = "shuttle-box-2",
                                          fluidRow(
                                          column(5,
                                                 div(class='home-selectize-input', style = "text-align: center;",
                                                          uiOutput(session$ns("stock_search"))
                                                 ),
                                                 tags$style(HTML(".datepicker {z-index:99999 !important;}")),
                                                 uiOutput(session$ns("stock_dates")),
                                                 fluidRow(
                                                   column(6,
                                                          actionButton(session$ns("random_ticker"), label = "Random Stock", icon = icon("dice"))
                                                   ),
                                                   column(4, offset = 1,
                                                          selectizeInput(inputId = session$ns("date_preset"), 
                                                                         label = NULL,
                                                                         selected = "365",
                                                                         choices = c("1M" = "30",
                                                                        "3M" = "90",
                                                                        "6M" = "120",
                                                                        "1Y" = "365",
                                                                        "2Y" = "730",
                                                                        "5Y" = "1825",
                                                                        "10Y" = "3650"))
                                                          )
                                                 )
                                                 ),
                                          column(7,
                                                 fluidRow(
                                                   column(8,
                                                          fluidRow(class = "header-underline",
                                                                   htmlOutput(session$ns("company_info_header"), class = "stock-info-label")
                                                          ),
                                                          fluidRow(style = "padding-top: 5px;",
                                                                   htmlOutput(session$ns("basic_info"))
                                                          )
                                                   ),
                                                   column(4,
                                                          fluidRow(class = "header-underline",
                                                                   htmlOutput(session$ns("stock_info_header"), class = "stock-info-label")
                                                          ),
                                                          fluidRow(style = "padding-top: 5px;",
                                                                   htmlOutput(session$ns("ticker_percent")),
                                                                   htmlOutput(session$ns("ticker_highlow"))
                                                          )
                                                   )
                                                 )
                                          )
                                                 
                                          )
                                   )
                                   ))
                          ),
                          column(3, div(style = "padding-left: 15px;",
                                        fluidRow(class = "shuttle-box-1",
                                                 div(style = "font-size: 18px; text-align: center;",
                                                     htmlOutput(session$ns("so_header"), class = "header-underline")),
                                                 div(class='home-selectize-input',
                                                 selectizeInput(inputId = session$ns("so_search"), 
                                                                label = NULL,
                                                                selected = c("r","shiny","shinydashboard","javascript","css","html","xml",
                                                                                    "tidyverse","rvest","tidyquant","quantmod","shinyjs") %>% sample(., 1),
                                                                width = "100%",
                                                                choices = c("r","shiny","shinydashboard","javascript","css","html","xml",
                                                                            "tidyverse","rvest","tidyquant","quantmod","shinyjs"))
                                                 ),
                                                 div(uiOutput(session$ns("so_questions")), class = "google-news"),
                                                 uiOutput(session$ns("so_header_type"))
                                                 )))
                          ), #ends fluidRow

                 div(style = "padding-top: 15px;", #adds the 15px padding for the stock ticker row
                 fluidRow(class = "shuttle-box-4",
                          column(12,
                                 plotOutput(session$ns("ticker_plot")) %>% shinycssloaders::withSpinner(color = "#FE01B2"))))
                 )),
          column(4, div(style = "padding-right: 15px;", # Only need padding-right bc the box to the left has padding already
                        fluidRow(class = "shuttle-box-1",
                                 tags$head(tags$style("#date-container * {display: inline;}")),
                                   div(id = "date-container",
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
                                                 tags$div(class='home-selectize-input',
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
                                                                      max = 10,
                                                                      value = 5)
                                                          
                                                          
                                                 )),
                                          
                                          column(4,
                                                 tags$div(class='home-selectize-input',
                                                 selectizeInput(
                                                   inputId = session$ns("control_gnews2"),
                                                   label = NULL,
                                                   selected = c("sports","technology","business","science","health") %>% sample(., 1),
                                                   choices = c("Top News" = "topnews",
                                                               "Sports" = "sports",
                                                               "Technology" = "technology",
                                                               "Business" = "business",
                                                               "Science" = "science",
                                                               "Health" = "health")
                                                 )
                                                 )   
                                          )
                                          
                                 )),
                                 
                        fluidRow(style = "padding-top: 15px;",
                          
                          column(6, div(style = "padding-right: 7px;",
                                        fluidRow(class = "shuttle-box-1",
                                                 div(style = "font-size: 22px; text-align: center; padding-bottom: 5px;",
                                                   htmlOutput(session$ns("header1")), class = "header-underline"),
                                                 div(uiOutput(session$ns("gnews1")), class = "google-news")))),
                          column(6,
                                 div(style = "padding-left: 8px;",
                                     fluidRow(class = "shuttle-box-1",
                                              div(style = "font-size: 22px; text-align: center; padding-bottom: 5px;",
                                                htmlOutput(session$ns("header2")), class = "header-underline"),
                                              div(uiOutput(session$ns("gnews2")), class = "google-news"))
                                     
                                 ))
                        )
          ))
          
        )
        
      ))
    
  })

  # Date and Time ----
  
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
  
  # Stack Overflow ----
  
  url_tag <- reactiveVal()
  
  url_sort <- reactiveVal("active")
  
  observeEvent(input$so_search, {
    url_tag(input[["so_search"]])
  })
  
  observeEvent(input$so_search_type, {
    url_sort(input[["so_search_type"]])
  })
  
  output$so_header_type <- renderUI({
    
    tags$div(class='home-selectize-input-nobox',
             selectizeInput(inputId = session$ns("so_search_type"),
                            label = NULL,
                            selected = "active",
                            choices = c("Newest" = "newest",
                                        "Active" = "active",
                                        "Unanswered" = "unaswered",
                                        "Votes" = "votes",
                                        "Frequent" = "frequent")
             )
    )
  })
  
  output$so_header <- renderText({
    validate(
      need(url_tag() != "", "Select a Tag")
    )
    
    url <- paste0('https://stackoverflow.com/questions/tagged/?tagnames=',url_tag(),'&sort=',url_sort())
    paste0('<a href=','"',url,'"',' target="_blank">Stack Overflow</a>')
    
  })
  
  observe({
    req(input$so_search>0 & url_tag()>0)

    url <- paste0('https://stackoverflow.com/feeds/tag?tagnames=',url_tag(),'&sort=',url_sort())
    
    item_title <- read_html(url) %>% html_nodes("title") %>% html_text()
    item_link <- read_html(url) %>% html_nodes("link") %>% html_attr('href')
    
    item_link <- item_link[2:length(item_link)]
    
    tb <- data.frame(item_title,item_link) %>%
      lapply(., function(x) gsub("[[:cntrl:]]", "", x)) %>% #removes the euro and tm symbol
      lapply(., function(x) gsub("\u00E2", "'", x)) %>% #removes the a-hat
      as_tibble()
    
    lapply(seq_len(length(tb$item_title)), function(i) {
      output[[paste0("so_questions", i)]] <- renderUI({
        paste0('<a href=','"',tb$item_link[i],'"',' target="_blank">',tb$item_title[i],'</a>') %>%
          HTML()
      })
    })
  })
  
  output$so_questions <- renderUI({
    
    lapply(as.list(2:5), function(i) {
      
      fluidRow(
        column(12,
               htmlOutput(session$ns(paste0("so_questions", i))),
               hr()
        )
      )
    })
  })
  
  random_selected <- eventReactive(input$random_ticker, {
    
    ticker_list() %>% sample(., 1)
    
  }, ignoreNULL = FALSE)
  
  output$stock_search <- renderUI({
    
    selectizeInput(
      inputId = session$ns("ticker_search"),
      label = "S&P500 Stock Search",
      selected = random_selected(),
      choices = ticker_list(),
      multiple = FALSE,
      options = list(
        searchField = c("label","value")
      )
    )
    
  })
  
  output$stock_dates <- renderUI({
    
    dateRangeInput(session$ns("date_range"), label = NULL, 
                   start = Sys.Date() - as.numeric(input$date_preset),
                   end = Sys.Date())
    
  })
  
  # Google News Feed ----
  
  gfeed1 <- reactiveValues(choice = "?hl=en-US&gl=US&ceid=US:en")
  
  gfeed2 <- reactiveValues(choice = "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen")
  
  observeEvent(input$control_gnews1, {

    if(input$control_gnews1 == "sports"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Sports</a>')
    }
    else if(input$control_gnews1 == "technology"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Technology</a>')
    }
    else if(input$control_gnews1 == "business"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Business</a>')
    }
    else if(input$control_gnews1 == "entertainment"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Entertainment</a>')
    }
    else if(input$control_gnews1 == "science"){
      gfeed1$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp0Y1RjU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp0Y1RjU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Science</a>')
    }
    else if(input$control_gnews1 == "health"){
      gfeed1$choice <- "/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"
      output$header1 <- renderText('<a href="https://news.google.com/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Health</a>')
    }
    else{
      gfeed1$choice <- "?hl=en-US&gl=US&ceid=US:en"
      output$header1 <- renderText('<a href="https://news.google.com/?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Top News</a>')
    }


  })
  
  observeEvent(input$control_gnews2, {

    if(input$control_gnews1 == "sports"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Sports</a>')
    }
    else if(input$control_gnews2 == "technology"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Technology</a>')
    }
    else if(input$control_gnews2 == "business"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Business</a>')
    }
    else if(input$control_gnews2 == "entertainment"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Entertainment</a>')
    }
    else if(input$control_gnews2 == "science"){
      gfeed2$choice <- "/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp0Y1RjU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText('<a href="https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp0Y1RjU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Science</a>')
    }
    else if(input$control_gnews2 == "health"){
      gfeed2$choice <- "/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"
      output$header2 <- renderText('<a href="https://news.google.com/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Health</a>')
    }
    else{
      gfeed2$choice <- "?hl=en-US&gl=US&ceid=US:en"
      output$header2 <- renderText('<a href="https://news.google.com/?hl=en-US&gl=US&ceid=US%3Aen" target="_blank">Top News</a>')
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
  
  # S&P500 Ticker Search and Charts ----
  
ticker_data <- reactive({
  
  tq_get(input$ticker_search, curl.options = list(ssl_verifypeer = 0), get = "stock.prices", from = input$date_range[1], to = input$date_range[2])
  
})


output$ticker_plot <- renderPlot({
  req(input$ticker_search > 0 & input$date_range[1] > 0 & input$date_range[2] > 0)
  
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

# Stock price summary

output$company_info_header <- renderText({

  paste("Company Information")

})

output$stock_info_header <- renderText({
  
  paste("Stock Information")
  
})

output$ticker_percent <- renderText({
  req(input$ticker_search > 0 & input$date_range[1] > 0 & input$date_range[2] > 0)
  
  percent <- round((ticker_data()$close[nrow(ticker_data())]-ticker_data()$close[1])/ticker_data()$close[1]*100, 2)
  
  if(percent < 0){
    return(paste("<p>","Change:","<span style=\"color:red\">",percent,"%</span>","</p>"))
    
  }else{
    return(paste("<p>","Change:","<span style=\"color:blue\">",percent,"%</span>","</p>"))
  }

})

output$ticker_highlow <- renderText({
  req(input$ticker_search > 0 & input$date_range[1] > 0 & input$date_range[2] > 0)
  
  high <- round(max(ticker_data()$close), 2)
  low <- round(min(ticker_data()$close), 2)
  
  paste("<p>","High:",high,"</p>",
        "<p>","Low:",low,"</p>"
  )
  
})

output$basic_info <- renderText({
  req(input$ticker_search > 0 & input$date_range[1] > 0 & input$date_range[2] > 0)

  n <- which(grepl(input$ticker_search, ticker_list()))
  
  paste("<p>","Symbol:",company_info()$symbol[n],"</p>",
        "<p>","Industry:",company_info()$gics_sector[n],"</p>",
        "<p>","Subsector:",company_info()$gics_subsector[n],"</p>"
        )

})

company_info <- reactive({
  
  url <- 'https://en.wikipedia.org/wiki/List_of_S%26P_500_companies'
  
  table_data <- read_html(url) %>%
    html_nodes(.,'#constituents td') %>%
    html_text() %>%
    trimws()
  
  nrows <- length(table_data)
  nrows <- ((nrows/9)-1)
  
  tickers <- NULL
  tickers <- tibble(
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
      tickers[i+1,j] <- as.character(table_data[n])
    }
  }
  
  return(tickers)
  
})


ticker_list <- reactive({
  req(company_info())
  
  tickers_vec <- gsub("[.]","-",company_info()$symbol)
  names(tickers_vec) <- company_info()$security
  
  return(tickers_vec)
  
})

 # Weather ----
output$weather <- renderUI({
  
  dark.base1 <- "https://forecast.io/embed/#"
  call.dark1 <- paste(dark.base1, "lat=", user_lat, "&lon=", user_long, "&name=", user_loc, sep="")
  tags$iframe(src=call.dark1, width= "100%", height= 230, frameborder= 0)
  
})


}
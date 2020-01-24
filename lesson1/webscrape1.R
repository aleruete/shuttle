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
      h2("Web Scrape: Step 1"),
      
      div(
        fluidRow(
          
          box(width = 10, title = "Topics Scraped from CNN World Markets/Asia",
              DT::dataTableOutput(session$ns("webscrape_table"))
              
          )
        )
      )
    )
    
  })
  
  #Server Section----
  
  webscrape_data <- reactive({
    
    url <- 'https://money.cnn.com/data/world_markets/asia/'
    
    url %>%
      read_html() %>%
      html_nodes(.,'#section_latestnews li') %>%
      html_text() %>%
      trimws() %>%
      tibble()
      # data.frame() %>%
      # tibble()
    
    
    # webpage <- read_html(url)
    # table_html <- html_nodes(webpage,'#section_latestnews li')
    # table_text <- html_text(table_html)
    # table_text <- trimws(table_text)
    # table_data <- data.frame(table_text)

  })
  
  output$webscrape_table <- DT::renderDataTable({
    req(webscrape_data())
    
    webscrape_data()
    
  })
  
  
  
  # url <- 'https://money.cnn.com/data/world_markets/asia/'
  # webpage <- read_html(url)
  # 
  # table_html <- html_nodes(webpage,'#section_latestnews li')
  # table_text <- html_text(table_html)
  # table_text <- trimws(table_text)
  # table_data <- data.frame(table_text)
  
}
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
  
  # Scraping the data
  webscrape_data <- reactive({
    
    url <- 'https://money.cnn.com/data/world_markets/asia/' # the website that we are scraping
    
    url %>%
      read_html() %>%
      html_nodes(.,'#section_latestnews li') %>% # we figure out which element to target by using the SelectorGadget plugin
      html_text() %>%
      trimws() %>%
      tibble()

  })
  
  # Rendering the scraped data into a datatable
  output$webscrape_table <- DT::renderDataTable({
    req(webscrape_data())
    
    webscrape_data()
    
  })
  
}
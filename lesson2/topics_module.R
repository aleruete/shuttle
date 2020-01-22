docScrapeUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("docScrape_ui"))
}

docScrape <- function(input, output, session) {

  output$docScrape_ui <- renderUI({
    
    tagList(
      h2("Advanced Topics Module"),
      
      div(
        fluidRow(
          
          uiOutput(session$ns("table"))
          
        )
      )
    )
  
})
  
  output$table <- renderUI({
    lapply(as.list(seq_len(length(topics.df))), function(i) {
      box(
        id = 'box-id',
        title = topics.df[i],
        background = 'light-blue',
        width = 2,
        collapsible = F,
        collapsed = F,
        fluidRow(
          column(12,
                 DT::dataTableOutput(session$ns(paste0("table", i))))
        )
      )
    })
  })
  
  topics.df <- list.files(path = "shuttle/venus/", pattern = '*Rhtml')
  
  observe({
    lapply(seq_len(length(topics.df)), function(i) {
      output[[paste0("table", i)]] <- DT::renderDataTable(
        read_html(paste0("shuttle/venus/",topics.df[i])) %>%
          html_nodes("h3") %>%
          html_text() %>%
          tibble() %>%
          datatable(.,
                    colnames = 'Highlights',
                    class = 'cell-border stripe',
                    options = list(autoWidth = F, paging = F,
                                   columnDefs = list(list(width = '200px', targets = c(1))), dom = 't', bSort=F)) %>%
          formatStyle('.', color = 'black')
      )
    })
  })
  
  
}

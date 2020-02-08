#UI Output/Namespace Section----
datatable2UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("datatable2_ui"))
}

#Module Section----
datatable2 <- function(input, output, session) {
  
  #UI Section----
  
  output$datatable2_ui <- renderUI({
    
    tagList(
      h2("DataTable: Step 2"),
      
      div(
        fluidRow(
          column(12,
                 DT::dataTableOutput(session$ns("standard_table"))
          ),
          column(6,
                 verbatimTextOutput(session$ns("cell_info"))
          )
        )
      )
    )
    
  })
  
  #Server Section----
  
  standard_data <- reactive({
    
    iris
    
  })
  
  output$standard_table <- DT::renderDataTable({
    req(standard_data())
                
    standard_data() %>%
      DT::datatable(.,
                class = 'cell-border stripe',
                selection = 'none',
                rownames=FALSE)
    
  })
  
  output$cell_info <- renderPrint({
    input$standard_table_cell_clicked
  })
  
  
}
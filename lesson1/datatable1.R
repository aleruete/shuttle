#UI Output/Namespace Section----
datatable1UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("datatable1_ui"))
}

#Module Section----
datatable1 <- function(input, output, session) {
  
  #UI Section----
  
  output$datatable1_ui <- renderUI({
    
    tagList(
      h2("DataTable: Step 1"),
      
      div(
        fluidRow(
          column(12,
                 DT::dataTableOutput(session$ns("standard_table"))
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
  
  standard_data()
  
})
  
  
}
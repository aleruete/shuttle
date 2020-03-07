loginUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("login_ui"))
}

login <- function(input, output, session) {
  
  credentials <- reactiveValues(access = FALSE,
                                name = NULL)
  
  output$login_ui <- renderUI({
    
    if(credentials$access == TRUE) return(NULL)
    
    fluidPage(
      div(style = 'width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;',
          wellPanel(
            h2("3.. 2.. 1..", style = 'color:#1c1e21; font-weight: bold; text-align: center; padding-top: 0;'),
            
            textInput(session$ns("user_name"), "User Name:", value = user_github),
            
            div(style = "text-align: center;",
                actionButton(session$ns("login_button"), "Launch", class = 'btn-primary', style = 'color: white;')
            ),
            
            uiOutput(session$ns("login_error"))
          )
      )
    )
  })


observeEvent(input$login_button, {
  
  # Username <- input$user_name
  
  if (input$user_name != user_github) {
    output$login_error <- renderUI({
      p("Invalid username!", style = "color: red; font-weight: bold; padding-top: 5px;", style = 'font-weight: bold; text-align: center;')
    })
  } else {
    
    credentials$access <- TRUE
    credentials$name <- input$user_name
  }
  
})

return(reactive(reactiveValuesToList(credentials)))

  
}
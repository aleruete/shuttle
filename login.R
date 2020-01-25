loginUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("login_ui"))
}

login <- function(input, output, session) {
  
  credentials <- reactiveValues(user_login = FALSE,
                                user = NULL)
  
output$login_ui <- renderUI({
  
  if(credentials$user_login == TRUE) return(NULL)
  
  fluidPage(
    div(style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
        wellPanel(tags$head(
          tags$link(rel = "stylesheet", type = "text/css",
                    href = "style.css")),
          h2("3.. 2.. 1..", class = "text-center", style = "padding-top: 0;"),
          
          tags$div(class = "text-center",
                   tags$p("Hold on to your butts")
                   ),
          
          textInput(session$ns("user_name"), "User Name:", value = "shuttleds"),
          
          #passwordInput(session$ns("password"), "Password:"),
          
          div(
            style = "text-align: center;",
            actionButton(session$ns("login_button"), "Launch", class = "btn-primary", style = "color: white;")
          ),
          
          uiOutput(session$ns("login_error"))
          
          )
        )
  )
  
})


observeEvent(input$login_button, {
  
  Username <- input$user_name
  #Password <- "admin_pass"
  
  if (Username != "shuttleds") {
    output$login_error <- renderUI({
      p("Invalid username!", style = "color: red; font-weight: bold; padding-top: 5px;", class = "text-center")
    })
  } else {
    
    credentials$user_login <- TRUE
    credentials$user <- Username
  }
  
})

return(reactive(reactiveValuesToList(credentials)))

  
}
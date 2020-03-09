require(shinyBS)

loginUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("login_ui"))
}

login <- function(input, output, session) {
  
  credentials <- reactiveValues(access = FALSE,
                                name = NULL,
                                zip = NULL)
  
  output$login_ui <- renderUI({
    
    if(credentials$access == TRUE) return(NULL)
    
    fluidPage(
      div(style = 'width: 300px; max-width: 100%; margin: 0 auto; padding: 20px;',
        wellPanel(style = "padding-top: 0;",
            
            h2("Login", style = 'color:#1c1e21; font-weight: bold; text-align: center; padding-top: 0;'),

            div(style = 'text-align: center;',
                htmlOutput(session$ns("github_img")),
                div(style = 'padding-top: 5px; font-size: 20px;',
                  htmlOutput(session$ns("zip_location")))
            ),
            
            hr(),
            
            div(style = 'padding-top: 10px;',
                fluidRow(
                  column(9, style = 'padding-right: 0;',
                         textInput(session$ns("user_name"), label = NULL, value = user_github, placeholder = "GitHub User Name")),
                  column(3, shinyBS::bsButton(session$ns("q_name"), label = "", icon = icon("question-circle", class = 'question-mark'), style = "default", size = "extra-small")),
                  bsTooltip(id = session$ns("q_name"), "Only used to pull your avatar.", placement = "right", trigger = "click", options = NULL)
                ),
                
                fluidRow(
                  column(9, style = 'padding-right: 0;',
                         textInput(session$ns("user_zip"), label = NULL, value = "11201", placeholder = "Zip Code")),
                  column(3, shinyBS::bsButton(session$ns("q_zip"), label = "", icon = icon("question-circle", class = 'question-mark'), style = "default", size = "extra-small")),
                  bsTooltip(id = session$ns("q_zip"), "Only used to show a weather forecast and display your city.", placement = "right", trigger = "click", options = NULL)
                  )
            ),

            div(style = 'text-align: center;',
                actionButton(session$ns("login_button"), "Launch", class = 'btn-primary', style = 'color: white;')
            ),
            
            uiOutput(session$ns("login_error"))
            )
    ))
  })
  
  # Prevent warnings and errors from user inputs
  InputCheck <- function(input) {
    
    tryCatch({
      url <- paste0("https://github.com/",input,".png")
      suppressWarnings(con <- url(url, "rb"))
      
      if(length(con)>0) {
        close(con)
        rm(con)
        TRUE
      } else {FALSE}
    }, error = function(e) FALSE)
  }

  
  output$github_img <- renderText({
    
    if (!InputCheck(input$user_name)) {
      '<img src="github_pic.png"/ class="github-img">'
    } else {
      paste0('<img src="https://github.com/',input$user_name,'.png"/ class="github-img">')
    }
  })
  
  
  observeEvent(input$user_zip, {
    zip_data <- input$user_zip %>%
      paste0('http://www.geonames.org/postalcode-search.html?q=',.,'&country=') %>%
      read_html() %>%
      html_nodes(.,'tr:nth-child(2) td:nth-child(2) , tr:nth-child(3) small') %>%
      html_text() %>%
      trimws()
    
    output$zip_location <- renderText({
      req(zip_data)
      shiny::validate(
        need(input$user_zip != "", "Enter Zip Code")
      )
      paste0(zip_data[1])
    })
  })
  

  observeEvent(input$login_button, {
    
    if (!InputCheck(input$user_name)) {
      output$login_error <- renderUI({
        p("Invalid username", style = "color: red; font-weight: bold; padding-top: 5px;", style = 'font-weight: bold; text-align: center;')
      })
    } else {
      credentials$access <- TRUE
      credentials$name <- input$user_name
      credentials$zip <- input$user_zip
    }
  })

  return(reactive(reactiveValuesToList(credentials)))

}
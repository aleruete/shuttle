#UI Output/Namespace Section----
welcomeUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("welcome_ui"))
}

#Module Section----
welcome <- function(input, output, session) {
  
  #UI Section----

  output$welcome_ui <- renderUI({
    
    tagList(
      
      div(
        column(12,
               fluidRow(
                 tabBox(
                   id = session$ns("welcome_box"),
                   width = 6,
                   tabPanel(class = "welcome-tab",
                            title = "Welcome",  value = "start", icon = icon("rocket"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("welcome")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "Lesson 1", value = "lesson1", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("lesson1")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "Lesson 2", value = "lesson2", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("lesson2")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "Lesson 3", value = "lesson3", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("lesson3")))
                            ))
                 )))
      )
    )
    
  })

  #Server Section----
  
  output$welcome <- renderUI({includeMarkdown(paste0("base/welcome/welcome.md"))})
  
  output$lesson1 <- renderUI({includeMarkdown(paste0("base/welcome/lesson1.md"))})
  
  output$lesson2 <- renderUI({includeMarkdown(paste0("base/welcome/lesson2.md"))})
  
  output$lesson3 <- renderUI({includeMarkdown(paste0("base/welcome/lesson3.md"))})
  
}
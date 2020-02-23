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
                   width = 5,
                   tabPanel(class = "home-tab",
                            title = "Getting Started",  value = "start", icon = icon("rocket"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("start")))
                            )),
                   tabPanel(class = "home-tab", style = "overflow-y:scroll;",
                            title = "About", value = "about", icon = icon("feather-alt"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("about")))
                            )),
                   tabPanel(class = "home-tab",
                            title = "SDS", value = "sds", icon = icon(c("frog","kiwi-bird","truck-monster") %>% sample(., 1)),
                            fluidRow(
                              column(12, htmlOutput(session$ns("sds")))
                            )),
                   tabPanel(class = "home-tab",
                            title = "Links", value = "links", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("links")))
                            ))
                 ),
                 
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
  
  output$about <- renderUI({includeMarkdown(paste0("base/home/about.md"))})
  
  output$sds <- renderUI({includeMarkdown(paste0("base/home/sds.md"))})
  
  output$start <- renderUI({includeMarkdown(paste0("base/home/start.md"))})
  
  output$links <- renderUI({includeMarkdown(paste0("base/home/links.md"))})
  
  
  output$welcome <- renderUI({includeMarkdown(paste0("base/welcome/welcome.md"))})
  
  output$lesson1 <- renderUI({includeMarkdown(paste0("base/welcome/lesson1.md"))})
  
  output$lesson2 <- renderUI({includeMarkdown(paste0("base/welcome/lesson2.md"))})
  
  output$lesson3 <- renderUI({includeMarkdown(paste0("base/welcome/lesson3.md"))})
  
}
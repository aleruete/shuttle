#UI Output/Namespace Section----
ggplot1UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("ggplot1_ui"))
}

#Module Section----
ggplot1 <- function(input, output, session) {
  
  #UI Section----

  output$ggplot1_ui <- renderUI({
    
    tagList(
      h2("ggplot2: Step 1"),
      
      div(
        fluidRow(
              
              # Show a plot of the generated distribution
              box(
                plotOutput(session$ns("dotPlot1")),
                plotOutput(session$ns("dotPlot2"))
              )
            ))
      )
         
  })

  #Server Section----
  
  output$dotPlot1 <- renderPlot({
    
    #ggplot script
    ggplot(data = mpg) +
      geom_point(mapping = aes(x = displ, y = hwy))
    
  })
  
  output$dotPlot2 <- renderPlot({
    
    #ggplot script
    ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
      geom_point(mapping = aes(color = class)) +
      geom_smooth()
    
  })
  
  
}
#UI Output/Namespace Section----
geyser2UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("geyser2_ui"))
}

# Example found at https://rmarkdown.rstudio.com/flexdashboard/shiny.html

#Module Section----
geyser2 <- function(input, output, session) {
  
  #UI Section----
  
  output$geyser2_ui <- renderUI({
    
    tagList(
      h2("Geyser: Step 2"),
      
      div(
        fluidRow(
          
          # Box with a information and controls for the plot
          box(width = 3,
              title = "Old Faithful Geyser Data",
              
              strong("Description"),
              textOutput(session$ns("description")),
              hr(),
              
              h4("Basic Info"),
              verbatimTextOutput(session$ns("observations")),
              verbatimTextOutput(session$ns("mean")),
              hr(),
              
              h4("Plot Controls"),
              selectInput(session$ns("bins"), label = "Number of bins:",
                          choices = c(10, 20, 50), selected = 50),
              
              sliderInput(session$ns("bandwidth"), label = "Bandwidth adjustment:",
                          min = 0.2, max = 2, value = 1, step = 0.2)
          ),
          
          # Show a plot of the generated distribution
          box(width = 6,
              plotOutput(session$ns("distPlot"))
          )
        ))
    )
    
  })
  
  #Server Section----
  
  output$distPlot <- renderPlot({
    
    # draw the histogram with the specified number of bins
    hist(faithful$waiting, probability = TRUE, breaks = as.numeric(input$bins), col = 'darkgray', border = 'white',
         xlab = "Waiting Time (minutes)", main = "Old Faithful Geyser Eruption")
    
    # draw a density line
    dens <- density(faithful$waiting, adjust = input$bandwidth)
    lines(dens, col = "blue")
    
  })
  
  output$description <- renderText(
    "Waiting time between eruptions for the Old Faithful geyser in Yellowstone National Park, Wyoming, USA."
  )
  
  output$observations <- renderText(
    paste("Number of Obvervations:", nrow(faithful))
  )
  
  output$mean <- renderText(
    paste("Mean of Waiting Time:", mean(faithful$waiting) %>% round(digits = 3), "minutes")
  )
  
}

ui <- dashboardPage(title = "Shuttle",
                    header = dashboardHeader(title = span(tagList(actionLink("ichooseyou", "", icon = icon("space-shuttle"), style='color: #FE01B2; margin: 0; display: inline;'), "Shuttle", class = "shuttle-title"))
                                             # dropdownMenuOutput("messages"),
                                             # dropdownMenuOutput("notifications"),
                                             # dropdownMenuOutput("tasks")
                    ),
                    
                    dashboardSidebar(
                      
                      # Settings for the User Panel ----
                      div(style = "border-bottom: 4px double #f2f2f2; border-top: 1px solid #f2f2f2;",
                          div(
                            tags$head( #having this here loads the style.css sheet as soon as the app is launched
                              tags$link(rel = "stylesheet", type = "text/css",
                                        href = "style.css")),
                            uiOutput("userpanel"), class = "userpanel"),
                          div(
                            uiOutput("links"), class = "links")
                      ),
                      
                      # Settings for the Mission Selection ----
                      div(style = "margin-top: 10px;",
                          
                          collapsed = TRUE, sidebarMenuOutput("sidebar"),
                          selectInput("mission", "Mission:",
                                      c("Gemini","Apollo"))
                          # uiOutput( "browser")
                          )
                      
                          
                    ),
                    
                    # Settings for the sidebar display ----
                    dashboardBody(
                      shinyjs::useShinyjs(),
                      tags$head(tags$style(".table{margin: 0 auto;}")),
                      skin = "black",
                      loginUI("login"),
                      tabItems(
                        tabItem("home_tabname", homeUI("home")),
                        tabItem("welcome_tabname", welcomeUI("welcome")),
                        #Lesson 1
                        tabItem("geyser1_tabname", geyser1UI("geyser1")),
                        tabItem("weather1_tabname", weather1UI("weather1")),
                        tabItem("datatable1_tabname", datatable1UI("datatable1")),
                        tabItem("timeseries1_tabname", timeseries1UI("timeseries1")),
                        tabItem("webscrape1_tabname", webscrape1UI("webscrape1")),
                        #Lesson 2
                        tabItem("geyser2_tabname", geyser2UI("geyser2")),
                        tabItem("datatable2_tabname", datatable2UI("datatable2")),
                        tabItem("timeseries2_tabname", timeseries2UI("timeseries2")),
                        #Lesson 3
                        tabItem("weather3_tabname", weather3UI("weather3"))
                      ),
                      
                      # Sets the style for the text in the top right
                      tags$head(
                        tags$style(
                          HTML('
                              .myClass{
                                font-size: 15px;
                                line-height: 30px;
                                float: right;
                                font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
                                padding: 0 15px;
                                margin-top: 8px;
                                overflow: hidden;
                                color: #f2f2f2;
                              }
    ')),
           #              # Creates the scrolling text in the top right corner
           #              tags$script(
           #                HTML('
           # $(document).ready(function() {
           #  $("header").find("nav").append(\'<span class="myClass"><marquee behavior="scroll" direction="left">Your scrolling text goes here. This is a really long message to test the length of the scrolling.</marquee></span>\');
           # })
           # ')),
                        # Keeps the app alive when a process is taking a long time
                        tags$head(
                          HTML(
                            "
                            <script>
var socket_time_interval
var n = 0
$(document).on('shiny:connected', function(event) {
socket_timeout_interval = setInterval(function() {
Shiny.onInputChange('count', n++)
}, 1500)
});
$(document).on('shiny:disconnected', function(event) {
clearInterval(socket_timeout_interval)
});
</script>
"
                          )
                        )
                        
                        
                        
                        
                        
                      )
                    )
)
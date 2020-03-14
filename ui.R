
ui <- dashboardPage(title = "Shuttle",
                    header = dashboardHeader(titleWidth = 210, title = tags$a(id="ichooseyou", href = "", class = "action-button shiny-bound-input", tags$img(src='logo.png', width='160', height='38'))
                    ),
                    
                    dashboardSidebar(width = 210,
                                     tags$head(
                                       tags$link(rel = "stylesheet", type = "text/css",
                                                 href = "style.css")),
                                     # Settings for the User Panel ----
                                     div(style = 'border-bottom: 4px double #f2f2f2; border-top: 1px solid #f2f2f2;',
                                         div(class = 'userpanel', uiOutput("userpanel"))
                                         # div(class = 'links', uiOutput("links"))
                                     ),
                                     
                                     # Settings for the Mission Selection ----
                                     div(style = 'padding-top: 5px; padding-left: 8px;',
                                         uiOutput("mission_radio")),
                                     collapsed = TRUE, sidebarMenuOutput("sidebar")
                    ),
                    
                    # Settings for the sidebar display ----
                    dashboardBody(
                      shinyjs::useShinyjs(),
                      tags$head(tags$style('.table{margin: 0 auto;}')),
                      skin = "black",
                      loginUI("login"),
                      tabItems(
                        tabItem("home_tabname", homeUI("home")),
                        tabItem("welcome_tabname", welcomeUI("welcome")),
                        # Gemini
                        tabItem("geyser1_tabname", geyser1UI("geyser1")),
                        tabItem("ggplot1_tabname", ggplot1UI("ggplot1")),
                        tabItem("weather1_tabname", weather1UI("weather1")),
                        tabItem("datatable1_tabname", datatable1UI("datatable1")),
                        tabItem("timeseries1_tabname", timeseries1UI("timeseries1")),
                        tabItem("webscrape1_tabname", webscrape1UI("webscrape1")),
                        tabItem("geyser2_tabname", geyser2UI("geyser2")),
                        tabItem("datatable2_tabname", datatable2UI("datatable2")),
                        tabItem("timeseries2_tabname", timeseries2UI("timeseries2")),
                        tabItem("weather3_tabname", weather3UI("weather3"))
                        # Apollo 
                        # Reference your UI here.
                        
                      ),
                      tags$head(
                        # Shuttle links in header ----
                        tags$script(
                          HTML(paste0('
    $(document).ready(function() {
     $("header").find("nav").append(\'<span class="links">'
                                      ,'<a href="https://www.youtube.com/channel/UCHIge2lulmLXhEhWpajOT3Q" target="_blank>"','<i class="fab fa-youtube"></i></a>'
                                      ,'<a href="https://www.instagram.com/shuttleds/" target="_blank>"','<i class="fab fa-instagram"></i></a>'
                                      ,'<a href="https://twitter.com/shuttledatasci/" target="_blank>"','<i class="fab fa-twitter"></i></a>'
                                      ,'<a href="https://github.com/shuttleds" target="_blank>"','<i class="fab fa-github"></i></a>'
                                      ,'</span>\');
    })
    '))),
                        # Stayin' Alive! ----
                        tags$script(                        
                          HTML('
var socket_time_interval
var n = 0
$(document).on("shiny:connected", function(event) {
socket_timeout_interval = setInterval(function() {
Shiny.onInputChange("count", n++)
}, 1500)
});
$(document).on("shiny:disconnected", function(event) {
clearInterval(socket_timeout_interval)
});
                        '))
                      )
                    )
)

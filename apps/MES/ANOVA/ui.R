source("global.R")

thematic::thematic_shiny(font = "auto")

ui <- navbarPage("MESOCP - Analysis of Variance",
                 theme = bs_theme(verion = 4, bootswatch = "litera"),
                 #theme = bs_theme(bootswatch = "journal"),
                 tabPanel(
                          headerPanel(""),
                          sidebarLayout(
                              sidebarPanel(
                                  width = 3,
                                  fluidRow(
                                      column(width = 12,
                                             div(style = "font-size:15px;",
                                             selectInput("dataset", h4("Dataset"), choices=c("Random Data" = "random",
                                                                                             "Fuel Consumption" = "fuel", 
                                                                                             "Temperature Effect" = "temperature"))),
                                      uiOutput("random_parameter"))),
                                  br(),
                                  HTML(paste0("<h5>","Type of Data Generating", "</h5>")),
                                  div(style = "font-size:15px;",
                                      radioButtons("data_generate", label=(""),
                                                   choices=c("random sampling"="random", "representative point"="rps"), selected = "rps", inline=T)),
                                  HTML(paste0("<h5>","Type of Plot", "</h5>")),
                                  div(style = "font-size:15px;",
                                      radioButtons("aovplottype", label=(""),
                                                   choices=c("scatter plot"="scatter", "boxplot"="boxplot"), selected = "boxplot", inline=T)),
                                  #checkboxInput("anovaseed", "fix random seed (for reproducibility)", value = TRUE),
                                  hr(),
                                  br(),
                                  HTML('<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/" target="_blank"><img alt="Licence Creative Commons" style="border-width:0"
                                  src="http://i.creativecommons.org/l/by-nc/4.0/80x15.png"/></a> This work of <span xmlns:cc="http://creativecommons.org/ns#"
                                  property="cc:attributionName"><font face="Courier">BNU-HKBU UIC Bayes-Cluster</font></span> is made available under the terms of the <a rel="license"
                                  href="http://creativecommons.org/licenses/by-nc/4.0/" target="_blank">Attribution-NonCommercial 4.0 International</a>. You can report a bug or check the code by click the <font face="Courier">code</font> below
                                  or go back to the <font face="Courier">home</font> page'),
                                  
                                  disconnectMessage(
                                    text = "Your session timed out, reload the application.",
                                    refresh = "Reload now",
                                    background = "#f89f43",
                                    colour = "white",
                                    overlayColour = "grey",
                                    overlayOpacity = 0.3,
                                    refreshColour = "brown"
                                  ),
                                  
                                  box(title="", "", actionButton(inputId='ab1', 
                                                                 label="home",
                                                                 icon = icon("home"),
                                                                 onclick ="window.open('https://falcon.uicstat.com/shiny/MES/index.html', '_blank')", 
                                                                 style='padding:5px; font-size:80% color: #fff; background-color: #cbcec1; border-color: #cbcec1'),
                                                    actionButton(inputId='ab2', 
                                                                 label="code",
                                                                 icon = icon("github"),
                                                                 onclick ="window.open('https://github.com/Bayes-Cluster/MES', '_blank')", 
                                                                 style='padding:5px; font-size:80% color: #fff; background-color: #cbcec1; border-color: #cbcec1'))
                              ),
                              
                          mainPanel(
                              width = 9,
                              fluidRow(
                                  #align="center",
                                  column(width = 6, 
                                         HTML(paste0("<h4>","Plot","</h4>")),
                                         plotlyOutput("aovPlot")),
                                  column(width = 6,
                                         HTML(paste0("<h4>","Descriptive Statistics", "</h4>")),
                                         dataTableOutput("aovdataSummary"),
                                         br(),
                                         
                                         HTML(paste0("<h4>","ANOVA Table","</h4>")),
                                         dataTableOutput("aovSummary")
                                  ),
                                  column(width = 12,
                                         br(),
                                         hr(),
                                         withMathJax(includeMarkdown("resource/anova.md")),
                                         br())
                              ))),
                          )
                 
                 
                 
)

# library(profvis)
# profvis(runApp())
source("global.R")
thematic::thematic_shiny(font = "auto")

ui <- navbarPage("MESOCP - Linear Regression",
                 theme = bs_theme(verion = 4, bootswatch = "litera"),
                 tabPanel(
                          withMathJax(),
                          headerPanel(""),
                          sidebarLayout(
                              position = c("left", "right"),
                              sidebarPanel(
                                  width = 4,
                                  selectInput("lm_x", label = h4("Select the feature:"), 
                                              choices = list("completed building" = "x1", "GDP" = "x2"), 
                                              selected = "x1"),
                                  
                                  print("To remove the *outlier*, first browsing your mose over a set of point, then, toggle these points out of the dataset by click the toggle button"),
                                  hr(),
                                  h4("Simple Linear Regression Summary:"),
                                  verbatimTextOutput("rsquare1"),
                                  hr(),
                                  box("", "",
                                  actionButton("exclude_toggle", "Toggle in/out the values!",icon("paper-plane"), 
                                               style="padding:5px; color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                  actionButton("exclude_reset", "Reset", style="padding:5px")),
                                  hr(),
                                  HTML('<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/" target="_blank"><img alt="Licence Creative Commons" style="border-width:0"
                                  src="http://i.creativecommons.org/l/by-nc/4.0/80x15.png"/></a> This work of <span xmlns:cc="http://creativecommons.org/ns#"
                                  property="cc:attributionName"><font face="Courier">BNU-HKBU UIC Bayes-Cluster</font></span> is made available under the terms of the <a rel="license"
                                  href="http://creativecommons.org/licenses/by-nc/4.0/" target="_blank">Attribution-NonCommercial 4.0 International</a>. You can report a bug or check the code by click the <font face="Courier">code</font> below
                                  or go back to the <font face="Courier">home</font> page'),
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
                                  width = 8,
                                  fluidRow(
                                      h4("Regression Visualization"),
                                      plotOutput("plot1", height = 600, width = 1200,
                                                 click = "plot1_click",
                                                 brush = brushOpts(
                                                     id = "plot1_brush"
                                                 )
                                      ),
                                      h4("Residual Plots"),
                                      plotOutput("lmplot", height = 600, width = 1200,
                                                 click = "plot1_click",
                                                 brush = brushOpts(
                                                     id = "plot1_brush"
                                                 )
                                      )
                                  ))
                          )
                 )
                 
                 
                 
)
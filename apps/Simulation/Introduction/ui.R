library(shinythemes)
source("global.R")

thematic::thematic_shiny(font = "auto")

ui <- navbarPage(title="Simulation - Introduction",
                 useShinyalert(),
                 theme = bs_theme("progress-bar-bg" = "mix(white, orange, 20%)", base_font=font_google("JetBrains Mono"), code_font=font_google("JetBrains Mono")),
                 tabPanel(withMathJax(),
                          title = "Estimation of \\( \\pi \\): Drawing a Circle",
                          sidebarLayout(
                            sidebarPanel(
                              numericInput("numPoints", "Number of Points:", min=100, max=10^4, value=1000),
                              actionButton("simulate", "Run Simulation", icon = icon("rocket")),
                              hr(),
                              HTML('<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank"><img alt="Licence Creative Commons" style="border-width:0"
                                      src="http://i.creativecommons.org/l/by-nc-nd/4.0/80x15.png"/></a> This work of <span xmlns:cc="http://creativecommons.org/ns#"
                                      property="cc:attributionName"><font face="Courier">BNU-HKBU UIC Bayes-Cluster</font></span> is made available under the terms of the <a rel="license"
                                      href="http://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank">CC BY-NC-ND 4.0</a>. You can report a bug or check the code by click the <font face="Courier">code</font> below
                                      or go back to the <font face="Courier">home</font> page'),
                              box(title="", "", 
                                  actionButton(inputId='ab1', 
                                               label="home",
                                               icon = icon("home"),
                                               onclick ="window.open('https://github.com/Bayes-Cluster/WALS', '_blank')", 
                                               style='padding:5px; font-size:80% color: #fff; background-color: #cbcec1; border-color: #cbcec1'),
                                  actionButton(inputId='ab2', 
                                               label="code",
                                               icon = icon("github"),
                                               onclick ="window.open('https://github.com/Bayes-Cluster/WALS', '_blank')", 
                                               style='padding:5px; font-size:80% color: #fff; background-color: #cbcec1; border-color: #cbcec1'))
                            ),
                          mainPanel(
                            fluidRow(column(12, uiOutput("example1")),
                                     column(12, plotlyOutput("piPlot")))
                            )
                          )
                 ),
                 tabPanel(withMathJax(),
                          title = "Estimation pf \\( \\pi \\): Buffon's Needle Experiment",
                          sidebarLayout(
                            sidebarPanel(
                              numericInput("plane", "Plane width:", 10, 6, 100),
                              numericInput("B", "Number of trials:", min=100, max=10^4, value=1000),
                              numericInput("M", "Number of experiments:", 1, 1, 1000),
                              actionButton("cast", "Run Simulation", icon = icon("rocket")),
                              hr(),
                              HTML('<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank"><img alt="Licence Creative Commons" style="border-width:0"
                                      src="http://i.creativecommons.org/l/by-nc-nd/4.0/80x15.png"/></a> This work of <span xmlns:cc="http://creativecommons.org/ns#"
                                      property="cc:attributionName"><font face="Courier">BNU-HKBU UIC Bayes-Cluster</font></span> is made available under the terms of the <a rel="license"
                                      href="http://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank">CC BY-NC-ND 4.0</a>. You can report a bug or check the code by click the <font face="Courier">code</font> below
                                      or go back to the <font face="Courier">home</font> page'),
                              box(title="", "", 
                                  actionButton(inputId='ab1', 
                                               label="home",
                                               icon = icon("home"),
                                               onclick ="window.open('https://github.com/Bayes-Cluster/WALS', '_blank')", 
                                               style='padding:5px; font-size:80% color: #fff; background-color: #cbcec1; border-color: #cbcec1'),
                                  actionButton(inputId='ab2', 
                                               label="code",
                                               icon = icon("github"),
                                               onclick ="window.open('https://github.com/Bayes-Cluster/WALS', '_blank')", 
                                               style='padding:5px; font-size:80% color: #fff; background-color: #cbcec1; border-color: #cbcec1'))
                            ),
                            mainPanel(
                              fluidRow(column(12, plotOutput("exp")),
                                       column(12, plotOutput("conv")))
                            )
                          )
                 ),
)
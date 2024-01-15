source("global.R")
library(shinydisconnect)

thematic::thematic_shiny(font = "auto")

#options(shiny.sanitize.errors = TRUE)
# Define UI for random distribution application 

ui <- navbarPage("MESOCP - Distribution Visualization",
                 theme = bs_theme(verion = 4, bootswatch = "litera"),
                 tabPanel(headerPanel(""),
                          sidebarLayout(
                              position = c("left", "right"),
                              fluid = TRUE,
                              sidebarPanel(
                                tags$style(type="text/css", ".inline label{ display: table-cell; text-align: left; vertical-align: middle; } 
                 .inline .form-group{display: table-row;}"),
                                tags$h4("Parameter"),
                                fluidRow(
                                  width = 3,
                                  column(width=6,
                                         selectInput("DistType", p(strong("Choose a distribution")), list("Continous" = "con",  "Discrete" = "dis")),
                                         uiOutput("distribution"),
                                         selectInput(inputId = "pdf_cdf", label = "PDF/PMF or CDF/CMF", choices = c("PDF/PMF" = "PDF", "CDF/CMF" = "CDF")),
                                         p("X-axis Range:"),
                                         sliderInput("plot_slider", label="", min = -100, max = 100, value = c(-5, 5))),
                                  column(width=6, 
                                         p("Parameters:"), tags$div(class = "inline", uiOutput("parameter")), 
                                         br(),
                                         p("Calculate Probability of Interval:"), 
                                         #div(style = "font-size:10px;",actionButton("probarun", label=("Run"), icon("paper-plane"), 
                                         #                                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4")),
                                         uiOutput("probability_slider"), 
                                         uiOutput("probability"))), 
                                  column(width=12,
                                         hr(),
                                         #tags$h4("Summary"),
                                         #verbatimTextOutput("summary"),
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
                                  )),
                              # Show a tabset that includes a plot, summary, and table view
                              # of the generated distribution
                              mainPanel(
                                fluidRow(
                                    width = 8,
                                    column(width=12,
                                      tags$h4("Plot"),
                                      plotlyOutput("plot"),
                                      tags$br(),
                                      uiOutput("formula")
                                    )
                              )))
                          )
)
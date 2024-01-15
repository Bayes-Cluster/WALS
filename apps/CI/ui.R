source("global.R")
thematic::thematic_shiny(font = "auto")

#options(shiny.sanitize.errors = TRUE)
# Define UI for random distribution application 
ui <- navbarPage("MESOCP - Confidence Interval",
                 theme = bs_theme(verion = 4, bootswatch = "litera"),
                 #theme = bs_theme(bootswatch = "journal"),
                 
                 tabPanel(
                     headerPanel(""),
                          sidebarLayout(
                              sidebarPanel(
                                  width = 4,
                                  numericInput("n_sigma", label=h4("n sigma"), value=2, min=1,max=3,step=1),
                                  numericInput("sample_size", label= h4("Sample size"), value = 5, min = 1, max = 10, step = 1),
                                  numericInput("sample_mean_1", label = h4("Sample mean 1"), value = 31.3, min = 27, max = 35, step=0.1),
                                  numericInput("sample_mean_2", label = h4("Sample mean 2"), value = 31.7, min = 27, max = 35, step=0.1),
                                  numericInput("sample_mean_3", label = h4("Sample mean 3"), value = 32.5, min = 27, max = 35, step=0.1),
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
                                      plotlyOutput("ci_plot", height = 600, width = 1200)),
                                  withMathJax(includeMarkdown("resource/confidence_interval.md")),
                              )))
                 
                 
                 
)
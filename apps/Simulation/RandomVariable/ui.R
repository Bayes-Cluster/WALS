source("global.R")

thematic::thematic_shiny(font = "auto")

ui <- navbarPage("Simulation - Random Variable Generation",
                 theme = bs_theme("progress-bar-bg" = "mix(white, orange, 20%)", base_font=font_google("JetBrains Mono"), code_font=font_google("JetBrains Mono")),
                 tabPanel("Example 1",
                   sidebarLayout(
                     sidebarPanel(
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
                                column(12, plotlyOutput("histPlot1")))
                     )
                   )
                 ),
                 tabPanel("Example 2",
                          sidebarLayout(
                            sidebarPanel(
                              numericInput("lambda2", "Exponential's \\(\\lambda\\):", min = 0.1, max = 5, value = 2),
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
                              fluidRow(column(12, uiOutput("example2")),
                                       column(12, plotlyOutput("histplot2")),
                                       column(12, plotlyOutput("qqplot2")))
                            )
                          )
                 ),
                 tabPanel("Example 7",
                   withMathJax(),
                   sidebarLayout(
                     sidebarPanel(
                       width = 3,
                       numericInput("alpha", "Gamma's \\(\\alpha\\):", min = 0.1, max = 5, value = 1.5),
                       numericInput("beta", "Gamma's \\(\\beta\\):", min = 0.1, max = 5, value = 1),
                       numericInput("lambda", "Exponential's \\(\\lambda\\):", min = 0.1, max = 5, value = 0.6667),
                       numericInput("c", "Constant \\(c\\):", min = 0.1, max = 5, value = 1.258),
                       sliderInput("range", "Range:", min = -5, max = 10, value = c(0, 5)),
                       actionButton("simulate7", "Run Simulation", icon = icon("rocket")),
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
                       width = 9,
                       fluidRow(
                         column(12, uiOutput("example7"))
                       ),
                       fluidRow(
                         column(6, plotlyOutput("densityplot7")),
                         column(6, plotlyOutput("histplot7")),
                         column(12, plotlyOutput("simulation7"))
                       )
                     )
                  )
                )
              )

# library(profvis)
# profvis(runApp())
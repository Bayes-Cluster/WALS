ui <- fluidPage(
  
  # Application title
  titlePanel(h4("Buffon\'s needle experiment - Inputs:")),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("plane", "Plane width:", 6, 10, 100),
      numericInput("B", "Number of trials:", 100, 20, 10^6),
      numericInput("M", "Number of experiments:", 1, 1, 100),
      numericInput("seed", "Simulation seed", 1777, 1, 1000000),
      actionButton("cast", "Let's cast some needles!", icon = icon("thumbs-up"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Experiment", plotOutput("exp")),
        tabPanel("Convergence", plotOutput("conv"))
      )
    )
  )
)
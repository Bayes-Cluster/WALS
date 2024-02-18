library(ggplot2)
library(bslib)
source("global.R")

server <- function(input, output) {
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  
  shinyalert("Welcome", "Click the Red Button to run the simulation", type = "info")
  
  pointsData <- reactiveVal(NULL)  # Initialize with NULL
  
  observeEvent(input$simulate, {
    numPoints <- input$numPoints
    # Generate random points
    x <- runif(numPoints, min = -1, max = 1)
    y <- runif(numPoints, min = -1, max = 1)
    inside <- sqrt(x^2 + y^2) <= 1
    # Store the data in a reactive value
    pointsData(data.frame(x = x, y = y, inside = inside))
  })
  
  # Calculate Pi estimate
  piEstimate <- reactive({
    data <- pointsData()
    if (is.null(data)) {
      return(NA)
    }
    4 * mean(data$inside)
  })
  
  output$example1 <- renderUI({
    withMathJax(includeMarkdown("example/1.md"))
  })
  
  # Plot the points
  output$piPlot <- renderPlotly({
    data <- pointsData()
    if (is.null(data)) {
      return(NULL)
    }
  
    # Define the circle shape
    circle_shape <- list(
      type = 'circle',
      xref = 'x', yref = 'y',
      x0 = -1, y0 = -1,
      x1 = 1, y1 = 1,
      line = list(color = 'black')
    )
    
    plot_ly(data = data, x = ~x, y = ~y, color = ~inside, colors = c('red', 'blue')) %>%
      layout(title = TeX(paste("N = ", input$numPoints, "\\ \\pi=", round(piEstimate(), 4))),
             xaxis = list(title = TeX("X"), range = c(-1, 1)),
             yaxis = list(title = TeX("Y"), range = c(-1, 1)),
             shapes = list(circle_shape),  # Add the circle shape to the layout
             showlegend = FALSE, width=750, height=750)
  })
  
  
  ######## Buffon's Needle ###########
  
  # Fling some needles!
  cast <- eventReactive(input$cast, {
    buffon_experiment(B = input$B, plane_width = input$plane)
  })
  
  conv <- eventReactive(input$cast, {
    converge(B = input$B, plane_width = input$plane, 
             seed = input$seed, M = input$M)
  })
  
  output$exp <- renderPlot({
    plot(cast())
  })
  
  output$conv <- renderPlot({
    conv()
  })

}


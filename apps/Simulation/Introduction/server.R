server <- function(input, output) {
  
  # Fling some needles!
  cast <- eventReactive(input$cast, {
    buffon_experiment(B = input$B, plane_width = input$plane, 
                      seed = input$seed)
  })
  
  output$exp <- renderPlot({
    plot(cast())
  }, height = 620)
  
  output$conv <- renderPlot({
    # Add graph 2 here!
  }, height = 620)
}
library(ggplot2)

server <- function(input, output) {
  
  ##### 3.1 #####
  output$example1 <- renderUI({
    withMathJax(includeMarkdown("example/1.md"))
  })
  
  output$histPlot1 <- renderPlotly({
    N <- 10000
    u <- runif(N)
    x <- u^(1/3) # Generate random sample from specified distribution
    
    # Create a data frame for ggplot
    df <- data.frame(x)
    
    # Create the histogram using ggplot
    ggplot(df, aes(x)) +
      geom_histogram(aes(y = ..density..), bins = 100, fill = 'grey') +
      stat_function(fun = function(x) 3 * x^2, color = "blue", size = 1) +
      ggtitle("Histogram of x") +
      xlab("x") +
      ylab("Density") +
      theme_minimal()
    
    # Convert the ggplot object to a plotly object
    #ggplotly(p)
  })
  
  ##### 3.2 #####
  output$example2 <- renderUI({
    withMathJax(includeMarkdown("example/2.md"))
  })
  
  output$histplot2 <- renderPlotly({
    N <- 10000
    lambda <- 2
    u <- runif(N)
    x <- (-1/input$lambda2)*log(u)
    
    df <- data.frame(x = x)
    
    p_hist <- ggplot(df, aes(x)) +
      geom_histogram(aes(y = ..density..), bins = 100, fill = 'grey') +
      stat_function(fun = function(x) dexp(x, rate = lambda), color = "blue", size = 1) +
      ggtitle("Histogram of x") +
      xlab("x") +
      ylab("Density") +
      theme_minimal()
    
    ggplotly(p_hist)
  })
  
  output$qqplot2 <- renderPlotly({
    N <- 5000
    lambda <- 2
    u <- runif(N)
    x <- (-1/input$lambda2)*log(u)
    x <- sort(x)
    
    df_qq <- data.frame(
      Theoretical = qexp(ppoints(N), rate = lambda),
      Sample = x
    )
    
    p_qq <- ggplot(df_qq, aes(x = Theoretical, y = Sample)) +
      geom_point(shape = 1) +
      geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
      ggtitle(paste0("Q-Q plot for Exp(λ=", input$lambda2, ")")) +
      xlab("Theoretical value from exponential distribution") +
      ylab("Sample") +
      theme_minimal()
    
    ggplotly(p_qq)
  })
  
  output$example7 <- renderUI({
    ## Continuous
    withMathJax(includeMarkdown("example/7.md"))
  })
  
  output$densityplot7 <- renderPlotly({
    x <- seq(input$range[1], input$range[2], length.out = 100)
    gamma_density <- dgamma(x, shape = input$alpha, rate = input$beta)
    exp_density <- dexp(x, rate = input$lambda)
    scaled_exp_density <- input$c * dexp(x, rate = input$lambda)
    
    p <- ggplot(data.frame(x), aes(x)) +
      geom_line(aes(y = gamma_density, colour = paste0("Gamma (α=", input$alpha, ", β=", input$beta, ")", sep=""))) +
      geom_line(aes(y = exp_density, colour = paste("Exp (λ=", input$lambda, ")", sep=""))) +
      geom_line(aes(y = scaled_exp_density, colour = paste("Scaled Exp (cλ=", input$c, ")", sep=""))) +
      scale_colour_manual(values = c("blue", "red", "green")) +
      theme_minimal() +
      theme(
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 12)
        ) + 
      labs(x= "X", y="Density", colour = "") +
      guides(colour = guide_legend(override.aes = list(size = 2))) + 
      ggtitle("PDF of Gamma, Exponential ans Scaled Exponential")
  
    plotly_obj <- ggplotly(p, tooltip = "text")
    
    # Modify the layout to adjust the legend position within the Plotly object
    plotly_obj %>% layout(legend = list(
      orientation = "h",
      xanchor = "center",
      yanchor = "top",
      x = 0.5,
      y = 1.0
    ))
  })
  
  output$histplot7 <- renderPlotly({
    # Generate random values from the gamma distribution

    sample_gamma <- rgamma(1000, shape = input$alpha, rate = input$beta)
    
    # Create the histogram plot
    p <- ggplot(data.frame(x = sample_gamma), aes(x)) +
      geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", colour = "skyblue") +
      xlim(range(sample_gamma)) +
      theme_minimal() +
      labs(x = "X", y = "Density") +
      theme_minimal() +
      theme(
        axis.text = element_text(size = 12),  # Increase axis text size
        axis.title = element_text(size = 12)  # Increase axis title size
      ) + 
      ggtitle(paste0("Histogram of Gamma", "(", input$alpha,", ", input$beta, ")"))
    
    # Overlay the gamma distribution
    # Note: We create a reactive expression for the gamma distribution function
    gamma_dens <- reactive({
      function(x) {
        dgamma(x, shape = input$alpha, rate = input$beta)
      }
    })
    
    p <- p + stat_function(fun = gamma_dens(), colour = "red", size = 0.5)
    
    # Convert ggplot object to plotly object
    ggplotly(p, tooltip = c("x", "y"))
  })

  output$simulation7<- renderPlotly({
    N <- 2000 
    lambda <- 2/3
    x <- seq(input$range[1], input$range[2], by = 0.01)
    f <- function(x) { (2/sqrt(pi))*(x^(1/2))*exp(-x) }
    g <- function(x) { (2/3)*exp(-2*x/3) }
    cc=c(3*((3/(2*pi*exp(1)))^(1/2)),2)
    sample_gamma <- rgamma(1000, shape = input$alpha, rate = input$beta)
    
    
    plots <- lapply(1:2, function(j) {
      frames <-
      for (i in seq(1, N, length.out=10)){
        u1 <- runif(N)
        Y <- (-1/lambda)*log(u1)
        u2 <- runif(N)
        Z <- cc[j]*u2*g(Y) # Cug(x)
        aa <- which(u2 < f(Y)/(cc[j]*g(Y)))
        
        data <- data.frame(x = c(x, Y[aa], Y[-aa]),
                           y = c(f(x), Z[aa], Z[-aa]),
                           group = c(rep('f(x)', length(x)), rep('Accepted', length(aa)), rep('Rejected', length(Y)-length(aa))))
        
        p <- ggplot(data, aes(x = x, y = y, colour = group)) +
          geom_line(data = data[data$group == 'f(x)',], aes(x = x, y = y)) +
          geom_point(data = data[data$group == 'Accepted',], aes(x = x, y = y), colour = 'red', size = 0.4) +
          geom_point(data = data[data$group == 'Rejected',], aes(x = x, y = y), colour = 'blue', size = 0.4) +
          scale_colour_manual(values = c('f(x)' = 'blue', 'Accepted' = 'red', 'Rejected' = 'blue')) +
          theme_minimal() +
          labs(title = paste('c=', round(cc[j], 2), ' Acceptance Rate=', length(aa)/N)) + 
          xlim(range(sample_gamma))
        frames[[i]] <- list(data=list(p), name=as.character(i))
      }
      p <- ggplotly(p) %>%
        animation_opts(frame = 100, redraw = TRUE) %>%
        animation_slider(currentvalue = list(prefix = "Iteration: ")) %>%
        animation_button(x = 1, xanchor = "right", y = 0, yanchor = "bottom")
      
      return(p)
    })
    
    # Combine the plots (you will need the patchwork library for this)
    combined_plot <- patchwork::wrap_plots(plots[[1]], plots[[2]])
    
    # Convert the combined ggplot object to a Plotly object
    ggplotly(combined_plot)
  })
  
}
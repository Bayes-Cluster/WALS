source("global.R")

# Define server logic for random distribution application
shinyServer(function(input, output, session){
    mu <- 31.5
    std <- 0.8
    ci_seq <- seq(27.5, 35.5, length.out = 100)
    ## Confidence Interval 
    # ci_data <- reactive({
    #   data.frame(x = ci_seq,
    #              y = dnorm(ci_seq, mean = mu, sd=std),
    #              e = dnorm(ci_seq, mean=input$input$sample_mean, sd=std)
    #     )})
    
    output$ci_plot <- renderPlotly({
        mu <- 31.5
        std <- 0.3577
        ci_seq <- seq(29, 34, length.out=100)
        ci_data <- data.frame(x = ci_seq, 
                              y = dnorm(ci_seq, mean = mu, sd=std))
        sigma <- std #/ sqrt(input$sample_size)
        two_sigma <- input$n_sigma * round(sigma, 2)
        ggplot(ci_data) +
            geom_line(aes(x=x, y=y)) +
            geom_vline(xintercept = mu, color="sky blue",linetype="dashed") +
            geom_ribbon(data = subset(ci_data, x > (31.5 - two_sigma) & x < (31.5 + two_sigma)),
                        aes(x=x, ymin=0, ymax=y),
                        fill = "sky blue", alpha = .3) +
            ## population mean
            annotate(geom="text", x=((mu + two_sigma) + (mu - two_sigma))/2, y= 0.05, label=expression(mu),
                     color="black") +
            annotate(geom="text", x=(mu - two_sigma), y= -0.01, label=paste0("[ ", (mu - two_sigma)),
                     color="sky blue") + 
            annotate(geom="text", x=((mu + two_sigma) + (mu - two_sigma))/2, y= -0.01, label=paste0("--", mu, "--"),
                     color="sky blue") + 
            annotate(geom="text", x=(mu + two_sigma), y= -0.01, label=paste0((mu + two_sigma), " ]"),
                     color="sky blue") + 
            ## sample mean 1
            annotate(geom="text", x=(input$sample_mean_1 - two_sigma), y= -0.04, label=paste0("[ ", (input$sample_mean_1 - two_sigma)),
                     color="red") + 
            annotate(geom="text", x=((input$sample_mean_1 + two_sigma) + (input$sample_mean_1 - two_sigma))/2, y= -0.04, label=paste0("-- ", input$sample_mean_1, " --"),
                     color="red") + 
            annotate(geom="text", x=(input$sample_mean_1 + two_sigma), y= -0.04, label=paste0((input$sample_mean_1 + two_sigma), " ]"),
                     color="red") + 
            ## sample mean 2
            annotate(geom="text", x=(input$sample_mean_2 - two_sigma), y= -0.08, label=paste0("[ ", (input$sample_mean_2 - two_sigma)),
                     color="chocolate1") + 
            annotate(geom="text", x=((input$sample_mean_2 + two_sigma) + (input$sample_mean_2 - two_sigma))/2, y= -0.08, label=paste0("-- ", input$sample_mean_2, " --"),
                     color="chocolate1") + 
            annotate(geom="text", x=(input$sample_mean_2 + two_sigma), y= -0.08, label=paste0((input$sample_mean_2 + two_sigma), " ]"),
                     color="chocolate1") + 
            ## sample mean 3
            annotate(geom="text", x=(input$sample_mean_3 - two_sigma), y= -0.12, label=paste0("[ ", (input$sample_mean_3 - two_sigma)),
                     color="darkgreen") + 
            annotate(geom="text", x=((input$sample_mean_3 + two_sigma) + (input$sample_mean_3 - two_sigma))/2, y= -0.12, label=paste0("-- ", input$sample_mean_3, " --"),
                     color="darkgreen") + 
            annotate(geom="text", x=(input$sample_mean_3 + two_sigma), y= -0.12, label=paste0((input$sample_mean_3 + two_sigma), " ]"),
                     color="darkgreen") + 
            theme_bw()
    })
    
})
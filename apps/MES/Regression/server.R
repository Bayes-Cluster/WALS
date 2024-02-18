source("global.R")
cities <- read.csv("data/cities.csv")
# Define server logic for random distribution application

shinyServer(function(input, output, session){

    ## Linear Regression
    vals <- reactiveValues(
        keeprows = rep(TRUE, nrow(cities))
    )
    vals2 <- reactiveValues(
        keeprows2 = rep(TRUE, nrow(cities))
    )
    
    output$plot1 <- renderPlot({
        if (input$lm_x == "x2"){
            # Plot the kept and excluded points as two separate data sets
            keep    <- cities[ vals$keeprows, , drop = FALSE]
            exclude <- cities[!vals$keeprows, , drop = FALSE]
            
            ggplot(keep, aes(planing, GDP)) + geom_point() +
                geom_smooth(method = lm, fullrange = TRUE, color = "blue") +
                geom_point(data = exclude, shape = 5, fill = "red", color = "red", alpha = 0.75) +
                coord_cartesian(xlim = c(0, 50), ylim = c(500,20000))  +
                geom_text(aes(label = keep$city), family="Arial", size = 3.5)
        } else if(input$lm_x == "x1"){
            keep    <- cities[ vals$keeprows, , drop = FALSE]
            exclude <- cities[!vals$keeprows, , drop = FALSE]
            
            ggplot(keep, aes(planing, completed)) + geom_point() +
                geom_smooth(method = lm, fullrange = TRUE, color = "blue") +
                geom_point(data = exclude, shape = 5, fill = "red", color = "red", alpha = 0.75) +
                coord_cartesian(xlim = c(0, 50), ylim = c(0,60))  +
                geom_text(aes(label = keep$city), family="Arial", size = 3.5)
        }
    })
    
    output$rsquare1 <- renderPrint({
        if (input$lm_x == "x2"){
            keep <- cities[ vals$keeprows, , drop = FALSE]
            fit <- with(keep, lm(planing ~ GDP))
        } else if (input$lm_x == "x1"){
            keep <- cities[ vals$keeprows, , drop = FALSE]
            fit <- with(keep, lm(planing ~ completed))
        }
        summary(fit)#$r.square
    })
    
    output$lmplot <- renderPlot({
        if (input$lm_x == "x2"){
            keep <- cities[ vals$keeprows, , drop = FALSE]
            fit <- with(keep, lm(planing ~ GDP))
        } else if (input$lm_x == "x1"){
            keep <- cities[ vals$keeprows, , drop = FALSE]
            fit <- with(keep, lm(planing ~ completed))
        }
        par(mfcol=c(2,2))
        plot(fit)
    })
    
    
    # Toggle points that are clicked
    observeEvent(input$plot1_click, {
        res <- nearPoints(cities, input$plot1_click, allRows = TRUE)})
    # Toggle points that are brushed
    observeEvent(input$exclude_toggle, {
        res <- brushedPoints(cities, input$plot1_brush, allRows = TRUE)
        
        vals$keeprows <- xor(vals$keeprows, res$selected_)
    })
    # Reset all
    observeEvent(input$exclude_reset, {
        vals$keeprows <- rep(TRUE, nrow(cities))
    })
    
    
    mu <- 31.5
    std <- 0.8
    ci_seq <- seq(27.5, 35.5, length.out = 100)
    ## Confidence Interval 
    # ci_data <- reactive({
    #   data.frame(x = ci_seq,
    #              y = dnorm(ci_seq, mean = mu, sd=std),
    #              e = dnorm(ci_seq, mean=input$input$sample_mean, sd=std)
    #     )})
    
    output$ci_plot <- renderPlot({
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
    
    rnorm1 = repeatable(rnorm)
    rnorm2 = repeatable(rnorm)
    rnorm3 = repeatable(rnorm)
    
    gen_data = reactive({
        anova_size1 = input$anova_size1; anova_size2 = input$anova_size2; anova_size3 = input$anova_size3;
        anova_mu1 = input$anova_mu1; anova_mu2 = input$anova_mu2; anova_mu3 = input$anova_mu3; anova_sigma = input$anova_sigma;
        anova_data1 = rnorm1(anova_size1, anova_mu1, anova_sigma)
        anova_data2 = rnorm2(anova_size2, anova_mu2, anova_sigma)
        anova_data3 = rnorm3(anova_size3, anova_mu3, anova_sigma)
        y = c(anova_data1, anova_data2, anova_data3)
        group = c(rep(sprintf("group %s", 1), each = anova_size1),
                  rep(sprintf("group %s", 2), each = anova_size2),
                  rep(sprintf("group %s", 3), each = anova_size3))
        data.frame(datapoint = y, group = group)
    })
    
    output$aovPlot = renderPlot({
        if (input$aovplottype == "boxplot"){
            means <- aggregate(datapoint ~  group, gen_data(), mean)
            ggplot(gen_data(), aes(y=group, x=datapoint,fill=group)) + 
                geom_boxplot(alpha=0.3) +
                stat_summary(fun=mean, colour="brown2", geom="point", 
                             shape=17, size=3, show.legend=FALSE) + 
                geom_text(data = means, aes(label = sprintf("%0.3f", datapoint), x = datapoint + 0.08)) + 
                theme(legend.position="none", plot.title = element_text(hjust = 0.5)) +
                # ggtitle("Boxplot") +
                scale_fill_brewer(palette="Accent")} 
        else if (input$aovplottype == "histogram"){
            ggplot(gen_data(), aes(x = datapoint, color = group)) + 
                geom_histogram(binwidth = 1, fill = "white") + 
                facet_grid( ~ group) + 
                # ggtitle("Histogram of three groups") + 
                scale_fill_brewer(palette = "Accent")
        }
    })
    
    output$aovdataSummary = renderTable({
        group_by(gen_data(), group) %>%
            dplyr::summarise(count = n(), 
                             mean = mean(datapoint, na.rm = TRUE), 
                             sd = sd(datapoint, na.rm = TRUE))
    })
    
    output$aovSummary = renderTable({
        data.frame(unclass(summary(aov(datapoint ~ group, data = gen_data()))), check.names = FALSE, stringsAsFactors = FALSE)
    })
    
})
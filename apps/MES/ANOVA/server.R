source("global.R")
set.seed(NULL)
# ANOVA Server
shinyServer(function(input, output, session){
    output$random_parameter <- renderUI({
        validate(
            need(input$dataset, "Please select a dataset")
        )
        if (input$dataset == "fuel"){
            column(width = 12,
                   textInput("fuel_group_a", label = h5("Brand A (Group 1)"), value = "7.80, 8.20, 8.65, 8.00, 8.36"),
                   textInput("fuel_group_b", label = h5("Brand B (Group 2)"), value = "9.50, 10.21, 9.85, 10.02, 9.39"),
                   textInput("fuel_group_c", label = h5("Brand C (Group 3)"), value = "8.20, 8.87, 8.35, 9.03, 8.68"),
                   div(style = "font-size:15px;",actionButton("anovarun", label=("Run"), icon("paper-plane"), 
                                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4")))
        }
        else if (input$dataset == "temperature"){
            column(width = 12,
                   textInput("temp_group_a", label = ("80°C (Group 1)"), value = "254, 263, 241, 237, 251"),
                   textInput("temp_group_b", label = ("85°C (Group 2)"), value = "234, 218, 235, 227, 216"),
                   textInput("temp_group_c", label = ("90°C (Group 3)"), value = "200, 222, 197, 206, 204"),
                   div(style = "font-size:15px;",actionButton("anovarun", label=("Run"), icon("paper-plane"), 
                                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4")))
        }
        else if(input$dataset == "random"){
            fluidRow(
                column(width = 4,
                       div(id='anova_textinput_1', style = "font-size:15px;",numericInput("anova_size1", label=("size of grp. 1"), value=5, min=5, max=100, step = 1),
                           tags$style(type="text/css", "#anova_textinput_1 {color: #FF7F0E; font-weight: 500;}")),
                       div(id='anova_textinput_2', style = "font-size:15px;",numericInput("anova_size2", label=("size of grp. 2"), value=5, min=5, max=100, step = 1),
                           tags$style(type="text/css", "#anova_textinput_2 {color: #2CA02C; font-weight: 500;}")),
                       div(id='anova_textinput_3', style = "font-size:15px;",numericInput("anova_size3", label=("size of grp. 3"), value=5, min=5, max=100, step = 1),
                           tags$style(type="text/css", "#anova_textinput_3 {color: #D52728; font-weight: 500;}"))),
                column(width = 4, 
                       div(id='anova_textinput_1', style = "font-size:15px;",numericInput("anova_mu1", label=("mean of grp. 1"), value=1, min=0, max=10, step = 1)),
                       div(id='anova_textinput_2', style = "font-size:15px;",numericInput("anova_mu2", label=("mean of grp. 2"), value=2, min=0, max=10, step = 1)),
                       div(id='anova_textinput_3', style = "font-size:15px;",numericInput("anova_mu3", label=("mean of grp. 3"), value=3, min=0, max=10, step = 1))),
                column(width = 4,
                       div(id='anova_textinput_4', style = "font-size:15px;",numericInput("anova_sigma", label=("total sigma"), value=1, min=-10, max=10, step=0.01),
                           tags$style(type="text/css", "#anova_textinput_4 {font-weight: 500;}"))),
                hr(),
                column(width = 12,
                       div(style = "font-size:15px;",actionButton("anovarun", label=("Run"), icon("paper-plane"), 
                                                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))))
        }
        })
    
    rnorm1 = rnorm
    rnorm2 = rnorm
    rnorm3 = rnorm #repeatable(rnorm)
    
    gen_data = eventReactive(input$anovarun, {
        if (input$dataset == "fuel"){
            group_a <- as.vector(as.numeric(unlist(strsplit(input$fuel_group_a, ","))))
            group_b <- as.vector(as.numeric(unlist(strsplit(input$fuel_group_b, ","))))
            group_c <- as.vector(as.numeric(unlist(strsplit(input$fuel_group_c, ","))))
            y <- c(group_a, group_b, group_c)
            group <- c(rep(sprintf("class A"), each = length(group_a)),
                       rep(sprintf("class B"), each = length(group_b)),
                       rep(sprintf("class C"), each = length(group_c)))
            data.frame(datapoint = y, group = group)
        }
        
        else if (input$dataset == "temperature"){
            group_a <- as.vector(as.numeric(unlist(strsplit(input$temp_group_a, ","))))
            group_b <- as.vector(as.numeric(unlist(strsplit(input$temp_group_b, ","))))
            group_c <- as.vector(as.numeric(unlist(strsplit(input$temp_group_c, ","))))
            y <- c(group_a, group_b, group_c)
            group <- c(rep(sprintf("80°C"), each = length(group_a)),
                       rep(sprintf("85°C"), each = length(group_b)),
                       rep(sprintf("90°C"), each = length(group_c)))
            data.frame(datapoint = y, group = group)
        }
        
        else if (input$dataset == "random"){
            validate(
                need(input$anova_size1, "Please select a size of anova group 1"),
                need(input$anova_size2, "Please select a size of anova group 2"),
                need(input$anova_size3, "Please select a size of anova group 3"),
                need(input$anova_mu1, "Please select a mean of anova group 1"),
                need(input$anova_mu2, "Please select a mean of anova group 2"),
                need(input$anova_mu3, "Please select a mean of anova group 3"),
                need(input$anova_sigma, "Please select a sigma of anova")
            )
            if (input$data_generate == "random"){
                anova_size1 = input$anova_size1; anova_size2 = input$anova_size2; anova_size3 = input$anova_size3;
                anova_mu1 = input$anova_mu1; anova_mu2 = input$anova_mu2; anova_mu3 = input$anova_mu3; anova_sigma = input$anova_sigma;
                flag = TRUE
                while (flag == TRUE){
                    tmp_1 = rnorm1(anova_size1, anova_mu1, anova_sigma)
                    tmp_2 = rnorm2(anova_size2, anova_mu2, anova_sigma)
                    tmp_3 = rnorm3(anova_size3, anova_mu3, anova_sigma)
                    if (abs(mean(tmp_1) - anova_mu1) < 0.1 & 
                        abs(mean(tmp_2) - anova_mu2) < 0.1 & 
                        abs(mean(tmp_3) - anova_mu3) < 0.1){
                        flag <- FALSE
                    }
                }
                anova_data1 = tmp_1
                anova_data2 = tmp_2
                anova_data3 = tmp_3
                y = c(anova_data1, anova_data2, anova_data3)
                group = c(rep(sprintf("group %s", 1), each = anova_size1),
                          rep(sprintf("group %s", 2), each = anova_size2),
                          rep(sprintf("group %s", 3), each = anova_size3))
                data.frame(datapoint = y, group = group)}
            
            else if (input$data_generate == "rps"){
                anova_size1 = input$anova_size1; anova_size2 = input$anova_size2; anova_size3 = input$anova_size3;
                anova_mu1 = input$anova_mu1; anova_mu2 = input$anova_mu2; anova_mu3 = input$anova_mu3; anova_sigma = input$anova_sigma;
                tmp_1 <- revisedfm(n = anova_size1, mean = anova_mu1, sd = anova_sigma)
                tmp_1 <- tmp_1$par
                tmp_2 <- revisedfm(n = anova_size2, mean = anova_mu2, sd = anova_sigma)
                tmp_2 <- tmp_2$par
                tmp_3 <- revisedfm(n = anova_size3, mean = anova_mu3, sd = anova_sigma)
                tmp_3 <- tmp_3$par
                anova_data1 = tmp_1
                anova_data2 = tmp_2
                anova_data3 = tmp_3
                y = c(anova_data1, anova_data2, anova_data3)
                group = c(rep(sprintf("group %s", 1), each = anova_size1),
                          rep(sprintf("group %s", 2), each = anova_size2),
                          rep(sprintf("group %s", 3), each = anova_size3))
                data.frame(datapoint = y, group = group)}
            }
    })

    
    output$aovPlot = renderPlotly({
        if (input$aovplottype == "scatter"){
            cols <- c("#FF7F0E", "#2CA02C", "#D52728")
            means <- aggregate(datapoint ~ group, gen_data(), mean)
            ggplot(gen_data(), aes(y = group, x = datapoint, color = group)) + 
                geom_point(alpha=0.6, size = 2.5) +
                scale_color_manual(values = cols) +
                stat_summary(fun = mean, colour = "brown2", geom="point", shape=17, size = 3.0, show.legend=FALSE) +
                geom_text(data = means, aes(label = sprintf("mean: %0.3f", datapoint), x = datapoint + 0.08)) +  #fontface='bold'
                theme(legend.position="none", 
                      plot.title = element_text(size=12, hjust = 1.0), 
                      legend.text = element_text(size=30),
                      axis.text.x = element_text(size=12, hjust=1.0),
                      axis.text.y = element_text(size=12, hjust=1.0)) + coord_flip()}
        
        else if (input$aovplottype == "boxplot"){
            tmp_data = gen_data()
            means <- aggregate(datapoint ~ group, tmp_data, mean)
            tmp_data <- tmp_data %>% group_split(group)
            fig <- plot_ly(type = "box")
            fig <- fig %>% add_boxplot(y = tmp_data[[1]]$datapoint, type = "box", name = "Group 1", boxpoints = "suspectedoutliers", 
                                       marker = list(color = 'rgb(8,81,156)', outliercolor = 'rgba(219, 64, 82, 0.6)', 
                                                     line = list(outliercolor = 'rgba(219, 64, 82, 1.0)',
                                                                 outlierwidth = 2)), boxmean = T)
            fig <- fig %>% add_boxplot(y = tmp_data[[2]]$datapoint, type = "box", name = "Group 2", boxpoints = "suspectedoutliers", 
                                       marker = list(color = 'rgb(8,81,156)', outliercolor = 'rgba(219, 64, 82, 0.6)', 
                                                     line = list(outliercolor = 'rgba(219, 64, 82, 1.0)',
                                                                 outlierwidth = 2)), boxmean = T)
            fig <- fig %>% add_boxplot(y = tmp_data[[3]]$datapoint, type = "box", name = "Group 3", boxpoints = "suspectedoutliers", 
                                       marker = list(color = 'rgb(8,81,156)', outliercolor = 'rgba(219, 64, 82, 0.6)', 
                                                     line = list(outliercolor = 'rgba(219, 64, 82, 1.0)',
                                                                 outlierwidth = 2)), boxmean = T)
            return(fig)
        }
        
        # else if (input$aovplottype == "boxplot"){
        #     means <- aggregate(datapoint ~  group, gen_data(), mean)
        #     ggplot(gen_data(), aes(y=group, x=datapoint, fill=group)) + 
        #         geom_boxplot(alpha=0.6, width=0.3) +
        #         stat_summary(fun=mean, colour="brown2", geom="point", shape=17, size=3.0, show.legend=FALSE) + 
        #         geom_text(data = means, aes(label = sprintf("mean: %0.3f", datapoint), x = datapoint + 0.08)) + #, fontface='bold'
        #         theme(legend.position="none", 
        #               plot.title = element_text(size=12, hjust = 0.5), 
        #               legend.text = element_text(size=30),
        #               axis.text.x = element_text(size=12, hjust=0.5),
        #               axis.text.y = element_text(size=12, hjust=0.5)) + coord_flip() + 
        #         scale_fill_brewer(palette="Accent")}
    })
    
    output$aovdataSummary = renderDataTable({
        options(DT.options = list(pageLength = 5, scrollX=T, dom = 't'))
        anova_summary <- gen_data() %>% group_by(group) %>%
            dplyr::summarise(count = n(), 
                             mean = round(mean(datapoint, na.rm = TRUE), 3), 
                             sd = round(sd(datapoint, na.rm = TRUE), 3))
        return(datatable(anova_summary) %>% formatStyle(columns = c(1,2,3,4), fontSize="110%")) #, fontWeight="bold",
        })
    
    output$aovSummary = renderDataTable({
        validate(
            need(gen_data(), "Please run the program")
        )
        options(DT.options = list(pageLength = 5, scrollX=T, dom = 't'))
        anova_data <- round(as.data.frame(unclass(summary(aov(datapoint ~ group, data = gen_data()))), check.names = FALSE, stringsAsFactors = FALSE),3) 
        return(datatable(anova_data) %>% 
                   formatStyle(columns = c(1,2,3,4,5), fontSize="110%", color = "black") %>%
                   formatStyle(columns = c(5), fontSize="115%", color="red")) #, fontWeight="bold",
    })
    
    observeEvent(input$disconnect, {
        session$close()
    })
    
})
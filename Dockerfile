FROM bayes-cluster/wals-base:latest

# copy the frontend

ADD ./frontend/index.html /srv/shiny-server/
ADD ./frontend/mesocp.html /srv/shiny-server/
ADD ./frontend/simulation.html /srv/shiny-server/
ADD ./frontend/css/ /srv/shiny-server/css/
ADD ./frontend/js/ /srv/shiny-server/js/
ADD ./frontend/assets/ /srv/shiny-server/assets/
ADD ./frontend/fig/ /srv/shiny-server/fig/

RUN rm -rf /srv/shiny-server/0*

RUN R -e 'install.packages(c("shinyalert", "shinythemes"), dependencies=TRUE, repos="https://mirrors.bfsu.edu.cn/CRAN/")'

# copy the apps
ADD ./apps/ /srv/shiny-server/apps/

# solve permission problem
RUN chown -R shiny:shiny /srv/shiny-server

# run app
CMD ["/usr/bin/shiny-server"]
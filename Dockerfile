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

RUN R -e 'install.packages(c("shinyalert", "shinythemes"))'

# copy the apps
ADD ./apps/ /srv/shiny-server/apps/

# run app
CMD ["/usr/bin/shiny-server"]
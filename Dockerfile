FROM rocker/shiny:latest

LABEL org.opencontainers.image.documentation="Oct 08, 2022"
LABEL org.opencontainers.image.authors="Bayes Cluster Maintenance Group"
LABEL org.opencontainers.artifact.description="Bayes Cluster Base Image - MESOCP Dockerfile"
LABEL org.opencontainers.image.source https://github.com/Bayes-Cluster/MESOCP
LABEL org.opencontainers.image.documentation="https://github.com/Bayes-Cluster/MESOCP"
LABEL org.opencontainers.image.version="0.0.1"

# By default, we are using SUSTech mirrors
RUN sed -i s@/archive.ubuntu.com/@/mirrors.sustech.edu.cn/@g /etc/apt/sources.list
RUN sed -i s@/security.ubuntu.com/@/mirrors.sustech.edu.cn/@g /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libgdal-dev \
	libproj-dev \
	libgeos-dev \
	libudunits2-dev \
	netcdf-bin

RUN R -e 'install.packages(c(\
              "shiny", \
              "shinydashboard", \
              "ggplot2", \
              "knitr", \
              "bslib", \
              "plotly", \
              "leaflet", \
              "lubridate", \
              "scales", \
              "rgeos", \
              "tidyr", \
              "DT", \
              "dplyr", \
              "shinydisconnect", \
              "alabama" \
            ), dep=TRUE,\
            repos="http://mirrors.sustech.edu.cn/CRAN/"\
          )'


# copy the frontend

ADD ./frontend/index.html /srv/shiny-server/
ADD ./frontend/tools.html /srv/shiny-server/
ADD ./frontend/css/ /srv/shiny-server/css/
ADD ./frontend/js/ /srv/shiny-server/js/
ADD ./frontend/assets/ /srv/shiny-server/assets/
ADD ./frontend/fig/ /srv/shiny-server/fig/

# copy the apps
ADD ./apps/ /srv/shiny-server/MESOCP/

# run app
CMD ["/usr/bin/shiny-server"]
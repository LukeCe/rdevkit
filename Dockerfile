FROM rocker/geospatial:4.0.2

LABEL maintainer "Lukas Dargel <lukece@mailbox.org>"

# import settings & snippets
RUN wget https://raw.githubusercontent.com/LukeCe/rdevkit/master/build_resources/user-settings/user-settings-old -P /home/rstudio/.rstudio/monitored/user-settings/ \
    && wget --backups=1 https://raw.githubusercontent.com/LukeCe/rdevkit/master/build_resources/user-settings/user-settings  -P /home/rstudio/.rstudio/monitored/user-settings/ \
    && wget https://raw.githubusercontent.com/LukeCe/rdevkit/master/build_resources/snippets/r.snippets          -P /home/rstudio/.R/snippets/ \
    && wget https://raw.githubusercontent.com/LukeCe/rdevkit/master/build_resources/snippets/markdown.snippets   -P /home/rstudio/.R/snippets/ 

# install data version control
RUN sudo wget https://dvc.org/deb/dvc.list -O /etc/apt/sources.list.d/dvc.list \
    && sudo apt update \
    && sudo apt install dvc

# additional R packages
RUN install2.r --error \
    here \
    golem \
    leaflet.minicharts \
    shinythemes

# additional LaTeX packages
RUN   R -e 'tinytex::tlmgr("update --self")'\ 
    && R -e 'tinytex::tlmgr_install(c("amsmath", "atbegshi", "atveryend", "bigintcalc", "bitset", "booktabs", "colortbl", "environ", "epstopdf-pkg", "etexcmds", "etoolbox", "geometry", "gettitlestring", "hycolor", "hyperref", "infwarerr", "intcalc", "kvdefinekeys", "kvoptions", "kvsetkeys", "latex-amsmath-dev", "letltxmacro", "ltxcmds", "mdwtools", "pdfescape", "pdftexcmds", "refcount", "rerunfilecheck", "stringenc", "trimspaces", "uniquecounter", "xcolor", "zapfding"))'

# overwrtie default password
ENV PASSWORD=rdev_007

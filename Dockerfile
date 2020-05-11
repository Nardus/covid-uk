FROM ubuntu:latest
# Turn off interactive options for tzdata
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt upgrade
RUN apt install -y r-base
RUN R -e "install.packages(\"rlang\")"
RUN R -e "install.packages(\"stringr\")"
RUN R -e "install.packages(\"data.table\")"
RUN R -e "install.packages(\"ggplot2\")"
RUN R -e "install.packages(\"qs\")"
RUN R -e "install.packages(\"lubridate\")"
RUN R -e "install.packages(\"nloptr\")"
RUN R -e "install.packages(\"HDInterval\")"
RUN R -e "install.packages(\"cowplot\")"
RUN apt install libgsl-dev -y
RUN R -e "install.packages(\"RcppGSL\")"
RUN apt install libnlopt-dev -y
RUN adduser coviduk
RUN apt install git -y
RUN apt install vim emacs -y
RUN apt install python3-pip -y
USER coviduk
WORKDIR /home/coviduk
RUN pwd
# FIXME: Next two lines are temporary solution whilst testing in development
RUN git clone https://github.com/kzscisoft/covid-uk.git
WORKDIR /home/coviduk/covid-uk
RUN git checkout testing-dev
USER root
WORKDIR covid-uk
WORKDIR /home/coviduk/covid-uk
RUN ls -ltr
RUN pip3 install -r tests/requirements.txt
USER coviduk
WORKDIR /home/coviduk/covid-uk
RUN echo "alias run_coviduk='cd $PWD; Rscript UK.R \$1 \$2; cd -'" > ~/.bashrc
RUN cat ~/.bashrc
ENTRYPOINT ["/bin/bash"]

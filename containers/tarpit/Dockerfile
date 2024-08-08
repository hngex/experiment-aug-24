FROM ubuntu:noble

RUN apt-get -y update && \
    apt-get -y install net-tools telnet iputils-ping dnsutils git make build-essential libev-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/martinh/mxtarpit.git /usr/src/mxtarpit && \
    cd /usr/src/mxtarpit && \
    sed -i -e 's/app.spam_stutter_interval = 3/app.spam_stutter_interval = 0.25/' mxtarpit.c && \
    make linux && \
    mv ./mxtarpit /usr/sbin/mxtarpit && \
    mkdir /var/empty

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 25

ENTRYPOINT ["/start.sh"]

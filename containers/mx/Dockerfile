FROM ubuntu:noble

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install net-tools telnet iputils-ping dnsutils postfix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 25
CMD ["/start.sh"]

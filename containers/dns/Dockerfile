FROM coredns/coredns:latest

COPY Corefile /etc/coredns/Corefile
COPY db.* /etc/coredns/

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
CMD ["-conf", "/etc/coredns/Corefile"]

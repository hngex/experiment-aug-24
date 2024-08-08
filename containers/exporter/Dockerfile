FROM golang:latest

ENV GOFLAGS="-tags=nosystemd"
RUN go install github.com/kumina/postfix_exporter@latest

ENTRYPOINT ["postfix_exporter"]

CMD ["--web.listen-address=:9154", "--postfix.logfile_path=/var/log/postfix.log"]

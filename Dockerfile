FROM golang:1.12.0-stretch as build-env
WORKDIR /go/src/app
ADD . /go/src/app
RUN make build-golang \
 && go get -u github.com/tomnomnom/gron

FROM debian:9-slim
RUN apt-get update -q \
 && apt-get install -qy curl telnet netcat vim jq net-tools iputils-ping dnsutils less watch \
 && rm -rf /var/lib/apt/lists/* \
 && curl -LO "https://github.com/fullstorydev/grpcurl/releases/download/v1.0.0/grpcurl_1.0.0_linux_x86_64.tar.gz" \
 && tar xvf grpcurl_1.0.0_linux_x86_64.tar.gz \
 && mv grpcurl /usr/local/bin \
 && rm -f grpcurl_1.0.0_linux_x86_64.tar.gz \
 && curl -LO "https://github.com/fortio/fortio/releases/download/v1.14.1/fortio_1.14.1_amd64.deb" \
 && dpkg -i fortio_1.14.1_amd64.deb

COPY --from=build-env /go/src/app/pause /
COPY --from=build-env /go/bin/gron /usr/bin
CMD [ "/pause" ]

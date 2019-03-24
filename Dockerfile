FROM golang:1.12.0-stretch as build-env
WORKDIR /go/src/app
ADD . /go/src/app
RUN make build

FROM debian:9-slim
RUN apt-get update -q \
  && apt-get install -qy \
	 curl telnet netcat vim jq net-tools iputils-ping dnsutils \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -LO "https://github.com/fullstorydev/grpcurl/releases/download/v1.0.0/grpcurl_1.0.0_linux_x86_64.tar.gz" \
	&& tar xvf grpcurl_1.0.0_linux_x86_64.tar.gz \
	&& mv grpcurl /usr/local/bin \
	&& rm -f grpcurl_1.0.0_linux_x86_64.tar.gz

COPY --from=build-env /go/src/app/pause /
CMD [ "/pause" ]

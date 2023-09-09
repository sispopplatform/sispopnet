ARG bootstrap="https://i2p.rocks/i2procks.signed"
FROM alpine:edge as builder

RUN apk update && \
    apk add build-base cmake git libcap-dev libcap-static libuv-dev libuv-static curl ninja bash binutils-gold curl-dev

WORKDIR /src/
COPY . /src/

RUN make NINJA=ninja STATIC_LINK=ON BUILD_TYPE=Release DOWNLOAD_SODIUM=ON
RUN ./sispopnet-bootstrap ${bootstrap}

FROM alpine:latest

COPY sispopnet-docker.ini /root/.sispopnet/sispopnet.ini
COPY --from=builder /src/build/daemon/sispopnet .
COPY --from=builder /root/.sispopnet/bootstrap.signed /root/.sispopnet/

CMD ["./sispopnet"]
EXPOSE 1090/udp 1190/tcp

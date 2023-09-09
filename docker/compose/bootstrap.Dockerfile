FROM compose-base:latest

ENV SISPOPNET_NETID=docker

COPY ./docker/compose/bootstrap.ini /root/.sispopnet/sispopnet.ini

CMD ["/sispopnet"]
EXPOSE 1090/udp 1190/tcp

FROM compose-base:latest

COPY ./docker/compose/client.ini /root/.sispopnet/sispopnet.ini

CMD ["/sispopnet"]
EXPOSE 1090/udp 1190/tcp

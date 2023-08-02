FROM alpine:3.18 as build

WORKDIR /opt
RUN apk --no-cache --update add alpine-sdk boost-dev openssl-dev
RUN git clone https://github.com/akiroz/stunserver.git && cd stunserver && make

FROM alpine:3.18

WORKDIR /opt/stunserver
RUN apk --no-cache --update add libstdc++ openssl
COPY --from=build /opt/stunserver/stunclient /opt/stunserver/stunclient
COPY --from=build /opt/stunserver/stunserver /opt/stunserver/stunserver

ENTRYPOINT ["/opt/stunserver/stunserver"]

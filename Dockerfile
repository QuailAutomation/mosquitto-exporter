#FROM scratch

#COPY bin/mosquitto_exporter /mosquitto_exporter

#EXPOSE 9324

#ENTRYPOINT [ "/mosquitto_exporter" ]


# build stage
FROM arm32v7/golang AS build-env
ADD . /src
RUN cd /src && make build

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/mosquitto_exporter /app/

EXPOSE 9324

ENTRYPOINT ./mosquitto_exporter
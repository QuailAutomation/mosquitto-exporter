#FROM scratch

#COPY bin/mosquitto_exporter /mosquitto_exporter

#EXPOSE 9324

#ENTRYPOINT [ "/mosquitto_exporter" ]


# build stage
FROM arm32v7/golang:1.9.2 AS build-env
ADD . /src
RUN cd /src
WORKDIR /src
RUN go get -d -v
RUN  CGO_ENABLED=0 GOARCH=arm GOOS=linux go build -s -w  -o mosquitto_exporter 

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/mosquitto_exporter /app/

EXPOSE 9324

#ENTRYPOINT ./mosquitto_exporter

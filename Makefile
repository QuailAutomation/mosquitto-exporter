PKG_NAME:=github.com/QuailAutomation/mosquitto-exporter
BUILD_DIR:=bin
MOSQUITTO_EXPORTER_BINARY:=$(BUILD_DIR)/mosquitto_exporter
IMAGE := craigham/rpi-mosquitto-exporter
VERSION=0.2.0
LDFLAGS=-s -w -X main.Version=$(VERSION) -X main.GITCOMMIT=`git rev-parse --short HEAD`
CGO_ENABLED=0
GOARCH=arm
.PHONY: help
help:
	@echo
	@echo "Available targets:"
	@echo "  * build             - build the binary, output to $(ARC_BINARY)"
	@echo "  * linux             - build the binary, output to $(ARC_BINARY)"
	@echo "  * docker            - build docker image"

.PHONY: build
build:
	@mkdir -p $(BUILD_DIR)
	go build -o $(MOSQUITTO_EXPORTER_BINARY) -ldflags="$(LDFLAGS)" $(PKG_NAME)

linux: export GOOS=linux
linux: build

docker: linux
	docker build -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):$(VERSION)

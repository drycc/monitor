SHELL := /bin/bash

# all monitor components share/use the following targets/exports
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
DRYCC_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= drycc
PLATFORM ?= linux/amd64,linux/arm64

include ../includes.mk
include ../versioning.mk
include ../deploy.mk

TEST_ENV_PREFIX := podman run --rm -v ${CURDIR}:/bash -w /bash ${DEV_REGISTRY}/drycc/go-dev

build: podman-build
push: podman-push
deploy: check-kubectl podman-build podman-push install

podman-build:
	podman build --build-arg CODENAME=${CODENAME} -t ${IMAGE} rootfs
	podman tag ${IMAGE} ${MUTABLE_IMAGE}

podman-buildx:
	podman buildx build --build-arg CODENAME=${CODENAME} --platform ${PLATFORM} -t ${IMAGE} rootfs --push

clean: check-podman
	podman rmi $(IMAGE)
	
test: test-style

test-style:
	${TEST_ENV_PREFIX} shellcheck $(SHELL_SCRIPTS)

.PHONY: build push podman-build clean upgrade deploy test test-style

build-all:
	podman build --build-arg CODENAME=${CODENAME} -t ${DRYCC_REGISTRY}/${IMAGE_PREFIX}/grafana:${VERSION} ../grafana/rootfs
	podman build --build-arg CODENAME=${CODENAME} -t ${DRYCC_REGISTRY}/${IMAGE_PREFIX}/telegraf:${VERSION} ../telegraf/rootfs

push-all:
	podman push ${DRYCC_REGISTRY}/${IMAGE_PREFIX}/grafana:${VERSION}
	podman push ${DRYCC_REGISTRY}/${IMAGE_PREFIX}/telegraf:${VERSION}

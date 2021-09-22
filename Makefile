
include .env
export

SHELL := /bin/bash
IMAGE_VERSION = $(shell git rev-parse --short HEAD)

.PHONY: build release

build:
	docker buildx build \
		--load \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

release:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--push \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

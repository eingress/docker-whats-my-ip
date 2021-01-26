
include .env
export

SHELL := /bin/bash
IMAGE_VERSION = $(shell git rev-parse --short HEAD)

.PHONY: build push release

build:
	docker build \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

push:
	docker push $$IMAGE_NAME:$$IMAGE_VERSION
	docker push $$IMAGE_NAME:latest

release: build push


ARG GO_IMAGE_VERSION

FROM golang:${GO_IMAGE_VERSION:-alpine} AS builder

LABEL maintainer="Scott Mathieson <scott@eingress.io>"

RUN mkdir /build

ADD *.go /build/

WORKDIR /build

RUN go mod init eingress.io/m/v2
RUN go env -w CGO_ENABLED=0 && go build -a -o main

FROM scratch

WORKDIR /

COPY --from=builder /build/main .

EXPOSE 10101

ENTRYPOINT ["/main"]
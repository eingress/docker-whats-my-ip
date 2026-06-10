
ARG GO_IMAGE_VERSION

FROM golang:${GO_IMAGE_VERSION:-alpine} AS builder

LABEL maintainer="Scott Mathieson <scott@eingress.io>"

RUN mkdir /build

COPY *.go /build/
COPY go.mod /build/
COPY cmd/ /build/cmd/

WORKDIR /build

RUN go env -w CGO_ENABLED=0 && \
    go build -a -o main . && \
    go build -a -o healthcheck ./cmd/healthcheck/

FROM scratch

WORKDIR /

COPY --from=builder /build/main .
COPY --from=builder /build/healthcheck .

EXPOSE 10101

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD ["/healthcheck"]

ENTRYPOINT ["/main"]
FROM golang:1.17-alpine as builder

RUN mkdir /build

ADD *.go /build/

WORKDIR /build

RUN go env -w GO111MODULE=auto
RUN go get -d -v
RUN go env -w CGO_ENABLED=0 && go build -a -o main



FROM scratch

WORKDIR /

COPY --from=builder /build/main .

EXPOSE 10101

ENTRYPOINT ["/main"]

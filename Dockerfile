FROM golang:alpine as builder

RUN mkdir /build

ADD *.go /build/

WORKDIR /build

RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -o main



FROM scratch

WORKDIR /

COPY --from=builder /build/main .

EXPOSE 10101

ENTRYPOINT ["/main"]

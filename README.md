# Docker What's My IP

A simple ip echo service that runs behind Cloudflare proxy.

## Usage

```sh
docker run -d -p 0.0.0.0:10101:10101 eingressio/whats-my-ip
```

The IP echo service is now available at [http//:0.0.0.0:10101](http://0.0.0.0:10101).

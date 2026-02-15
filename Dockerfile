FROM alpine:latest

RUN apk add --no-cache bash wget unzip curl

RUN wget https://github.com/v2fly/v2ray-core/releases/download/v5.7.0/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && \
    chmod +x v2ray

COPY config.json .

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

CMD ["./v2ray", "run", "-config", "config.json"]

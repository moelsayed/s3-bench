FROM python:alpine3.16
WORKDIR /
RUN apk update && apk add zstd mysql-client mariadb-connector-c && pip install csvkit \
    && wget https://github.com/minio/warp/releases/download/v0.6.5/warp_0.6.5_Linux_x86_64.tar.gz \
    && tar zxvf warp_0.6.5_Linux_x86_64.tar.gz \
    && mv warp /usr/local/bin

COPY bench.sh .
COPY table.sql .

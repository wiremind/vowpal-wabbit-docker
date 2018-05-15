FROM alpine:3.7
MAINTAINER Cedric de Saint Martin, cdesaintmartin@wiremind.fr
WORKDIR /app
RUN apk add --no-cache --virtual build-deps build-base git python3-dev boost-dev zlib-dev && \
    git clone --depth 1 --branch master --single-branch \
    git://github.com/JohnLangford/vowpal_wabbit.git /app/build && \
    cd /app/build && make && make install &&\
    cd / && \
    apk del build-deps && \
    rm -rf /var/cache/apk/* && rm -rf /app/build && \
    apk --no-cache add --virtual run-deps boost-program_options zlib libstdc++

COPY vw-wrapper.sh .

RUN mkdir ./saved-data

EXPOSE 26542
ENTRYPOINT ["/app/vw-wrapper.sh"]


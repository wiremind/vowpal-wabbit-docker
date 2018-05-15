FROM alpine:3.7
MAINTAINER Cedric de Saint Martin, cdesaintmartin@wiremind.fr
WORKDIR /app
RUN apk add --no-cache --virtual build-deps autoconf automake build-base git libtool m4 python3-dev boost-dev zlib-dev && \
    git clone --depth 1 --branch 8.5.0 --single-branch \
    git://github.com/JohnLangford/vowpal_wabbit.git /app/build && \
    cd /app/build && ./autogen.sh && make && make install &&\
    cd / && \
    apk del build-deps && \
    rm -rf /var/cache/apk/* && rm -rf /app/build && \
    apk --no-cache add --virtual run-deps boost-program_options zlib libstdc++

COPY vw-wrapper.sh .

RUN mkdir ./saved-data

EXPOSE 26542
ENTRYPOINT ["/app/vw-wrapper.sh"]


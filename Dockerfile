FROM php:7.1-cli-alpine

RUN apk add --no-cache $PHPIZE_DEPS libevent-dev && \
    docker-php-ext-install sockets pcntl

RUN printf "no\nyes\n/usr\nno\nyes\nno\n\no" | pecl install event

FROM php:7.1-cli-alpine
RUN apk add --update --no-cache libevent

COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20160303/event.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303
COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20160303/pcntl.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303
COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20160303/sockets.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303

COPY 99-php.ini /usr/local/etc/php/conf.d/99-php.ini

CMD ["/usr/local/bin/php", "-i"]

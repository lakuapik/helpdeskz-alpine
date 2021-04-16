FROM alpine:latest

MAINTAINER David Adi Nugroho <davidadi216@gmail.com>

ARG HELPDESKZ_VERSION=2.0.2

WORKDIR /var/www/html

LABEL org.label-schema.name="helpdeskz-alpine" \
    org.label-schema.vendor="lakuapik" \
    org.label-schema.description="HelpdeskZ image built on Alpine Linux" \
    org.label-schema.vcs-url="https://github.com/lakuapik/helpdeskz-alpine" \
    org.label-schema.license="MIT"

RUN wget -c https://github.com/helpdesk-z/helpdeskz-dev/archive/refs/tags/${HELPDESKZ_VERSION}.zip \
         -O /tmp/helpdeskz.zip \
    && unzip /tmp/helpdeskz.zip -d /tmp \
    && mv /tmp/helpdeskz-dev-${HELPDESKZ_VERSION}/* /var/www/html/ \
    && rm -rf /tmp/helpdeskz*

RUN apk --no-cache add \
    nginx \
    php7 \
    php7-cli \
    php7-common \
    php7-ctype \
    php7-fileinfo \
    php7-fpm \
    php7-intl \
    php7-iconv \
    php7-imap \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-session

COPY nginx.default.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
    && sed -i 's/user nginx;/user root;/g' /etc/nginx/nginx.conf \
    && mkdir -p /run/nginx \
    && touch /run/nginx/nginx.pid \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY entrypoint.sh /entrypoint.sh

EXPOSE 80

CMD ["sh", "/entrypoint.sh"]

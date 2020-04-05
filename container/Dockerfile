FROM alpine:3.11

# Image meta data
MAINTAINER Yasuo Ohno <yasuo.ohno@gmail.com>
ENV LAST_UPDATE=2020-04-04

# Module versions
ENV TRAC_VERSION=1.4.1
ENV JINJA2_VERSION=2.11.1
ENV BABEL_VERSION=2.8.0
ENV DOCUTILS_VERSION=0.16
ENV PYGMENTS_VERSION=2.5.2
ENV TEXTILE_VERSION=3.0.4
ENV PYTZ_VERSION=2019.3
ENV SETUPTOOLS_VERSION=42.0.2
ENV WSGI_VERSION=4.7.1

# Default values
ENV SERVER_NAME trac.local
ENV REALM_NAME trac
ENV ADMIN_NAME admin
ENV ADMIN_PASSWD pa55w0rd
ENV PROJECT_NAME project
ENV TRAC_DATA /trac
ENV DB_LINK sqlite:db/trac.db

# install Trac and git
RUN apk add apache2 apache2-utils apache2-dev gcc musl-dev git
RUN apk add python2 py2-pip python2-dev
RUN pip install \
    mod-wsgi~=$WSGI_VERSION \
    Jinja2~=$JINJA2_VERSION \
    Babel~=$BABEL_VERSION \
    docutils~=$DOCUTILS_VERSION \
    Pygments~=$PYGMENTS_VERSION \
    Textile~=$TEXTILE_VERSION \
    pytz~=$PYTZ_VERSION
RUN pip install Trac~=$TRAC_VERSION
RUN mkdir -p $TRAC_DATA && chown apache:apache $TRAC_DATA

COPY ./trac.conf /
COPY ./entrypoint.sh /
COPY ./add_htdigest.sh /
COPY ./chg_htdigest.sh /

VOLUME ["/trac"]
EXPOSE 8080

ENTRYPOINT ["/bin/ash", "/entrypoint.sh"]

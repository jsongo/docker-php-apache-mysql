FROM debian:jessie
MAINTAINER jsongo <jsongo@qq.com>

RUN apt-get update && apt-get -y install apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

RUN apt-get update && apt-get -y install php5 php5-mysql && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork proxy_http rewrite vhost_alias

# other libs
RUN apt-get update && apt-get install -y php5-curl
EXPOSE 8008

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


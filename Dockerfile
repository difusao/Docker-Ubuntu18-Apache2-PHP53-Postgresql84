FROM ubuntu:18.04

LABEL maintainer="Geovani JM <difusao@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y mc
RUN apt-get install -y wget
RUN apt-get install -y gnupg2
RUN apt-get install -y dos2unix

# # Instalação o Apache2.
RUN apt-get install -y
RUN apt-get install -y build-essential
RUN apt-get install -y libxml2-dev
RUN apt-get install -y checkinstall

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:sergey-dryabzhinsky/php53
RUN add-apt-repository -y ppa:sergey-dryabzhinsky/packages

RUN apt-get install -y apache2
RUN apt-get install -y apache2-dev

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf
RUN rm /var/www/html/index.html
RUN mkdir -p /var/www/samplesite

# # Copia configuração personalizada.
COPY conf_apache/001-samplesite.conf /etc/apache2/sites-enabled/001-samplesite.conf
COPY conf_php/info.php /var/www/html/
COPY conf_php/test_postgresql.php /var/www/html/

# # Formato do arquivo DOS para Linux.
RUN dos2unix /etc/apache2/sites-enabled/001-samplesite.conf
RUN dos2unix /var/www/html/info.php
RUN dos2unix /var/www/html/test_postgresql.php

RUN apt-get install -y libxml2-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y libxpm-dev
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y libpq-dev
RUN apt-get install -y libicu-dev
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libldap2-dev
RUN apt-get install -y libxslt-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libldb-dev

RUN apt-get install -y libapache2-mod-php53
RUN apt-get install -y php53-cli
RUN apt-get install -y php53-mod-simplexml
RUN apt-get install -y php53p-mod-simplexml
RUN apt-get install -y php53-mod-json
RUN apt-get install -y php53p-mod-json
RUN apt-get install -y php53-common
RUN apt-get install -y php53-mod-openssl
RUN apt-get install -y php53-mod-pgsql
RUN apt-get install -y php53p-mod-pgsql

RUN rm -rf /etc/php53/cli/conf.d /etc/php53/apache2/conf.d
RUN ln -s /etc/php53/conf.d /etc/php53/cli/conf.d
RUN ln -s /etc/php53/conf.d /etc/php53/apache2/conf.d
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork
RUN a2enmod rewrite php53

# # Instalação do Postgresql 8.4.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update

RUN apt-get -qq update && LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-8.4 libpq-dev
RUN apt-get install -y sudo

RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

# # Backup de configuração.
RUN mv /etc/postgresql/8.4/main/postgresql.conf /etc/postgresql/8.4/main/postgresql.conf_bkp
RUN mv /etc/postgresql/8.4/main/pg_hba.conf /etc/postgresql/8.4/main/pg_hba.conf_bkp

# # Copia configuração personalizada.
COPY conf_postgresql/postgresql.conf /etc/postgresql/8.4/main/postgresql.conf
COPY conf_postgresql/pg_hba.conf /etc/postgresql/8.4/main/pg_hba.conf
COPY conf_postgresql/init-postgresql.sh /usr/local/bin/init-postgresql.sh

# # Formato do arquivo DOS para Linux.
RUN dos2unix /etc/postgresql/8.4/main/postgresql.conf
RUN dos2unix /etc/postgresql/8.4/main/pg_hba.conf
RUN dos2unix /usr/local/bin/init-postgresql.sh

RUN chown postgres:postgres /etc/postgresql/8.4/main/*.conf
RUN chmod +x /usr/local/bin/init-postgresql.sh

CMD ["/usr/local/bin/init-postgresql.sh"]

EXPOSE 80
EXPOSE 5432
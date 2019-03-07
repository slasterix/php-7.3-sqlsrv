FROM slasterix/docker-ubuntu-apache-php7.3

ENV ACCEPT_EULA=Y

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.3 php7.3-dev php7.3-xml --allow-unauthenticated
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools
RUN apt-get install -y unixodbc-dev

RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN cd /etc/php/7.3/mods-available
RUN touch 30-pdo_sqlsrv.ini
RUN touch 20-sqlsrv.ini
RUN echo extension=pdo_sqlsrv.so >> 30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> 20-sqlsrv.ini

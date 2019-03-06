FROM slasterix/docker-ubuntu-apache-php7.3

ENV ACCEPT_EULA=Y

RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2017.list | sudo tee /etc/apt/sources.list.d/mssql-server-2017.list

RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update
RUN apt-get install php7.3 php7.3-dev php7.3-xml -y --allow-unauthenticated


RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17 mssql-tools
RUN 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN source ~/.bashrc
RUN apt-get install unixodbc-dev

RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

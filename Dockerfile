FROM slasterix/docker-ubuntu-apache-php7.3

ENV ACCEPT_EULA=Y

RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2017.list | sudo tee /etc/apt/sources.list.d/mssql-server-2017.list

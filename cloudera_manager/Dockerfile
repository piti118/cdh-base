from piti118/cdh-base:latest


RUN echo "mariadb-server mysql-server/root_password password strangehat" | debconf-set-selections && \
    echo "mariadb-server mysql-server/root_password_again password strangehat" | debconf-set-selections && \
    apt-get install -y mariadb-server
RUN apt-get install -y cloudera-manager-daemons cloudera-manager-server
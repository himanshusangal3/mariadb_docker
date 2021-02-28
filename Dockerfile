#
# MariaDB Dockerfile
#
# https://github.com/dockerfile/mariadb
#

# Pull base image.
FROM ubuntu

# Install MariaDB.
RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y gnupg2 && \
  apt-get install -y lsb-release && \
  apt-get install -y netcat && \
  apt-get clean all && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
  echo "deb http://mariadb.mirror.iweb.com/repo/10.0/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/mariadb.list && \
  apt-get install -y mariadb-server && \
  rm -rf /var/lib/apt/lists/* && \
  sed -e 's/^datadir\t.*$/datadir = \/data/' -i /etc/mysql/my.cnf && \
  sed -e '/bind-address/ s/^#*/#/' -i /etc/mysql/mariadb.conf.d/50-server.cnf && \
  sed -i '19 s/^##*//' -i /etc/mysql/mariadb.conf.d/50-server.cnf && \
  sed '/bind-address/ a skip-networking=0' -i /etc/mysql/mariadb.conf.d/50-server.cnf && \
  sed '/skip-networking/ a skip-bind-address' -i /etc/mysql/mariadb.conf.d/50-server.cnf && \
  cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

# Define working directory.
WORKDIR /data

# Command to run
ENTRYPOINT ["/scripts/run.sh"]

CMD [""]

# Define default command.
#CMD ["mysqld_safe"]

# Expose ports.
EXPOSE 3306

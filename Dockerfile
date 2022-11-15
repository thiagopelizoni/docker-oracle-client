FROM ubuntu:20.04

# Date configurations
ENV TZ "America/Sao_Paulo"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y --no-install-recommends vim alien mlocate libpq-dev zlib1g-dev build-essential shared-mime-info libaio1 libaio-dev unzip wget

# Installing Oracle Client
RUN wget --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm
RUN wget --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm
RUN wget --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-sqlplus-18.5.0.0.0-3.x86_64.rpm
RUN alien -i oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm
RUN alien -i oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm
RUN alien -i oracle-instantclient18.5-sqlplus-18.5.0.0.0-3.x86_64.rpm
RUN updatedb

# Cleaning Oracle Client RPM files
RUN rm -rf *.rpm

# Configuring Oracle Client
ENV ORACLE_HOME /usr/lib/oracle/18.5/client64/lib
ENV LD_LIBRARY_PATH $ORACLE_HOME
ENV TNS_ADMIN "$ORACLE_HOME/network/admin"
ENV NLS_LANG "PORTUGUESE_BRAZIL.WE8MSWIN1252"

RUN echo $ORACLE_HOME >> /etc/ld.so.conf
RUN ldconfig

WORKDIR /usr/lib/oracle/18.5/
COPY tnsnames.ora ./client64/lib/network/admin/

EXPOSE 1521

CMD ["bash"]

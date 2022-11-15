FROM ubuntu:20.04

# Set the timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update --no-cache && \
    apt-get install -y --no-install-recommends vim alien mlocate libpq-dev zlib1g-dev build-essential shared-mime-info libaio1 libaio-dev unzip wget && \
    rm -rf /var/lib/apt/lists/*

# Copy Oracle Client RPM files from host to Docker image
COPY *.rpm /tmp/

# Install Oracle Client
RUN cd /tmp && \
    alien -i *.rpm && \
    rm -rf *.rpm && \
    updatedb

# Set Oracle Client environment variables
ENV ORACLE_HOME=/usr/lib/oracle/18.5/client64/lib
ENV LD_LIBRARY_PATH=$ORACLE_HOME
ENV TNS_ADMIN=$ORACLE_HOME/network/admin
ENV NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

# Configure Oracle Client
RUN echo $ORACLE_HOME >> /etc/ld.so.conf && ldconfig

# Copy tnsnames.ora file
COPY tnsnames.ora $ORACLE_HOME/network/admin/

# Expose port 1521
EXPOSE 1521

# Set the working directory
WORKDIR /usr/lib/oracle/18.5/

# Run bash when the container launches
CMD ["bash"]

# Oracle Instant Client 18.5 on Ubuntu 20:04 Docker image

First of all, before running the commands below, fill the tnsnames.ora using your own string connection in order to make this image works properly

# Creating image

```
docker build -t oracle-client:latest .
```

# Running

```
docker run -it oracle-client:latest bash
```

# Connecting to Oracle Database

Once inside the container, you can execute:

```
sqlplus64 your_login/your_password@service_name
```

If your tnsnames.ora and credentials were correct, you're going to see something like this:

```
SQL*Plus: Release 18.0.0.0.0 - Production on Ter Nov 15 08:31:55 2022
Version 18.5.0.0.0

Copyright (c) 1982, 2018, Oracle.  All rights reserved.

Ligado a:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
With the Real Application Clusters option

SQL>
```
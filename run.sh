#!/bin/bash

   sudo systemctl stop apache2

   # Stop and remove any existing container with the same name
   docker stop my-apache 2>/dev/null
   docker rm my-apache 2>/dev/null

   # Run the Docker container with volume mapping
   docker run -d -p 8080:80 \
     -v $(pwd)/httpd.conf:/usr/local/apache2/conf/httpd.conf \
     -v $(pwd)/htdocs:/usr/local/apache2/htdocs \
     --name my-apache htaccess_test

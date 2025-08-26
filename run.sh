#!/bin/bash

   sudo systemctl stop apache2

   # Stop and remove any existing container with the same name
   docker stop my-apache 2>/dev/null
   docker rm my-apache 2>/dev/null

   # Run the Docker container with volume mapping for both HTTP and HTTPS
   docker run -d -p 80:80 -p 443:443 \
     -v $(pwd)/httpd.conf:/usr/local/apache2/conf/httpd.conf \
     -v $(pwd)/htdocs:/usr/local/apache2/htdocs \
     -v $(pwd)/aiao:/usr/local/apache2/htdocs/aiao \
     -v $(pwd)/claimont:/usr/local/apache2/htdocs/claimont \
     -v $(pwd)/impactont:/usr/local/apache2/htdocs/impactont \
     -v $(pwd)/infocomm:/usr/local/apache2/htdocs/infocomm \
     -v /etc/letsencrypt:/etc/letsencrypt:ro \
     --name my-apache htaccess_test

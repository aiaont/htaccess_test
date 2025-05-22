FROM httpd:2.4

# Install vim for editing files inside the container (optional)
RUN apt-get update && apt-get install -y vim

# Copy custom Apache configuration to enable .htaccess
#COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy web files (including .htaccess) to the document root
#COPY htdocs/ /usr/local/apache2/htdocs/

# Ensure mod_rewrite is enabled by appending to httpd.conf
#RUN echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.confFROM httpd:2.4

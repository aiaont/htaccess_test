FROM httpd:2.4

# Install vim for editing files inside the container (optional)
RUN apt-get update && apt-get install -y vim

# Copy custom Apache configuration to enable .htaccess
#COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy web files (including .htaccess) to the document root
#COPY htdocs/ /usr/local/apache2/htdocs/

# Ensure mod_rewrite and mod_ssl are enabled
RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule proxy_connect_module modules/mod_proxy_connect.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule ssl_module modules/mod_ssl.so" >> /usr/local/apache2/conf/httpd.conf && \
    sed -i '/<Directory "\/usr\/local\/apache2\/htdocs">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /usr/local/apache2/conf/httpd.conf


CMD ["httpd-foreground"]

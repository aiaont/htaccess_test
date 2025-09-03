# htaccess_test

Docker-based testing environment for `.htaccess` content negotiation rules for ontology/RDF resources.

## Overview

This repository provides a complete testing setup for Apache `.htaccess` content negotiation configurations for multiple ontologies:

- **AIAO** (AI Application Ontology)
- **Claimont** (Claimont Ontology)
- **ImpactOnt** (Impact Ontology)
- **InfoComm** (Information Communication Ontology)

Each ontology has its own `.htaccess` file that implements W3C best practices for content negotiation, serving different formats (HTML, JSON-LD, Turtle, RDF/XML) based on HTTP Accept headers.

## Prerequisites

- Docker installed
- SSL certificates (Let's Encrypt recommended)
- Domain name pointing to your server

## Quick Start

### 1. Clone and Setup

```bash
git clone https://github.com/aiaont/htaccess_test.git
cd htaccess_test
```

### 2. Get SSL Certificates (if not already done)

```bash
sudo apt update
sudo apt install certbot
sudo certbot certonly --standalone -d yourdomain.com
```

### 3. Build and Run

```bash
# Build the Docker image
docker build -t htaccess_test .

# Start the server
./run.sh
```

### 4. Stop the Server

```bash
./stop.sh
```

## Testing Content Negotiation

### Test All Ontologies

Each ontology is available at its own path and supports content negotiation:

#### AIAO Ontology (`/aiao`)

```bash
# JSON-LD format
curl -L -H "Accept: application/ld+json" https://yourdomain.com/aiao

# Turtle format
curl -L -H "Accept: text/turtle" https://yourdomain.com/aiao

# RDF/XML format
curl -L -H "Accept: application/rdf+xml" https://yourdomain.com/aiao

# HTML format (documentation)
curl -L -H "Accept: text/html" https://yourdomain.com/aiao
```

#### Claimont Ontology (`/claimont`)

```bash
# JSON-LD format
curl -L -H "Accept: application/ld+json" https://yourdomain.com/claimont

# Turtle format
curl -L -H "Accept: text/turtle" https://yourdomain.com/claimont

# HTML format
curl -L -H "Accept: text/html" https://yourdomain.com/claimont
```

#### Impact Ontology (`/impactont`)

```bash
# JSON-LD format
curl -L -H "Accept: application/ld+json" https://yourdomain.com/impactont

# Turtle format
curl -L -H "Accept: text/turtle" https://yourdomain.com/impactont

# HTML format
curl -L -H "Accept: text/html" https://yourdomain.com/impactont
```

#### InfoComm Ontology (`/infocomm`)

```bash
# JSON-LD format
curl -L -H "Accept: application/ld+json" https://yourdomain.com/infocomm

# Turtle format
curl -L -H "Accept: text/turtle" https://yourdomain.com/infocomm

# HTML format
curl -L -H "Accept: text/html" https://yourdomain.com/infocomm
```

### Test Versioned URLs

Each ontology supports versioned URLs (replace `v1.0.0` with actual version):

```bash
# Test versioned AIAO
curl -L -H "Accept: application/ld+json" https://yourdomain.com/aiao/v1.0.0/

# Test versioned Claimont
curl -L -H "Accept: text/turtle" https://yourdomain.com/claimont/v1.0.0/
```

### Browser Testing

Open your browser and visit:

- `https://yourdomain.com/aiao` - Should redirect to HTML documentation
- `https://yourdomain.com/claimont` - Should redirect to HTML documentation
- `https://yourdomain.com/impactont` - Should redirect to HTML documentation
- `https://yourdomain.com/infocomm` - Should redirect to HTML documentation

## Debugging

### Check Container Status

```bash
docker ps
```

### Check Apache Logs

```bash
docker logs my-apache
```

### Check Directory Structure

```bash
docker exec my-apache ls -la /usr/local/apache2/htdocs/
```

### Verify SSL Certificates

```bash
docker exec my-apache ls -la /etc/letsencrypt/live/yourdomain.com/
```

### Test Without Following Redirects

```bash
# See the actual redirect response
curl -I -H "Accept: application/ld+json" https://yourdomain.com/aiao
```

## File Structure

```text
.
├── Dockerfile              # Apache container with SSL and mod_rewrite
├── httpd.conf              # Apache configuration with SSL
├── run.sh                  # Main startup script
├── stop.sh                 # Stop script
├── htdocs/                 # Main document root
│   ├── .htaccess           # Main AIAO rules
│   └── index.html          # Test page
├── aiao/                   # AIAO ontology rules
│   └── .htaccess
├── claimont/               # Claimont ontology rules
│   └── .htaccess
├── impactont/              # Impact ontology rules
│   └── .htaccess
└── infocomm/               # InfoComm ontology rules
    └── .htaccess
```

## How It Works

1. **Docker Container**: Runs Apache with SSL, mod_rewrite, and mod_proxy enabled
2. **Volume Mapping**: Maps each ontology directory to `/usr/local/apache2/htdocs/{ontology}/`
3. **SSL Termination**: Uses Let's Encrypt certificates for HTTPS
4. **Content Negotiation**: Each `.htaccess` file handles Accept headers and redirects to appropriate CDN resources
5. **Versioning**: Supports version-specific URLs with regex pattern matching

## Ontology-Specific Scripts

For testing individual ontologies in isolation:

```bash
# Test only Claimont
./run_claimont.sh

# Test only ImpactOnt  
./run_impactont.sh

# Test only InfoComm
./run_infocomm.sh
```

## Production Deployment

This setup is suitable for production use. The `.htaccess` files redirect to CDN resources (jsdelivr.net) for actual content delivery, making this a lightweight content negotiation proxy.

## Troubleshooting

### Common Issues

1. **SSL Certificate Errors**: Ensure certificates are properly generated and mounted
2. **404 Errors**: Check that directories are properly mounted in Docker container
3. **Redirect Loops**: Verify `.htaccess` syntax and Apache configuration
4. **Permission Errors**: Ensure Docker has read access to SSL certificates

### Support

For issues related to specific ontology `.htaccess` configurations, please refer to the individual ontology repositories.

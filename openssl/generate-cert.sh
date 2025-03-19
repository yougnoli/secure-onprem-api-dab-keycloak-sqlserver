#!/bin/bash

openssl req -x509 -newkey rsa:4096 -keyout keycloak.key -out keycloak.crt -days 365 -nodes -subj "/CN=localhost"

mkdir -p ../keycloak/certs
mv keycloak.crt ../keycloak/certs/
mv keycloak.key ../keycloak/certs/

echo "Self-signed certificate generated and moved to keycloak/certs/"

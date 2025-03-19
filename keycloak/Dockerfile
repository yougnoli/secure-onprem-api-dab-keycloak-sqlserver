FROM quay.io/keycloak/keycloak:latest

COPY certs/keycloak.crt /etc/x509/https/tls.crt
COPY certs/keycloak.key /etc/x509/https/tls.key

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--https-certificate-file=/etc/x509/https/tls.crt", "--https-certificate-key-file=/etc/x509/https/tls.key", "--hostname-strict=false"]

# Secure On-Premises API with Data API Builder, Keycloak, and SQL Server

This repository contains all the configuration files, SQL scripts, and Docker setup to implement a secure on-premises API using:

- **Data API Builder (DAB)**
- **Keycloak**
- **SQL Server**

The setup includes Role-Based Access Control (RBAC), Attribute-Based Access Control (ABAC), and Row-Level Security (RLS), providing a scalable, secure solution without cloud dependencies.

---

## Requirements

- Windows Machine with .NET 8 installed
- Docker
- SQL Server (can be local or Docker-based)

---

## Folder Structure

```
secure-onprem-api-dab-keycloak-sqlserver/
├── README.md
├── dab-config.json
├── .env.example
├── sql/
│   └── setup.sql
├── keycloak/
│   ├── Dockerfile
│   └── certs/
│       ├── keycloak.crt
│       └── keycloak.key
└── openssl/
    └── generate-cert.sh
```

---

## Quick Start Guide

### 1. SQL Server Setup

Run the SQL script to create database, users, table, insert data, and configure Row-Level Security:

```bash
# Inside sql/ directory
sqlcmd -S localhost -U sa -P YOUR_PASSWORD -i setup.sql
```

---

### 2. Generate SSL Certificates (Optional)

If you want to regenerate your self-signed certificate, use:

```bash
cd openssl/
bash generate-cert.sh
```

---

### 3. Build and Run Keycloak with HTTPS

```bash
cd keycloak/
docker build -t keycloak-https .
docker run -d --name keycloak-https -p 8443:8443 keycloak-https
```

---

### 4. Configure Keycloak

Follow the steps in the article to:
- Create Realm
- Disable required actions
- Create roles, attributes
- Create users: Oscar & Hannah
- Configure Client & Scopes

---

### 5. Configure Data API Builder (DAB)

Edit `.env.example` with your connection string and rename to `.env`:

```bash
cp .env.example .env
```

Start DAB:

```bash
dab start
```

---

### 6. Testing

Use Postman to:
1. Obtain JWT token from Keycloak.
2. Query DAB API with the token.

Example:

```
GET https://localhost:5001/api/Orders
Headers:
Authorization: Bearer <your_token>
X-MS-API-ROLE: reader
```

---

## Credits

Article & Implementation: [Alessio Tugnoli](https://medium.com/@alessiotugnoli)

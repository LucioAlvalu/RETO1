# RETO 1 - CTIN: Arquitectura de Microservicios CRUD con API Gateway y Frontend

## Descripción del reto
Este proyecto consiste en el diseño, contenerización, despliegue y documentación de un sistema desacoplado en microservicios para la gestión de **Startups** y **Tecnologías**. El sistema implementa las operaciones fundamentales de un CRUD por medio de endpoints independientes, coordinados a través de un **API Gateway** centralizado hecho en Nginx y consumidos por un cliente web moderno.

## Objetivo de la solución
El objetivo principal es entregar un entorno distribuido, reproducible y libre de dependencias complejas de infraestructura local mediante **Docker Compose**. 
- **Qué resuelve:** Permite la administración integral de registros de empresas emergentes y stacks tecnológicos en una arquitectura desacoplada.
- **Qué incluye:** 8 microservicios backend (Node.js/Express), 1 API Gateway (Nginx), 1 base de datos relacional compartida (PostgreSQL) con persistencia vía volúmenes y un cliente Web (React/Vite) servido de forma estática.
- **Qué queda fuera:** Capas avanzadas de autenticación OAuth/JWT, orquestadores de alta disponibilidad en producción (Kubernetes/Swarm) y sistemas de mensajería asíncrona (RabbitMQ/Kafka).

## Arquitectura
La arquitectura sigue un enfoque modular HTTP síncrono en red interna aislada. Todo el tráfico externo del cliente o herramientas de API ingresa por el puerto `8080` a través del Gateway Nginx, el cual enruta la petición hacia los microservicios correspondientes y estos a su vez consultan la instancia de PostgreSQL.

[ Frontend (React/Vite) ]
|
v (HTTP en :3000)
[ Nginx API Gateway ] (Puerto :8080)
|
+-------+-------+
|               |
v               v
[ Startups ]  [ Technologies ] (Services Node.js :3001 / :3002)
|               |
+-------+-------+
|
v
[ PostgreSQL DB ] (Puerto :5432 / Volumétrica)

## Tecnologías utilizadas
- **Backend:** Node.js v18 + Express.js (por su alta velocidad de desarrollo, consumo ligero de recursos y nativo soporte asíncrono para I/O).
- **Base de Datos:** PostgreSQL 15 (Elegido por su rigor composicional en SQL, integridad referencial, soporte UTF-8 e inicialización automatizada vía `seed.sql`).
- **API Gateway:** Nginx Alpine (Utilizado como Reverse Proxy liviano para enrutamiento por rutas `/v1/api/`, manejo de timeouts y buffering de respuestas).
- **Frontend:** React + Vite (Garantiza tiempos de carga ultrarrápidos, reactividad fluida en UI y compilación directa optimizada para contenedores).
- **Orquestación:** Docker y Docker Compose (Garantiza reproducibilidad del entorno sin importar el sistema operativo anfitrión).

## Estructura del proyecto

reto1/
├── gateway/
│   ├── nginx.conf
│   └── Dockerfile
├── services/
│   ├── startups/
│   │   ├── create/
│   │   ├── read/
│   │   ├── update/
│   │   ├── delete/
│   │   ├── app.js
│   │   ├── Dockerfile
│   │   └── package.json
│   └── technologies/
│       ├── create/
│       ├── read/
│       ├── update/
│       ├── delete/
│       ├── app.js
│       ├── Dockerfile
│       └── package.json
├── frontend/
│   ├── index.html
│   └── Dockerfile
├── db/
│   └── migrations/
│       └── seed.sql
├── docs/
│   └── evidencias/
│       ├── postman/
│       └── capturas/
├── docker-compose.yml
├── .env.example
├── .gitignore
└── README.md

## Requisitos
- **Docker Engine:** Versión 20.10.0 o superior.
- **Docker Compose:** Versión 2.0.0 o superior (`docker compose` v2).
- *(Opcional para pruebas externas)*: Node.js 18+ y cliente Git.

## Variables de entorno
Las variables se definen globalmente mediante un archivo `.env` en la raíz:

| Variable | Descripción | Valor por defecto |
| :--- | :--- | :--- |
| `POSTGRES_USER` | Usuario de PostgreSQL | `postgres` |
| `POSTGRES_PASSWORD` | Contraseña de PostgreSQL | `postgres` |
| `POSTGRES_DB` | Nombre de la base de datos | `ctin_db` |
| `POSTGRES_PORT` | Puerto interno de DB | `5432` |
| `DB_HOST` | Hostname del servicio DB en Docker | `ctin_postgres_db` |
| `GATEWAY_PORT` | Puerto de exposición de Nginx Gateway | `8080` |
| `FRONTEND_PORT` | Puerto de exposición de la App Web | `3000` |
| `VITE_API_BASE_URL` | Endpoint base para llamadas desde el Frontend | `http://localhost:8080/v1/api` |

## Cómo correr localmente
1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/LucioAlvalu/RETO1.git](https://github.com/LucioAlvalu/RETO1.git)
   cd RETO1
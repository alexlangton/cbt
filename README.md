# Configuración del Proyecto

## Backend (PHP FatFree)
- Ruta API: `/api/test`
- CORS habilitado
- Headers configurados

## Frontend (Vue 3)
- Proxy configurado en nginx
- Componente TestApi funcionando
- PrimeVue integrado

## Docker
- Contenedores: frontend, backend
- Red: app-network
- Puertos: 80 (frontend), backend (interno) 

mv database/torrejon.sql database/torrejon.sql.backup
docker exec cbt-db mysqldump -u cbt_user -pcbt_password cityboardtorrejon > database/torrejon.sql
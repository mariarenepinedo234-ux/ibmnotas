# Configurar PostgreSQL para IBM Notas

Estas instrucciones preparan una instalación local nueva del Instituto Técnico Británico Mercantil. El ZIP incluye el catálogo de siete carreras y 163 materias. La base se crea en tu computadora.

## 1. Instalar los requisitos

- Instala **Node.js 24 LTS** y comprueba la versión con `node --version`.
- En Windows o macOS, instala y abre **Docker Desktop**. En Linux, usa Docker Engine con el complemento Compose. Comprueba que responde con `docker compose version`.
- Descomprime el ZIP. Abre una terminal dentro de la carpeta `IBM-Notas`, donde están `package.json` y `compose.yaml`.

## 2. Crear y preparar la base de datos

Ejecuta estos comandos, uno por uno, desde esa carpeta.

```bash
npm ci
npm run configurar
docker compose up -d --wait db
npm run db:migrate
npm run catalogo:actualizar
npm run crear-admin
npm start
```

- `npm run configurar` crea `.env` con una contraseña aleatoria para PostgreSQL. Guarda ese archivo de forma privada. El configurador conserva cualquier `.env` existente.
- Docker inicia PostgreSQL 17 en el puerto local 5432. El nombre técnico de la base y el usuario de PostgreSQL son `ceicom`.
- Las migraciones crean las tablas. El comando del catálogo carga las 163 materias de IBM.
- `npm run crear-admin` pide usuario, nombre completo y una contraseña inicial de 8 a 160 caracteres que sea distinta del usuario. Esa cuenta pertenece al portal. El primer acceso pide cambiar la contraseña.
- Con `npm start` activo, abre `http://localhost:3000` e inicia sesión con la cuenta que creaste.

## 3. Volver a abrir el sistema

Desde la misma carpeta y con Docker abierto, ejecuta:

```bash
docker compose up -d --wait db
npm start
```

PostgreSQL conserva los datos en el volumen de Docker. Puedes comprobar el estado con `docker compose ps`. Para detener el servidor del portal usa **Ctrl+C** y para detener PostgreSQL ejecuta `docker compose stop db`. Evita `docker compose down -v` si quieres conservar la base, porque elimina el volumen.

## Si el puerto 5432 está ocupado

En el archivo `.env`, cambia `POSTGRES_PORT` a `5433` y sustituye el puerto `5432` por `5433` en `DATABASE_URL` y `TEST_DATABASE_URL`. Conserva las contraseñas ya generadas. Vuelve a ejecutar `docker compose up -d --wait db` y continúa con las migraciones.

Si el puerto 3000 está ocupado, cambia `PORT=3000` a `PORT=3001` en `.env` y abre `http://localhost:3001`.

## Si ya tienes una base con datos

Haz un respaldo antes de actualizar. Conserva tu `.env` y usa la conexión de la instalación existente. Una vez actualizado el código, ejecuta `npm ci`, `npm run db:migrate` y `npm run catalogo:actualizar`. El paso de crear administrador solo corresponde a una instalación nueva. Para un PostgreSQL 17 que ya administras, configura `DATABASE_URL` en `.env` y omite los comandos de Docker. Si la conexión es remota, usa el TLS y el certificado de CA indicados por tu proveedor.

Para probar con datos ficticios, usa una instalación y una base aparte. El [modo demostración](GUIA-PARA-PROBAR.md) está pensado para una base vacía.

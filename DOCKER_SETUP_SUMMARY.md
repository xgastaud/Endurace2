# Docker Setup Summary

## Files Created

The following files have been created for Docker support:

### 1. **Dockerfile**
- Base image: Ruby 3.1.4
- Installs system dependencies (PostgreSQL client, Node.js 18, build tools)
- Installs Ruby gems and npm packages
- Sets up the application workspace
- Includes entrypoint script for initialization

### 2. **docker-compose.yml**
Defines 4 services:
- **db**: PostgreSQL 14 database
- **redis**: Redis 7 for caching
- **web**: Rails application server (port 3000)
- **vite**: Vite dev server for assets (port 5173)

### 3. **docker-entrypoint.sh**
Initialization script that:
- Waits for database to be ready
- Creates database if it doesn't exist
- Runs migrations automatically
- Handles server.pid cleanup

### 4. **.dockerignore**
Excludes unnecessary files from Docker builds (logs, node_modules, git files, etc.)

### 5. **.env.example**
Template for environment variables

### 6. **DOCKER_README.md**
Comprehensive guide for using Docker with this project

## Files Modified

### **config/database.yml**
Updated development configuration to use environment variables:
- `DATABASE_HOST` (defaults to localhost for local dev, db for Docker)
- `DATABASE_USER` (defaults to postgres)
- `DATABASE_PASSWORD` (defaults to empty string for local dev, password for Docker)
- `DATABASE_NAME` (defaults to endurace_development)
- `DATABASE_PORT` (defaults to 5432)

This allows the app to work both locally and in Docker without changes.

## Quick Start

### Start the application:
```bash
docker-compose up --build
```

### Access the application:
- Rails: http://localhost:3000
- Vite: http://localhost:5173

### Stop the application:
```bash
docker-compose down
```

## Key Features

✅ **Hot Reloading**: Code changes are reflected immediately
✅ **Database Auto-Setup**: Database created and migrated on first run
✅ **Isolated Environment**: No need to install Ruby, PostgreSQL, or Redis locally
✅ **Volume Mounting**: Your code is mounted, so you can edit files normally
✅ **Health Checks**: Services wait for dependencies to be ready
✅ **Persistent Data**: Database and Redis data persisted in volumes

## Architecture

```
┌─────────────────────────────────────────────────┐
│                  Docker Host                     │
│                                                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │   Web    │  │   Vite   │  │  Redis   │      │
│  │  :3000   │  │  :5173   │  │  :6379   │      │
│  └────┬─────┘  └──────────┘  └──────────┘      │
│       │                                          │
│       │        ┌──────────┐                      │
│       └───────→│    DB    │                      │
│                │  :5432   │                      │
│                └──────────┘                      │
└─────────────────────────────────────────────────┘
```

## Next Steps

1. **Start Docker Desktop** (if not already running)

2. **Build and run**:
   ```bash
   cd /Users/xaviergastaud/code/xgastaud/endurace/Endurace2
   docker-compose up --build
   ```

3. **Wait for initialization** (first run may take a few minutes):
   - Docker will build the image
   - Install all dependencies
   - Start all services
   - Create and migrate the database

4. **Access the application**:
   - Open http://localhost:3000 in your browser

5. **Develop normally**:
   - Edit files in your editor
   - Changes will be reflected immediately
   - View logs in the terminal

## Troubleshooting

### Common Issues:

1. **Port already in use**: Change ports in docker-compose.yml
2. **Database connection failed**: Wait longer for database to start, or run `docker-compose restart web`
3. **Assets not loading**: Ensure Vite service is running (`docker-compose ps`)
4. **Permission errors**: Run `docker-compose exec web chown -R $(id -u):$(id -g) /app`

See DOCKER_README.md for detailed troubleshooting guide.

## Advantages of Using Docker

✅ Consistent development environment across team members
✅ No "works on my machine" issues
✅ Easy onboarding for new developers
✅ Isolated dependencies (no conflicts with other projects)
✅ Matches production environment more closely
✅ Easy to reset and start fresh

## Development Without Docker

The application still works without Docker! The database configuration uses environment variables with local defaults, so you can continue to run:

```bash
bundle exec rails server
```

If not using Docker, the database will connect to localhost with default PostgreSQL settings.

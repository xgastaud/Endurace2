# Docker Setup for Endurace

This guide will help you run the Endurace application using Docker and Docker Compose.

## Prerequisites

- Docker Desktop installed ([Download here](https://www.docker.com/products/docker-desktop))
- Docker Compose (included with Docker Desktop)

## Quick Start

### 1. Build and Start All Services

```bash
docker-compose up --build
```

This command will:
- Build the Docker image for your Rails app
- Start PostgreSQL database
- Start Redis
- Start the Rails server
- Start the Vite dev server

The application will be available at:
- **Rails app**: http://localhost:3000
- **Vite dev server**: http://localhost:5173

### 2. Stop All Services

```bash
docker-compose down
```

### 3. Stop and Remove All Data (Including Database)

```bash
docker-compose down -v
```

## Common Commands

### Access Rails Console

```bash
docker-compose exec web bundle exec rails console
```

### Run Migrations

```bash
docker-compose exec web bundle exec rails db:migrate
```

### Create Database

```bash
docker-compose exec web bundle exec rails db:create
```

### Seed Database

```bash
docker-compose exec web bundle exec rails db:seed
```

### Run Tests

```bash
docker-compose exec web bundle exec rails test
```

### Install New Gems

After adding a gem to the Gemfile:

```bash
docker-compose exec web bundle install
docker-compose restart web
```

Or rebuild the container:

```bash
docker-compose up --build web
```

### Install New NPM Packages

After adding a package to package.json:

```bash
docker-compose exec web npm install
docker-compose restart vite
```

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f web
docker-compose logs -f db
docker-compose logs -f vite
```

### Access Container Shell

```bash
# Rails container
docker-compose exec web bash

# Database container
docker-compose exec db psql -U postgres -d endurace_development
```

## Environment Variables

The following environment variables are configured in `docker-compose.yml`:

| Variable | Value | Description |
|----------|-------|-------------|
| `DATABASE_HOST` | `db` | Database host (Docker service name) |
| `DATABASE_USER` | `postgres` | Database user |
| `DATABASE_PASSWORD` | `password` | Database password |
| `DATABASE_NAME` | `endurace_development` | Database name |
| `REDIS_URL` | `redis://redis:6379/0` | Redis connection URL |
| `RAILS_ENV` | `development` | Rails environment |

You can modify these in `docker-compose.yml` or create a `.env` file.

## Service Architecture

The Docker setup includes 4 services:

### 1. **db** (PostgreSQL 14)
- Port: 5432
- Data persisted in `postgres_data` volume
- Health checks enabled

### 2. **redis** (Redis 7)
- Port: 6379
- Data persisted in `redis_data` volume
- Used for caching and background jobs

### 3. **web** (Rails App)
- Port: 3000
- Runs the Rails server
- Auto-reloads code changes (volume mounted)
- Depends on db and redis being healthy

### 4. **vite** (Vite Dev Server)
- Port: 5173
- Handles JavaScript/CSS compilation
- Hot module replacement (HMR)

## Troubleshooting

### Database Connection Issues

If you see database connection errors:

```bash
# Stop all services
docker-compose down

# Start fresh
docker-compose up --build
```

### Port Already in Use

If port 3000, 5432, 5173, or 6379 is already in use:

1. Stop the conflicting service, OR
2. Change the port mapping in `docker-compose.yml`:

```yaml
ports:
  - "3001:3000"  # Maps host port 3001 to container port 3000
```

### Permission Issues

If you encounter permission issues with volumes:

```bash
docker-compose exec web chown -R $(id -u):$(id -g) /app
```

### Rebuild Everything from Scratch

```bash
# Stop and remove everything
docker-compose down -v

# Remove images
docker-compose rm -f
docker rmi endurace2_web endurace2_vite

# Rebuild
docker-compose up --build
```

### View Container Status

```bash
docker-compose ps
```

### Clear Docker Cache

If builds are failing or acting strange:

```bash
docker system prune -a
docker volume prune
```

## Development Workflow

### Normal Development

```bash
# Start services (first time)
docker-compose up --build

# Start services (subsequent times)
docker-compose up

# In another terminal, watch logs
docker-compose logs -f web

# Make code changes - they'll be reflected immediately!
```

### Adding Dependencies

```bash
# Add gem to Gemfile, then:
docker-compose exec web bundle install
docker-compose restart web

# Add npm package to package.json, then:
docker-compose exec web npm install
docker-compose restart vite
```

### Database Changes

```bash
# Create migration
docker-compose exec web bundle exec rails generate migration MigrationName

# Run migrations
docker-compose exec web bundle exec rails db:migrate

# Rollback
docker-compose exec web bundle exec rails db:rollback
```

## Production Deployment

For production, you'll want to:

1. Use environment variables for secrets (not hardcoded)
2. Use a production-grade PostgreSQL service
3. Precompile assets in the Dockerfile
4. Use a reverse proxy (nginx)
5. Enable SSL/TLS

See the official Rails documentation for production Docker deployments.

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Rails Docker Guide](https://guides.rubyonrails.org/docker.html)

## Need Help?

If you encounter issues:

1. Check the logs: `docker-compose logs -f`
2. Ensure Docker Desktop is running
3. Try rebuilding: `docker-compose up --build`
4. Check service health: `docker-compose ps`

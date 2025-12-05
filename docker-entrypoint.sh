#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid

# Wait for database to be ready
echo "Waiting for database to be ready..."
until pg_isready -h $DATABASE_HOST -U $DATABASE_USER; do
  echo "Database is unavailable - sleeping"
  sleep 2
done

echo "Database is ready!"

# Check if database exists, if not create it
if ! bundle exec rails db:exists; then
  echo "Database does not exist. Creating database..."
  bundle exec rails db:create
  echo "Running migrations..."
  bundle exec rails db:migrate
  echo "Loading seeds (if any)..."
  bundle exec rails db:seed || true
else
  echo "Database exists. Running migrations..."
  bundle exec rails db:migrate
fi

# Execute the main command
exec "$@"

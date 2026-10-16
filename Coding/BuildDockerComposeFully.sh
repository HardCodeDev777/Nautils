#!/bin/bash
echo "Building docker compose..."
docker compose build --no-cache
docker compose up -d --force-recreate

echo "Done. Latest logs:"
docker compose logs -f --tail=10
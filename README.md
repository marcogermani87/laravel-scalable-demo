### Laravel scalable demo

Copy and customize .env file:

```bash
cp .env.exmple .env
```

Import environment variables:

```bash
export $(cat .env.${ENV} | xargs)
```

Build docker images:

```bash
docker build -f "Dockerfile" -t "laravel-scalable-app:latest" ./
```

Swarm init if needed:

```bash
docker swarm init
```

Deploy application:

```bash
docker stack deploy -c docker-compose.yaml laravel
```

Install deps and configure application:

```sh
docker compose exec app bash -c "cd ../ && composer install && npm run build && php artisan migrate"
```

How to scale application container:

```sh
docker compose scale app=6
```
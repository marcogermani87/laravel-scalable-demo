### Laravel scalable demo

Copy and customize .env file:

```bash
cp .env.exmple .env
```

Build docker containers:

```bash
docker compose up -d --build
```

Install deps and configure application:

```sh
docker compose exec app bash -c "cd ../ && composer install && npm run build && php artisan migrate"
```

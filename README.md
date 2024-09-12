### Laravel scalable demo

Build docker containers:

```bash
docker compose up -d --build
```

Install deps and configure application:

```sh
docker compose exec app bash -c "cd ../ && composer install && php artisan migrate"
```

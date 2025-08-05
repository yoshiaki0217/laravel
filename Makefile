up: ## Run Server
	docker-compose up -d

down:
	docker compose down

login:
	docker compose exec app bash

app-clear:
	docker compose exec app composer dump-autoload
	docker compose exec app php artisan optimize:clear

init:
	docker compose exec app ash -c ' \
		chmod -R 777 /app/storage && \
		composer install && \
		php artisan storage:link && \
		php artisan key:generate'

app-db-fresh:
	docker compose exec app ash -c ' \
		php artisan migrate:fresh && \
		php artisan migrate:fresh --env=testing'

app-db-fresh-seed:
	docker compose exec app ash -c ' \
		php artisan migrate:fresh --seed && \
		php artisan migrate:fresh --env=testing'
STACKS := proxy dashboard monitoring ai
STACK ?=
COMPOSE = docker compose --env-file .env -f stacks/$(STACK)/compose.yml

.PHONY: up down logs restart pull ps

up:      ; @test -n "$(STACK)" || (echo "usage: make up STACK=<$(STACKS)>"; exit 1) && $(COMPOSE) up -d
down:    ; @test -n "$(STACK)" || (echo "usage: make down STACK=<name>"; exit 1) && $(COMPOSE) down
logs:    ; @test -n "$(STACK)" || (echo "usage: make logs STACK=<name>"; exit 1) && $(COMPOSE) logs -f --tail=100
restart: ; @test -n "$(STACK)" || (echo "usage: make restart STACK=<name>"; exit 1) && $(COMPOSE) restart
pull:    ; @for s in $(STACKS); do docker compose --env-file .env -f stacks/$$s/compose.yml pull; done
ps:      ; @docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

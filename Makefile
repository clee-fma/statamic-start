PROJECT=fabtech-cms
CONTAINER_NAME=fabtech_cms_app

#create storage dirs when first run if needed
DIRS=storage storage/debugbar storage/framework storage/framework/cache storage/framework/sessions storage/framework/views

# container names
PHP_SERVICE_NAME=$(PROJECT)_app

LOGFILE := laravel_$(shell date +%F).log

.PHONY: up
up:
	make -C /var/www/dev $(PROJECT)-up

.PHONY: down
down:
	make -C /var/www/dev $(PROJECT)-down

.PHONY: npm
npm: up
	docker exec -it $(CONTAINER_NAME) npm \
		$(filter-out $@,$(MAKECMDGOALS)) $(MAKEFLAGS)

.PHONY: artisan
artisan: up
	docker exec -it $(CONTAINER_NAME) php artisan \
		$(filter-out $@,$(MAKECMDGOALS)) $(MAKEFLAGS)

.PHONY: please
please: up
	docker exec -it $(CONTAINER_NAME) php please \
		$(filter-out $@,$(MAKECMDGOALS)) $(MAKEFLAGS)

# .PHONY: statamic
# statamic: up
# 	docker exec -it $(CONTAINER_NAME) php please \
# 		$(filter-out $@,$(MAKECMDGOALS)) $(MAKEFLAGS)

%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line

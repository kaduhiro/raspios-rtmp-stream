.ONESHELL:

SERVICE := service

build: build/$(SERVICE)
build/%: # build or rebuild a image
	docker-compose build $*

run: run/$(SERVICE)
run/%: # run a one-off command on a container
	docker-compose run --rm $* /bin/sh

exec: exec/$(SERVICE)
exec/%: # run a command in a running container
	docker-compose exec $* /bin/sh

up: # create and start containers, networks, and volumes
	docker-compose up -d
up/%: # create and start a container
	docker-compose up -d $*

down: # stop and remove containers, networks, images, and volumes
	docker-compose down
down/%: # stop and remove a container
	docker-compose rm -fsv $*

.PHONY: build build/% run run/% up up/% exec exec/% down down/%

help: # list available targets and some
	@len=$$(awk -F':' 'BEGIN {m = 0;} /^[^\s]+:/ {gsub(/%/, "<service>", $$1); l = length($$1); if(l > m) m = l;} END {print m;}' $(MAKEFILE_LIST)) && \
	printf "%s%s\n\n%s\n%s\n\n%s\n%s\n" \
		"usage:" \
		"$$(printf " make <\033[1mtarget\033[0m>")" \
		"services:" \
		"$$(docker-compose config --services | awk '{printf "  \033[1m%s\033[0m\n", $$1;}')" \
		"targets:" \
		"$$(awk -F':' '/^[^\s]+:/ {gsub(/%/, "<service>", $$1); gsub(/^[^#]+/, "", $$2); gsub(/^[# ]+/, "", $$2); if ($$2) printf "  \033[1m%-'$$len's\033[0m  %s\n", $$1, $$2;}' $(MAKEFILE_LIST))"
clean: # remove cache files from the working directory

.PHONY: help clean


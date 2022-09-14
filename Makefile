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
	@len=$$(awk -F':' 'BEGIN {m = 0;} /^[0-9a-zA-Z_\/%%]+:/ {l = length($$1); if(l > m) m = l;} END {print m;}' $(MAKEFILE_LIST)) && \
	cat <<-EOF
	usage: make $$(printf "<\033[1mtarget\033[0m>")
	
	SERVICES:
	$$(docker-compose config --services | awk '{printf "    \033[1m%s\033[0m\n", $$1;}')
	
	TARGETS:
	$$(awk -F':' '/^[0-9a-zA-Z_\/%%]+:/ {gsub(/^[^#]+/, "", $$2); gsub(/^[# ]+/, "", $$2); if ($$2) printf "    \033[1m%-'$$len's\033[0m\t%s\n", $$1, $$2;}' $(MAKEFILE_LIST))
	EOF

clean: # remove cache files from the working directory

.PHONY: help clean


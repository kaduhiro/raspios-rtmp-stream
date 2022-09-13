.ONESHELL:

build/%: # build or rebuild a image
	docker-compose build $*

run/%: # run a one-off command on a new container
	docker-compose run --rm $* /bin/sh

up/%: # create and start containers
	docker-compose up -d $*

exec/%: # run a command in a running container
	docker-compose exec $* /bin/sh

down/%: # stop and remove containers
	docker-compose rm -fsv $*

.PHONY: build/% run/% up/% exec/% down/%

help: # list available targets and some
	@echo "usage: make <\033[1mtarget\033[0m>\n"
	@len=$$(awk -F':' 'BEGIN {m = 0;} /^[0-9a-zA-Z_\/%%]+:/ {l = length($$1); if(l > m) m = l;} END {print m;}' $(MAKEFILE_LIST))
	@awk -F':' '/^[0-9a-zA-Z_\/%%]+:/ {gsub(/^[^#]+/, "", $$2); gsub(/^[# ]+/, "", $$2); if ($$2) printf "\033[1m%-'$$len's\033[0m\t%s\n", $$1, $$2;}' $(MAKEFILE_LIST)

clean: # remove cache files from the working directory

.PHONY: help clean

# Project: docker php54
# Author: AooJ <aooj@n13.cz>
# Date: 2014
# usage:
#	make build	- build new image from Dockerfile
#	make run	- debug run already created image by tag
#	make debug	- build and run bash in docker, dont run /run/start.sh


NAME=aooj/php54
VERSION=1.2


build:
	docker build -t $(NAME):$(VERSION) .


run:
	docker run -p 80 -p 443 -t -i $(NAME):$(VERSION)

debug: build
	docker run -p 80 -p 443 -t -i $(NAME):$(VERSION) /bin/bash	


ssh:
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		IP=$$(docker inspect $$ID | grep IPAddr | sed 's/.*: "//; s/".*//') && \
		echo "SSHing into $$IP" && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost

.PHONY: build run debug ssh

all 	: up

up			:
	make flush
	git pull
	

down		:
	docker-compose -f ./srcs/docker-compose.yml down

logs		:
	docker-compose -f ./srcs/docker-compose.yml logs

what		:
	@echo PROCESSES $(shell docker ps -a -q | wc -l)
	@docker ps -a -q
	@echo IMAGES $(shell docker images -a -q | wc -l)
	@docker images -a -q

flush	 	:
	@docker stop $(shell docker ps -q -a)
	@docker rm $(shell docker ps -q -a); docker image rm $(shell docker images -q -a)
all 	: up

up			:
	docker-compose -f ./srcs/docker-compose.yml up --build
	

down		:
	docker-compose -f ./srcs/docker-compose.yml down

logs		:
	docker-compose -f ./srcs/docker-compose.yml logs

what		:
	@echo PROCESSES $(shell docker ps -a -q | wc -l)
	@docker ps -a -q
	@echo IMAGES $(shell docker images -a -q | wc -l)
	@docker images -a -q

rem			:
	@rm -rf /home/bmatos-d/data/mysql/*
	@rm -rf /home/bmatos-d/data/wordpress/*

flush	 	:  rem
	@docker stop $(shell docker ps -q -a)
	@docker rm $(shell docker ps -q -a); docker image rm $(shell docker images -q -a)
	@docker volume remove $(docker volume ls)

flushe	 	: 
	@docker stop $(shell docker ps -q -a)
	@docker rm $(shell docker ps -q -a); docker image rm $(shell docker images -q -a)
	@docker volume remove $(docker volume ls)
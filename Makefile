IMAGE_REPOSITORY := dockerinaction/ch13_multi_tier_app

build:
	docker build -t $(IMAGE_REPOSITORY):api -f api/Dockerfile .

push:
	docker push $(IMAGE_REPOSITORY):api

deploy-stack:
	docker stack deploy --compose-file docker-compose.yml multi-tier-app

SLEEP_TIME_IN_SECS := 10
destroy-stack:
	@echo "removing multi-tier-app stack"
	docker stack rm  multi-tier-app
	@echo "sleeping $(SLEEP_TIME_IN_SECS) seconds so Swarm can converge its state"
	sleep $(SLEEP_TIME_IN_SECS)
	@echo "removing orphaned multi-tier-app containers"
	docker container ls -a | grep multi-tier-app | awk '{ print $NF }' | xargs docker container rm -f
	@echo "sleeping $(SLEEP_TIME_IN_SECS) seconds so Swarm can converge its state"
	sleep $(SLEEP_TIME_IN_SECS)
	@echo "removing orphaned multi-tier-app_db-data volume"
	docker volume rm multi-tier-app_db-data

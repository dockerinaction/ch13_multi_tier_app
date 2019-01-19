IMAGE_REPOSITORY := dockerinaction/ch13_multi_tier_app

build:
	docker build -t $(IMAGE_REPOSITORY):api -f api/Dockerfile .

push:
	docker push $(IMAGE_REPOSITORY):api

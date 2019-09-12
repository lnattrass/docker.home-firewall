# Use IP here in case I brick my router/firewall heh
IMAGE := "10.10.0.60/lnattrass/firewall:latest"

.PHONY: test push

build: .id

push: .id
	docker tag $(shell cat .id) $(IMAGE)
	docker push $(IMAGE)

.id: Dockerfile $(shell find tree)
	docker build --iidfile=.id .

test: .id
	cd test && ./run


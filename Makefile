IMAGE := "10.10.0.60/lnattrass/firewall:latest"

.PHONY: test push

build: .id

nftables/.id:
	make -C nftables .id

.id: Dockerfile nftables/.id $(shell find tree)
	docker build --build-arg NFT_BUILD=$(shell cat nftables/.id) --iidfile=.id .

push: .id
	docker tag $(shell cat .id) $(IMAGE)
	docker push $(IMAGE)

test: .id
	docker tag $(shell cat .id) lnattrass-fwtest:latest
	cd test && ./run

run: .id
	docker run -it --rm --entrypoint=/bin/bash --privileged $(shell cat $<)

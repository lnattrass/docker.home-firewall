
.PHONY: test push

build: .id

keys/abuild.conf:
	mkdir -p keys
	docker run -it --rm -v $(PWD)/keys:/root/.abuild --entrypoint /bin/ash alpine:latest -c "/sbin/apk add alpine-sdk && /usr/bin/abuild-keygen -ain"

push: .id
	docker tag $(shell cat .id) $(IMAGE)
	docker push $(IMAGE)

.id: Dockerfile keys/abuild.conf $(shell find tree) $(shell find keys)
	docker build --iidfile=.id .

run: .id
	docker run -it --rm --privileged $(shell cat $<)

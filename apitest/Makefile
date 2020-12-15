include .env

#TAG=$(shell git log -1 --pretty=%H)
IMAGE=api-test
SNAPSHOT=$(REGISTRY)/$(IMAGE):$(TAG)
RELEASE=$(REGISTRY)/$(IMAGE):$(VERSION)

build: Dockerfile
	@docker build -t $(SNAPSHOT) -f Dockerfile .

push: build
	@docker push $(SNAPSHOT)

release: build
	@docker tag $(SNAPSHOT) $(RELEASE)
	  @docker push $(RELEASE)
VERSION?=v1.0.2

DOCKER_REPO?=purse/bcoin
DOCKER_FULLTAG=$(DOCKER_REPO):$(VERSION)

BCOIN_CHECKOUT?=tags/$(VERSION)

build:
	@echo "building: $(DOCKER_FULLTAG)"
	@docker build -t $(DOCKER_FULLTAG) \
		--build-arg BCOIN_VERSION=$(BCOIN_CHECKOUT) \
		.

# Current option for latest:
latest: build
	@echo "Tagging latest"
	@docker tag $(DOCKER_FULLTAG) $(DOCKER_REPO):latest

master: DOCKER_TAG=master
master: BCOIN_CHECKOUT=master
master: build

.PHONY: build latest

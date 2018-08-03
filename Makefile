SYSTEM?=slim
VERSION?=v1.0.2

DOCKERFILE?=Dockerfile.$(SYSTEM)
DOCKER_REPO?=purse/bcoin
DOCKER_TAG?=$(VERSION)-$(SYSTEM)
DOCKER_FULLTAG=$(DOCKER_REPO):$(DOCKER_TAG)

BCOIN_CHECKOUT?=tags/$(VERSION)

build:
	@echo "building: $(DOCKER_FULLTAG)"
	@docker build -t $(DOCKER_FULLTAG) \
		-f $(DOCKERFILE) \
		--build-arg BCOIN_VERSION=$(BCOIN_CHECKOUT) \
		.

# Current option for latest:
latest: SYSTEM=slim
latest: build
	@echo "Tagging latest"
	@docker tag $(DOCKER_FULLTAG) $(DOCKER_REPO):latest


all: slim arch

slim: SYSTEM=slim
slim: build

arch: SYSTEM=arch
arch: build

master: DOCKER_TAG=master
master: BCOIN_CHECKOUT=master
master: build


.PHONY: all build latest slim arch

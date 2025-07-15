# --- Configuration ---
GITHUB_USER ?= kitechsoftware
IMAGE_NAME ?= gcr-rust
IMAGE_TAG ?= latest
FULL_IMAGE := ghcr.io/$(GITHUB_USER)/$(IMAGE_NAME):$(IMAGE_TAG)
DOCKERFILE := Dockerfile
CONTEXT := .

# --- Commands ---

.PHONY: all build push login publish clean

all: build

## 🔨 Build the Docker image
build:
	docker build -t $(FULL_IMAGE) -f $(DOCKERFILE) $(CONTEXT)

## 🔑 Log in to GHCR
login:
	@if [ -z "$$GITHUB_TOKEN" ]; then \
		echo "❌ GITHUB_TOKEN is not set. Export it first."; \
		exit 1; \
	fi
	echo "$$GITHUB_TOKEN" | docker login ghcr.io -u $(GITHUB_USER) --password-stdin

## 📤 Push the image to GHCR
push: login
	docker push $(FULL_IMAGE)

## 🚀 Build & push in one step
publish: build push

## 🧹 Clean up local image
clean:
	docker rmi $(FULL_IMAGE) || true

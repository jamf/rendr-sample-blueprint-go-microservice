ENV ?= dev
NAMESPACE ?= {{ name }}-$(ENV)
DOCKER_IMAGE_REPO = {{ docker_image_repo }}

{{ name }}:
	go build -o {{ name }}

docker-build:
	docker build -t $(DOCKER_IMAGE_REPO) .

docker-push:
	docker push $(DOCKER_IMAGE_REPO)

kube-deploy: manifest.yaml
	kubectl get ns $(NAMESPACE) || kubectl create ns $(NAMESPACE)
	kubectl apply -f manifest.yaml -n $(NAMESPACE)

kube-delete: manifest.yaml
	kubectl delete -f manifest.yaml

manifest.yaml:
	helm template helm-chart \
		-f helm-chart/env/values-default.yaml \
		-f helm-chart/env/values-$(ENV).yaml \
		--namespace $(NAMESPACE) \
		--name-template $(ENV) > manifest.yaml

clean:
	rm -f manifest.yaml

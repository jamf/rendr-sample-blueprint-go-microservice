# {{ name }}

This is your new microservice, generated using [rendr](https://github.com/jamf/rendr)!

[![CI Status](https://github.com/{{ github_id }}/{{ name }}/workflows/Build%20and%20Test/badge.svg)](https://github.com/{{ github_id }}/{{ name }}/actions)

## Features

This is a small web app, written in [Go](https://golang.org). It consists of two endpoints: the root endpoint which displays a welcome message, and a health check endpoint at `/health` which returns JSON metadata about the running application.

In addition, there are a number of features in this project:

* GitHub Actions CI pipeline
* `Dockerfile` to containerize the app (image size: 13.3 MB)
* Helm chart to generate Kubernetes manifests
* Kubernetes deployment with `make deploy`
* Development, staging and production environment configuration for Kubernetes
* `Makefile` to automate the Go build, Docker build, and Kubernetes deployment

## Development

You can build this project locally using `make`, which builds the Go binary:

```
make
./{{ name }}
```

Or you can build and run the Docker container:

```
make docker-build
docker run -p {{ port }}:{{ port }} {{ docker_image_repo }}
```

Then visit http://localhost:{{ port }}. If all goes well, there should be a "hello world" message.

## Health checks

There's a simple health check available under `/health`. To make it more meaningful, we recommend editing `health.go`. It should be fairly straightforward. The reference is [here](https://github.com/hellofresh/health-go).

Example:
```
curl -s localhost:{{ port }} | jq
{
  "status": "OK",
  "timestamp": "2020-07-08T08:54:29.129544-05:00",
  "system": {
    "version": "go1.14.1",
    "goroutines_count": 3,
    "total_alloc_bytes": 315256,
    "heap_objects_count": 705,
    "alloc_bytes": 315256
  }
}
```

## Automation

### GitHub Actions pipeline

There is a GitHub Actions pipeline included under the `.github` directory. If you push this repository to GitHub, GitHub will automatically recognize this and start running your first CI build!

### Helm chart

Helm is a templating engine for Kubernetes manifests based on user-provided values.  Custom values for each environment (`dev`/`staging`/`production`) are located in the corresponding `values-$(ENV).yaml` file under `helm-chart/env`.  Shared values are located in `values-default.yaml`. The full reference for available values for the Helm chart is under `helm-chart/values.yaml`.

The included Helm chart was created using `helm create {{ name }}`.

To generate the manifest from the Helm chart, run this:

    make manifest.yaml

The default environment is `dev` (as seen in the `Makefile`). Simply set the `ENV` environment variable to `staging` or `production` to deploy to those environments:

    export ENV=staging
    make manifest.yaml

### Kubernetes deployment

After rendering the `manifest.yaml` from the Helm chart, deploy it to Kubernetes:

    make kube-deploy

You can see your running pod within seconds:

    kubectl get pods -n {{ name }}-dev

The manifest includes an ingress, so you can access your running service via HTTP:

    curl https://{{ name }}.staging.example.com

There it is! Your own app running in a production-like environment within minutes!

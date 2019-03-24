# Kubernetes Dummy Image

Provides a waiting entrypoint to the Kubernetes cluster to exec into.

It runs an entrypoint that pauses and waits for signals.

## Build

```sh
make build
```

## Publish

```sh
make push
```

## Usage

Launch a debug container:

```sh
kubectl run dummy-${RANDOM} -it --rm --restart=Never --image=hendrikmaus/kubernetes-dummy-image:latest -- bash
```

Or use as a container in a pod to provide an entrypoint to exec into.

# K8s Tool Comparison

This repository shows how to deploy the [K8s guestbook example](https://github.com/kubernetes/examples/tree/master/guestbook) using a variety of deployment tools.
For more details on the example check out the [tutorial in the K8s docs](https://kubernetes.io/docs/tutorials/stateless-application/guestbook/).

## kubectl

The included CLI of all Kubernetes clusters.

```bash
kubectl -f kubectl/guestbook.yaml
```
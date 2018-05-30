# K8s Tool Comparison

[![Build Status](https://travis-ci.org/mbode/kubernetes-tool-comparison.svg?branch=master)](https://travis-ci.org/mbode/kubernetes-tool-comparison)

This repository shows how to deploy the [K8s guestbook example](https://github.com/kubernetes/examples/tree/master/guestbook) using a variety of deployment tools.
For more details on the example check out the [tutorial in the K8s docs](https://kubernetes.io/docs/tutorials/stateless-application/guestbook/).

## Use Case

[guestbook.yaml](guestbook.yaml) contains the vanilla guestbook Kubernetes manifest, defining the following resources:

* _redis-master_ (Service, Deployment)
* _redis-slave_ (Service, Deployment)
* _frontend_ (Service, Deployment)

They can be deployed using:

```bash
kubectl apply -f guestbook.yaml
```

Now let us pretend we want do deploy all of these resources several times.
In our example we need two completely separate installations of the whole stack, one for _cats_ and one for _dogs_. Furthermore, as it is well known that cats are better conversationalists, we expect a higher load there and would like to give the respective _redis-slave_ twice the resource requests.

Another natural reason for this duplication could be a deployment pipeline with promotion across stages like _dev_, _staging_ and _prod_, where one also might to save on resources for the earlier stages.

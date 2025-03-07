![image](https://github.com/user-attachments/assets/cbffbd23-59d4-4d60-a906-138cdd6a8c1b)# Day 5

## Info - Openshift Internal Image Registry
<pre>
- As part of installing Openshift, we also deploy Openshift Internal Image Registry
- Openshift Internal Image Registry stores all the container images
- In order to deploy an application into openshift, we need to have those images in the Openshift's internal image registry
</pre>

## Info - Openshift ImageStream
<pre>
- OpenShift ImageStream is a folder created within Openshift Internal Image Registry to store a single image but multiple versions(tag) can be stored  
</pre>

## Info - Red Hat - Universal Base Images
<pre>
https://catalog.redhat.com/software/containers/rhel8/dotnet-90-runtime/672bc8ce97487bd4c61a1239

https://catalog.redhat.com/software/containers/ubi8/openjdk-17/618bdbf34ae3739687568813

https://catalog.redhat.com/software/containers/ubi8/python-39/6065b24eb92fbda3a4c65d8f
</pre>

## Info - Build Config

## Info - Build

## Demo - Creating docker pull secret to extend the docker image download limit ( You don't have to do this )
```
docker login
oc create secret generic docker-pullsecret --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson

oc import bitnami/nginx bitnami/nginx:latest docker.io/library/bitnami/nginx:latest --confirm

oc get images | grep bitnami/nginx
```

Expected output
![image](https://github.com/user-attachments/assets/d8722723-83dc-4bc2-bb13-e61fe2f66239)
![image](https://github.com/user-attachments/assets/f5b579ab-5e79-43b2-a2a3-8960818b57e9)
![image](https://github.com/user-attachments/assets/6a45a067-40c5-482a-a7db-c602a68f2d7a)
![image](https://github.com/user-attachments/assets/66709e35-4c48-454a-b067-046b2f8ff633)
![image](https://github.com/user-attachments/assets/f0fab785-4382-4c9d-88c3-39afc9d6859a)

## Lab - Deploying application using S2I source strategy
```
oc project jegan
oc new-app registry.access.redhat.com/ubi8/openjdk-11~https://github.com/tektutor/hello-microservice.git --strategy=source
oc expose service/hello-microservice
oc logs -f bc/hello-microservice
```

Expected output
![image](https://github.com/user-attachments/assets/e8ea6c4e-9b32-4c63-87bb-3f57057125fc)
![image](https://github.com/user-attachments/assets/d44f1deb-375a-4ba9-a271-1d1f0b8a6322)
![image](https://github.com/user-attachments/assets/c481c23e-089a-4fe7-8f1f-321335fa9ab5)

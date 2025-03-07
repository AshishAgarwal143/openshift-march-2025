# Day 5

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


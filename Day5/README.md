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

## Info - SOLID Design Principles
<pre>
S - Single Responsibility Principle (SRP)
O - Open Closed Principle (OCP)
L - Liskov Substitution Principle (LSP)
I - Interface Seggregation Principle
D - Dependency Injection or Dependency Inversion or Inversion of Control (IOC)
</pre>

## Info - ReplicationController
<pre>
- In older versions of Kubernetes, we had to use ReplicationController to deploy applications into Kubernetes (aka K8s)
- As Openshift is Red Hat's Distribution of Kubernetes, even in Openshift we had to use ReplicationController for deploying applications
- ReplicationController does two things
  1. Rolling update
  2. Scale up/down
  - this kind of violates the Single Responsibility Principle
  - as replicationcontroller doesn't support declarative style, K8s team wanted a better alternates, which is deployment and replicaset
- Red Hat Openshift team introduced a new feature calle DeploymentConfig to deploy applications in declarative style( yaml - manifest files we can deploy applications )
- Meanwhile, Google Kubernetes team, they refactored ReplicationController into two resources
  1. Deployment
  2. ReplicaSet
- Kubernetes Deprecated use of ReplicationController for new application deployments as Deployment & ReplicaSet replaced ReplicationController
- OpenShift DeploymentConfig internally uses ReplicationController
- As Google Kubernetes deprecated use of ReplicationController, Red Hat Openshift team deprecated DeploymentConfig, instead it is recommended to use Deployment & ReplicaSet for new application deployments
- ReplicationController is still retained for legacy background compatility reasons only, hence it is not recommended to use this anymore
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
oc get imagestreams
oc describe is/hello-microservice

cat /etc/hosts
curl http://hello-microservice-jegan.apps.ocp4.alchemy.com
```

Expected output
![image](https://github.com/user-attachments/assets/e8ea6c4e-9b32-4c63-87bb-3f57057125fc)
![image](https://github.com/user-attachments/assets/d44f1deb-375a-4ba9-a271-1d1f0b8a6322)
![image](https://github.com/user-attachments/assets/c481c23e-089a-4fe7-8f1f-321335fa9ab5)
![image](https://github.com/user-attachments/assets/2dc1c9aa-aa6b-4668-b404-f73a9786ab95)
![image](https://github.com/user-attachments/assets/2f43f08a-e292-4a63-8634-5a10a0089960)

## Info - What happens internally within Openshift when we run the below command
```
oc create deployment nginx --image=bitnami/nginx:latet --replicas=3
```

Below chain of things happens
<pre>
- oc client tool makes a REST call to API Server requesting it to create a deployment with image bitnami/nginx and desired number of Pods 3 and the deployment name must be nginx
- API Server receives the request from oc client, it then creates a Deployment record/entry in etcd database
- API Server then sends a broadcasting event saying "New Deployment created"
- Deployment Controller receives this event, it then makes a REST call to API Server, requesting to create a ReplicaSet for nginx deployment
- API Server creates a ReplicaSet in the etcd database
- API Server sends a broadcasting event to notify that a New ReplicaSet is created
- ReplicaSet Controller receives the event, it then makes a REST call to API Server, requesting it to create 3 Pods for the replicaSet
- API Server creates 3 Pod record/entry in the etcd database
- API Server sends broadcasting events to notify New Pods created
- Scheduler will receive this event, it then identifies healthy nodes where the new Pod can be deployed, Scheduler sends its scheduling recommendations to API Server via REST call
- API Server, retrieves the existing Pod from etcd database, it then updates the Pod scheduling recommendations came from scheduler
- API Server sends broadcasting events to notify Pod scheduled to so and so node ( for example work-1 node )
- Kubelet running in worker 1 node will receive the event, it then communicates with the CRI-O container runtime to pull the image
- Kubelet creates a container on the worker 1 node with the newly pulled image
- Kubelet starts the container in the worker 1 node
- Kubelet reports the status back to API Server in heart-beat like periodic fashion about all the containers running in worker 1 node via REST call
- API Server retrieves the Pod entry from etcd database based on the Pod Id and status shared by kubelet, it then updates the Pod status in the etcd database
</pre>

## Info - DaemonSet
<pre>
-   
</pre>


## Info - StatefulSet
<pre>
- Deployment is meant for stateless application deployment
- StatefulSet is meant to deployment database applications, especially a cluster of database
- scale up a deployment is pretty simple for the deployment controller as each pod this is part of a deployment is independent of each other
- scaling up a Statefulset, requires synchronizing data between all the pods in the statefulset, which is lot complex
- creating a statefulset also requires loads of manual scripting within the statefulset yaml file
</pre>
For sample code, you may refer https://etcd.io/docs/v3.6/op-guide/kubernetes/

## Info - Job
<pre>
- any one time activity can be performed using Kubernetes/Openshift Job
- For example
  - you wish to take backup of etcd database
  - you wish to take recover of etcd database
</pre>

## Info - CronJob
<pre>
- if you wish to take backup every Friday midnight, CronJob   
</pre>

## Lab - Creating a DaemonSet
```
oc create deployment hello --image=tektutor/hello-microservice:latest --replicas=3 --dry-run=client -o yaml
oc create deployment hello --image=tektutor/hello-microservice:latest --replicas=3 --dry-run=client -o yaml > hello-daemonset.yml
```

you need to modify the hello-daemonset.yml as shown below
<pre>
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
     app: hello
  name: hello
spec:
  selector:
    matchLabels:
      app: hello
  template:
    metadata:
      labels:
        app: hello
    spec:
      containers:
      - name: hello
        image: image-registry.openshift-image-registry:5000/jegan/hello-microservice
</pre>

Expected output
![image](https://github.com/user-attachments/assets/d276ecbd-8141-4d59-ba12-24200b27af7f)
![image](https://github.com/user-attachments/assets/9d887ea3-c3db-42d5-b7a9-a2c5c111a2a0)


To create the daemonset
```
oc create -f hello-daemonset.yml
oc get po -o wide
```
![image](https://github.com/user-attachments/assets/02d37703-a0ab-44bb-b80a-ec9e05caa1b4)

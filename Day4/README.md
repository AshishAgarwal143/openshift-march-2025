![image](https://github.com/user-attachments/assets/7efa8669-4980-4710-b102-202486d71cab)![image](https://github.com/user-attachments/assets/6599da9d-048d-4505-abda-20e48b2abfc7)# Day 4

## Lab - Check the client version
```
kubectl version
oc version
```

Expected output
![image](https://github.com/user-attachments/assets/5775dd06-edb9-4978-9947-c82254077033)


## Lab - Listing Openshift cluster nodes
```
oc get nodes
```

Expected output
![image](https://github.com/user-attachments/assets/a8c6291f-c817-43b4-b006-8ac265fc709e)

## Lab - Finding more details about the node
```
oc describe node master01.ocp4.alchemy.com
```

Expected output
![image](https://github.com/user-attachments/assets/62618c30-a18c-4111-83bb-511290651bb2)
![image](https://github.com/user-attachments/assets/a91d32c0-019a-480d-8c8d-73b4bd245cc2)
![image](https://github.com/user-attachments/assets/a698b091-3edf-4941-9f0d-3761b2ac521d)

## Info - Openshift Pod Network
<pre>
- Openshift cluster wide (IP Range ) - Pod Network - 10.0.0.0/8  
- Openshift will break this range of IP addresses into for each node
  - Master 1 Node - 10.28.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Master 2 Node - 10.29.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Master 3 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Worker 1 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Worker 2 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Worker 3 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
</pre>

## Lab - Getting the node definition as yaml or json
```
oc get node master01.ocp4.alchemy.com -o yaml
oc get node master01.ocp4.alchemy.com -o json
```
Expected output
![image](https://github.com/user-attachments/assets/94a3f964-9986-4ebd-a971-ded1cb611df5)

## Info - Openshift Hierarchy
<pre>
- Node ( Server )
  - Namespace 
     - Pod 1
       - Container 1
       - Container 2
</pre>  

## Lab - Finding the IP address of openshift nodes
```
oc get nodes -o wide
```
Expected output
![image](https://github.com/user-attachments/assets/7d21175f-b950-422f-85d1-f143f3083e21)


## Info - Openshift Project
<pre>
- Openshift project is nothing but Kubernetes namespace with access restrictions  
- If we don't create a project before deploy our applications, it gets deployed onto default project
- Its always a best practice to create your own project before deploying applications
- one project can host many applications
</pre>


## Lab - Creating a new project in openshift
```
oc new-project jegan
```
Expected output
![image](https://github.com/user-attachments/assets/bacf9f9d-274c-4c07-be63-465c6c3d8533)

## Info - Red Hat Image Registry
<pre>
https://catalog.redhat.com/software/containers/ubi8/nginx-120/6156abfac739c0a4123a86fd  
</pre>



## Lab- Deploying your first application into openshift
```
oc project jegan
oc create deployment nginx --image=bitnami/nginx:latest --replicas=3
```

List deployments
```
oc get deployments
oc get deployment
oc get deploy
```

List replicasets
```
oc get replicasets
oc get replicaset
oc get rs
```

List pods
```
oc get pods
oc get pod
oc get po
```

Expected output
![image](https://github.com/user-attachments/assets/692b20ca-44f5-4bbe-bd29-d48f3eedb370)
![image](https://github.com/user-attachments/assets/699c9620-7313-4295-8dcf-2fc5ef00bb5d)

In Server 192.168.1.233, the bitnami/nginx:latest image is already there, hence we can edit the deployment to convey it can use the existing image rather than attempting download the image each time from Docker Hub website
```
oc edit deploy/nginx
```

Expected output
![image](https://github.com/user-attachments/assets/d416737d-13de-4bde-8e95-7fee3b632e65)

In the above, you need edit imagePullPolicy from "Always" to "IfNotPresent"
![image](https://github.com/user-attachments/assets/2466233a-d257-4d3f-bd58-884003449255)
![image](https://github.com/user-attachments/assets/e097593e-72cc-4ab0-9e64-bf3479cdb5cf)

## Lab - Deploying an application into Openshift using S2I(Source to Image) using docker strategy
```
oc project jegan
oc new-app https://github.com/tektutor/hello-microservice.git --strategy=docker
oc expose svc/hello-microservice
oc logs -f bc/hello-microservice
```

Expected output
![image](https://github.com/user-attachments/assets/3b6a9e09-a890-4826-aebe-1c5d4a6e6ff4)
![image](https://github.com/user-attachments/assets/c1a14842-2b18-480e-a211-3b50e2fac02a)
![image](https://github.com/user-attachments/assets/9552c1d0-10e7-4a81-b8e7-7ff58b70484e)


## Info - Local Container Registry
<pre>
- Every node has its own Local Image Registry
- when we issue command crictl images, this is a list of images from local node
- For example
  - Worker 1 Node has its Local Image Registry
  - Master 1 Node has its Local Image Registry
</pre>

## Info - Openshift Internal Image Registry
<pre>
- Every Openshift cluster has a single Internal Image Registry
- From this Internal Registry, individuals nodes can download the required images
- Openshift Internal Image Registry can import images from Docker Hub and/or JFrog Artifactory Private Image Registry
</pre>

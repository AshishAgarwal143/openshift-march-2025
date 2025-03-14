# Day 10

## Lab - Deploying our springboot microservice application from GitHub source code using source strategy into Openshift
### Note
<pre>
- In case of source strategy, source code will be cloned from GitHub repository url we gave
- Openshift is not going to expect a Dockerfile in the GitHub repo
- Openshift will also generate a BuildConfig
- Even if you have a Dockerfile, Openshift will still generate a Dockerfile using the Container Image we menitioned in the new-app command
- Using the image we mentioned in the new-app command, openshift will create a build pod using the build image suggested by us and performs the build
- Once the image is successfully built, it will push the image into the Openshift Internal Registry
- From the Openshift Internal registry, our application will be deployed into Openshift
- We need to just expose the service to create a route, the route url must be added to /etc/hosts
- We should be able to access the route url to invoke the microservice rest endpoint
</pre>

```
oc project jegan

oc new-app registry.access.redhat.com/ubi8/openjdk-17~https://github.com/tektutor/openshift-march-2025.git --context-dir=Day10/hello --strategy=source

oc logs -f bc/openshift-march-2025

oc expose svc/openshift-march-2025
```

Expected output
![image](https://github.com/user-attachments/assets/5d960508-87c6-4643-afed-72b0791d4d6d)
![image](https://github.com/user-attachments/assets/e7947f25-c1cc-43f6-ab84-90564a6f4370)
![image](https://github.com/user-attachments/assets/0387c0e9-d6bb-418d-9e8f-acd46a20f385)
![image](https://github.com/user-attachments/assets/42847ab3-8771-4fc5-a070-f3769e097e61)

## Lab - Deploying our springboot microservice application from GitHub source code using docker strategy into Openshift
### Note
<pre>
- In case of docker strategy, source code will be cloned from GitHub repository url we gave
- Openshift will expect a Dockerfile in the GitHub repo
- Openshift will generate a BuildConfig
- BuildConfig generated will refer Dockerfile we placed in the GitHub to perform the application and Image build
- Once the image is successfully built, it will push the image into the Openshift Internal Registry
- From the Openshift Internal registry, our application will be deployed into Openshift
- We need to just expose the service to create a route, the route url must be added to /etc/hosts
- We should be able to access the route url to invoke the microservice rest endpoint
</pre>

```
oc project jegan
cd ~/openshift-march-2025
git pull
cd Day10/hello
cp ~/.m2/repository m2
oc new-app --name=hello-app https://github.com/tektutor/openshift-march-2025.git --context-dir=Day10/hello --strategy=docker
oc logs -f bc/hello
oc expose svc/hello
curl http://hello-app-jegan.apps.ocp4.alchemy.com
```

Expected output
![image](https://github.com/user-attachments/assets/818306a4-727b-442e-8920-abcffc6b95ed)
![image](https://github.com/user-attachments/assets/965c9f5e-4319-46cd-8760-bb781c379e09)
![image](https://github.com/user-attachments/assets/8f0f90cf-bb03-4238-8ff5-140c96d6527c)
![image](https://github.com/user-attachments/assets/88b9f77a-ba41-4c9b-a025-2b231265d0a8)

## Info - Docker Network Model
<pre>
- For each container that we create, Docker creates a pair of veth devices (virtual ethernet - software defined network card with network stack )
- One veth devices stays in the local machine, while the other veth device is used with the container as a network card
- When we install docker, docker creates a virtual switch ( software defined ) called docker0
- all the containers by default are connected to the docker0 default network
- the subnet (IP range) assigned for docker 0 is 172.17.0.0/16 ( 256 x 256 = 65536 IP addresses in this network )
- some IP addresses are reserved for internal use
- 172.17.0.1 is assigned to docker0 bridge, as it acts as a Gateway for all containers 
- it is through this Gateway containers can reach out to Internet, and Internet can reach out to containers
</pre>  

## Info - Kubernetes Network Model
<pre>
- Kubernetes provides an interface called Container Network Interface (CNI)
- Any Container Engine or Container Runtime that must be supported by Kubernetes must implement the CNI
- Kubernetes kubelet container agent communicates with Container Runtime via the generic CNI interface
- Kubernetes provides only Network specification and it leaves the implementation details to the Network addons vendors
- There are many Network addons available for Kubernetes
- There are about 3 networks
  - Node Network ( Node to Node communication )
  - Pod Network ( Pod to Pod communication )
  - Service Network ( Pod to Service Communication )
- Pods are assigned with Private IPs
- As per Kubernetes Network specifications
  - Pods running in any node must be able to communicate with any Pods running in any node within K8s cluster
  - kubelet must be able to communicate with all the Pods running on the local node
- Network Addons vendors implemented the Kubernetes Network Specifications, some of the popular network addons are
  - Calico
  - Weave
  - Flannel
</pre>  

## Info - Openshift Network Model Overview
<pre>
</pre>  

## Info - Openshift Network Addons Overview
<pre>
</pre>  

## Info - Flannel Overview
<pre>
- Flannel is implemented by CoreOS company
- this is very first Kubernetes network add-on that was developed
- it uses overlay network
- it support many backends including UDP
- the drawback of UDP backend in Flannel is performance degradation as each incoming packet has to de-encapsulated and each outgoing packet has to encpasulated
- Also Flannel doesn't support Network policy
</pre>  

## Info - Weave Overview
<pre>
- is developed by a company called WeavWorks
- it supports Pod Networking,Service Network and Node Networking
- it supports Kubernetes Network policy
</pre>  

## Info - Calico Overview
<pre>
- is developed by a company called Tigera
- it used BGP protcol, it is highly efficient, high-performance guaranteed
- it also supports Kubernetes network
- BGP protocol is powering internet (world wide web), when such a complex network is efficiently working with BGP, the same benefits can be expected within Kubernetes/Openshift if we use Calico
</pre>  

## Info - Openshift Network Policy
<pre>
  
</pre>

## Lab - Deny all traffic to all pods
<pre>
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: deny-by-default
spec:
  podSelector: {}
  ingress: []  
</pre>

## Lab - Allow connections from Ingress Controller
<pre>
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-openshift-ingress
spec:
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          network.openshift.io/policy-group: ingress
  podSelector: {}
  policyTypes:
  - Ingress  
</pre>

## Lab - Allow same namespace
<pre>
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-same-namespace
spec:
  podSelector: {}
  ingress:
  - from:
    - podSelector: {}  
</pre>

## Lab - Allow only Http and Https access
<pre>
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-http-and-https
spec:
  podSelector:
    matchLabels:
      role: frontend
  ingress:
  - ports:
    - protocol: TCP
      port: 80
    - protocol: TCP
      port: 443  
</pre>

## Lab - Allow access to pods that has certain labels
<pre>
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-pod-and-namespace-both
spec:
  podSelector:
    matchLabels:
      name: test-pods
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            project: project_name
        podSelector:
          matchLabels:
            name: test-pods  
</pre>


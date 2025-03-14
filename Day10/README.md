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
oc new-app --name=hello https://github.com/tektutor/openshift-march-2025.git --context-dir=Day10/hello --strategy=docker
oc logs -f bc/hello
oc expose svc/hello
```

Expected output

## Info - Openshift Network Model Overview
<pre>
</pre>  

## Info - Openshift Network Addons Overview
<pre>
</pre>  

## Info - Flannel Overview
<pre>
</pre>  

## Info - Weave Overview

## Info - Calico Overview
<pre>
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


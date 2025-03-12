# Day 8

## Info - ClusterIP Service
<pre>
- service represents a group of load-balanced pods of a particular deployment
- can be accessed only within openshift cluster
- i.e from a Pod that runs within the cluster, we can open up a shell and access this type of service manually
- Pod can access clusterip service programatically
- this service forwards the call to any one of the Pods that belongs to single deployment
</pre>

## Info - NodePort Service
<pre>
- service represents a group of load-balanced pods of a particular deployment  
- can be accessed only outside the openshift cluster using any Node IP and Node Port allocated to the service
- this service forwards the call to any one of the Pods that belongs to a single deployment
</pre>


## Info - LoadBalancer Service
<pre>
- service represents a group of load-balanced pods of a particular deployment
- can be accessed outside the openshift cluster using the external Ip assigned to the loadbalancer service and service port
- this service forwards the call to any one of the Pods that belongs to a single deployment
</pre>

## Info - Ingress
<pre>
- forwarding/routing rules
- this is created by those who deployment applications
- this is not a service
- For a website, you could just create a single ingress that provides a public url
- You could writes rules, may be a path based rule to foward the calls to different services
- For example
  - Assume the home page of your website is https://www.tektutor.org
  - Assume there is login microservice, logout microservice, self paced video course microservice, etc.,
  - For each of the above microservice, assume we have created a NodePort or LoadBalancer or ClusterIP service
  - Ingress can forward the calls to any of the above services
    - it will forward the call in case user types https://www.tektutor.org/login, this call be routed to login microservice
    - if user navigates to https://www.tektutor.org/video-course, this call can be routed to video-course microservice
    - if user click on logout i.e https://www.tektutor.org/logout, this call can be routed to logout microservice
</pre>

## Info - Ingress Controller
<pre>
- Ingress Controller manages Ingress resource  
- Without an Ingress Controller, the ingress forwarding rules will not work
- Ingress Controller picks the Ingress rules and configures a Load Balancer to route the traffice at runtime
</pre>

## Info - Load Balancer


## Lab - Creating an Ingress in Openshift

Let's deploy two applications
```
cd ~/openshift-march-2025
git pull
cd Day8/ingress
oc project jegan
oc apply -f nginx-deploy.yml
oc apply -f nginx-service.yml
oc apply -f hello-deploy.yml
oc apply -f hello-service.yml
oc get po
cat ingress.yml
oc get svc
```
Expected output
![image](https://github.com/user-attachments/assets/616f20b2-4a2e-4e11-85ff-c8313343cfb3)
![image](https://github.com/user-attachments/assets/a57b645d-47f4-457d-b351-b07a803e830d)
![image](https://github.com/user-attachments/assets/7be5e0f5-4eff-49aa-98e3-77f11b0e3414)
![image](https://github.com/user-attachments/assets/906be19a-a557-4dc2-aa50-64dfb69077ca)
![image](https://github.com/user-attachments/assets/72ac9ce4-5be3-4a85-8ccc-41f8294c4874)
![image](https://github.com/user-attachments/assets/327e4cd0-6b05-4684-a2a2-45da08d5408a)

```
cd ~/openshift-march-2025
git pull
cd Day8/ingress
oc project jegan
cat ingress.yml

oc apply -f ingress.yml
oc get ingress

curl http://tektutor.apps.ocp4.alchemy.com/nginx
curl http://tektutor.apps.ocp4.alchemy.com/hello
```
Before using curl, make sure tektutor.apps.ocp4.alchemy.com is added into /etc/hosts file.

Expected output
![image](https://github.com/user-attachments/assets/ca0b26a9-db06-4a5e-bc5a-c8f897f19edc)
![image](https://github.com/user-attachments/assets/f0d91685-21e2-40ab-8f06-a7c0cccec37c)

## Info - Route vs Ingress
<pre>
- Openshift Route internally depends on Ingress
- In otherwords, Openshift Route is developed on top of Kubernetes Ingress
- Generally Openshift Routes forwards the call to a single Service, while Ingress forwards the call to multiple services based on rules
</pre>

## Lab - Port Forwarding
<pre>
- This is only used for testing purpose locally, hence this is not a solution used in production
- Generally used by developers for quicky testing if their application is running as expected after deployment
- For production use, we need to use services and routes only
</pre>

Let's list the pods
```
oc project jegan
oc get pods
```

Port forward in a Terminal Tab
```
oc port-forward your-pod-name 9090:8080
```

Expected output
![image](https://github.com/user-attachments/assets/df6fde8a-dbeb-47bc-8170-0e7d0f75c8d6)

You may open a web browser on the linux machine, and navigate to 
<pre>
http://127.0.0.1:9090  
</pre>

Expected output
![image](https://github.com/user-attachments/assets/1fe7a1ac-9ff5-4505-92e4-ae6710c2cfd2)


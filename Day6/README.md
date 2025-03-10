# Day 6

## Lab - Deploying an application using declarative style
```
oc create deployment nginx --image=bitnami/nginx:latest --replicas=3 -o yaml --dry-run=client > nginx-deploy.yml
```

Let's update the nginx-deploy.yml as shown below
```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
     labels:
       app: nginx
    spec:
      containers:
      - name: nginx
        image: bitnami/nginx:latest
        imagePullPolicy: IfNotPresent
      imagePullSecrets:
      - name: docker-pullsecret
```

Let's create the deployment in declarative style using yaml file, the save-config switch will save using which yml file the resource was created in the openshift cluster as a metadata. When we make changes to the yml later, openshift will validate whether this resources was originally created using the same yml file or was it created manually using imperative commands.
```
oc create -f nginx-deploy.yml --save-config
oc get deploy,rs,po
```

Expected output
![image](https://github.com/user-attachments/assets/9fb27c11-92af-4e6d-9e9f-9ddeac5fa6ba)
![image](https://github.com/user-attachments/assets/81cb8d38-8a4d-4adf-9e84-d4ee7864658c)
![image](https://github.com/user-attachments/assets/9085a97a-d10d-4fd6-a2ea-65aab0e10551)
![image](https://github.com/user-attachments/assets/2093f949-698d-43df-8f9b-0c4bc4ffc774)


## Lab - Creating a clusterip internal service in declarative style for nginx deployment
```
oc get deployments
oc expose deploy/nginx --port=8080 --type=ClusterIP -o yaml --dry-run=client > nginx-clusterip-service.yml
oc create -f nginx-clusterip-service.yml
oc get svc
```

Expected output
![image](https://github.com/user-attachments/assets/b230544a-e968-45c5-bb02-bd4db82be66c)

## Lab - Creating a nodeport external service in declarative style for nginx deployment
Let's delete the clusterip internal service we created for nginx deployment
```
oc delete -f nginx-clusterip-service.yml
```

Let's generate the nodeport service declarative manifest file and create the nodeport external service. In the below command, 192.168.100.11 is the master01 node IP address, you could replace with master02,master03,worker02,worker03.
```
oc expose deploy/nginx --type=NodePort --port=8080 -o yaml --dry-run=client > nginx-nodeport-service.yml
oc create -f nginx-nodeport-service.yml --save-config
oc get svc
curl http://192.168.100.11:30109
```

Expected output
![image](https://github.com/user-attachments/assets/9a9ddd9b-06af-40b5-a265-0fffa0dc7878)
![image](https://github.com/user-attachments/assets/6f371ef7-ebcb-4ff1-869a-4094ba0fbeda)

## Info - Rolling update
<pre>
- Kubernetes & Openshift supports Rolling update to upgrade/downgrade your live application from one version to other without downtime
- also supports rollback
- When the deployment image/image version is update, openshift will start the rolling update
- for each image version/tage, deployment controller will create one replicaset
- gradually the existing replicaset desired count will reduce, while the new replicaset desired count will increase gradually
- at one point, all the existing/old replicaset pods will be replaced with new pods using the new replicaset
</pre>

## Lab - Rolling update
```
oc project nginx
oc create deployment nginx --image=bitnami/nginx:latest --replicas=3 -o yaml --dry-run=client > nginx-deploy.yml
oc create -f nginx-deploy.yml --save-config
oc get deploy,rs,po
oc get po -o yaml | grep image
```

Expected output
![image](https://github.com/user-attachments/assets/dba0f48f-8a98-402e-a7ca-5c94841dd894)

Now, let's update the image name from bitnami/nginx:latest bitnami/nginx:1.26 in the nginx-deploy.yml and apply
![image](https://github.com/user-attachments/assets/a7cc6721-95d8-448f-bf0b-d875695b48a6)
![image](https://github.com/user-attachments/assets/5a1c9134-5b9b-4cba-96d9-ef12b96a2df5)
![image](https://github.com/user-attachments/assets/f7510bcc-51ad-4567-86ba-5cd6a420b961)
![image](https://github.com/user-attachments/assets/bb39b35b-154a-457c-bc2b-3761a94f9309)
![image](https://github.com/user-attachments/assets/88d16016-5620-429b-8a54-d06858ddd52a)

## Info - Unix tmux utility
<pre>
- With this unix/linux tool, you can split the windows horizontally/vertically
- to start tmux, the command you need to type in terminal is tmux
- Shortcut to split the window horizontally is Ctrl+B "
- Shortcut to split the window vertically is Ctrl+B %
</pre>

## Lab - Rollback
In case the recently upgrade application version is unstable, you could rollback to the previous stable version
```
oc rollout undo deploy/nginx
oc rollout status deploy/nginx
oc rollout history deploy/nginx
```

Expected output
![image](https://github.com/user-attachments/assets/c7722af7-a690-4eea-ac50-0c6fbef26c32)
![image](https://github.com/user-attachments/assets/584f9136-cc65-46c1-9a81-cdfccd957afb)
![image](https://github.com/user-attachments/assets/847a2b5c-7cc1-4884-887d-4dcb11f0dcd1)
![image](https://github.com/user-attachments/assets/cdd3ddab-1ce5-4530-9370-ce59d8dd5a6d)
![image](https://github.com/user-attachments/assets/b2b0db57-d31c-47d8-bac7-56eb1e61a597)
![image](https://github.com/user-attachments/assets/020eb7a4-866b-44d8-ae37-b40a1650b7cb)



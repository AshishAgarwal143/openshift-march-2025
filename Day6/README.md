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

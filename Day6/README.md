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
       name: nginx
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
![Uploading image.png…]()

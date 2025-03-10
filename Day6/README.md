# Day 6

## Lab - Deploying an application using declarative style
```
oc create deployment nginx --image=bitnami/nginx:latest --replicas=3 -o yaml --dry-run=client > nginx-deploy.yml
```

Let's update the nginx-deploy.yml as shown below
```
```

Let's create the deployment in declarative style using yaml file
```
oc create -f nginx-deploy.yml --save-config
oc get deploy,rs,po
```

Expected output
![image](https://github.com/user-attachments/assets/9fb27c11-92af-4e6d-9e9f-9ddeac5fa6ba)

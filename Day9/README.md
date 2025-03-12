# Day 9

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
oc apply -f ingress.yml
oc get ingress
```

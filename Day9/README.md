# Day 9

## Lab - Developing a spring-boot microservice application and deploy into Red Hat Openshift
<pre>
- In this lab exercise, you will take a simple spring-boot microservice application  
- Build a Custom Docker Image with multi-stage Dockerfile
- Push the custom docker image to Docker Hub
- Deploy application into Openshift using the recently pushed Custom Docker Image
</pre>

Let's compile the application locally
```
cd ~/openshift-march-2025
git pull
cd Day9/hello-microservice
mvn clean package
cd target
java -jar ./hello-1.0.0.jar
```

From another terminal tab, you can try accessing the hello microservice
```
curl http://localhost:8080
```

To stop the hello microservice, you to the terminal tab where you launched the application and press Ctrl+C.

Expected output
![image](https://github.com/user-attachments/assets/9557349a-15c0-4d56-afb9-a5b915417f90)
![image](https://github.com/user-attachments/assets/1dbda1ea-6259-4944-8ee7-7864859eeeb5)

Build a Custom Docker image for from application source code
```
cd ~/openshift-march-2025
git pull
cd Day9/hello-microservice
docker build -t tektutor/spring-hello-ms:1.0 .
docker image
```

Tag and push the image ( you won't be able to push to my docker hub account - this is just a demo )
```
docker images | grep tektutor/spring-hello-ms
docker tag tektutor/spring-hello-ms:1.0 tektutor/spring-hello-ms:latest
docker login
docker push tektutor/spring-hello-ms:latest
```

Let's now deploy the application declaratively pulling our custom image from Docker Hub
```
cd ~/openshift-march-2025
git pull
cd Day9/hello-microservice
oc delete project jegan
oc new-project jegan
oc get all
oc apply -f hello-deploy.yml
oc apply -f hello-svc.yml
oc apply -f hello-route.yml

oc get route
curl http://hello-jegan.apps.ocp4.alchemy.com
```

Expected output
![image](https://github.com/user-attachments/assets/bbb3fc54-82c0-4e03-94ec-d745032eb712)
![image](https://github.com/user-attachments/assets/28c37f59-b5c3-4734-9814-fabb7cee2c08)


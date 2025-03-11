# Day 7

## Lab - Deploying a Basic Spring Boot application into Openshift using Webconsole

Navigate to Openshift webconsole as a Developer
![image](https://github.com/user-attachments/assets/50045036-1015-4315-9426-7b9aae6ef54b)

Click +Add
![image](https://github.com/user-attachments/assets/17c02e9d-9643-435b-8b4f-9775df95e375)

Under "Getting started resources", select "View all samples"
![image](https://github.com/user-attachments/assets/5af999e3-6747-4e32-a649-e0909e5b7e3b)
![image](https://github.com/user-attachments/assets/58580ca4-78f1-447e-b3ee-589030fbe889)

Scroll down and select "Basic Spring Boot"
![image](https://github.com/user-attachments/assets/a85a1964-00b9-4a3c-a7a7-e64aa3fbb44f)
![image](https://github.com/user-attachments/assets/d5a70fe4-e76d-43f9-beb0-6400634da23c)
![image](https://github.com/user-attachments/assets/87fa1026-f1d5-4596-916d-a0b3c5117c38)
Click "Create"
![image](https://github.com/user-attachments/assets/fd2b17ad-47ef-4f38-8759-4b61ce93743e)

Build status
![image](https://github.com/user-attachments/assets/6005c1ed-9de9-425d-bfe1-28aa5620b6e7)
![image](https://github.com/user-attachments/assets/c2caea7e-d8ed-485d-9048-b77b9e6685f7)
![image](https://github.com/user-attachments/assets/14ffc710-1b4b-4f9e-a8d5-c7999a10cb2d)
![image](https://github.com/user-attachments/assets/eb9c406a-540e-4d6b-833d-20b4fb2c3435)
![image](https://github.com/user-attachments/assets/70360a51-22f1-4ba7-b1fb-fd5a03579fc7)


## Lab - Deploying .Net Application into Openshift from webconsole

Navigate to Openshift webconsole as a Developer
![image](https://github.com/user-attachments/assets/50045036-1015-4315-9426-7b9aae6ef54b)

Click +Add
![image](https://github.com/user-attachments/assets/17c02e9d-9643-435b-8b4f-9775df95e375)

Under "Getting started resources", select "View all samples"
![image](https://github.com/user-attachments/assets/5af999e3-6747-4e32-a649-e0909e5b7e3b)

Select ".Net 8 Build Images"
![image](https://github.com/user-attachments/assets/4f505d06-d784-495f-a252-becd634412f5)
![image](https://github.com/user-attachments/assets/d74cd6a7-f32e-4b8c-bc0a-6ededd6d4b7c)
Click "Create"

Build Progress
![image](https://github.com/user-attachments/assets/b2bfa69c-8ca8-47d7-8243-b71ab1e1607a)
![image](https://github.com/user-attachments/assets/ebfe236a-5cff-4134-b77f-1a2df93bbf09)
![image](https://github.com/user-attachments/assets/7ccde925-70bd-4688-bb32-e77135778c53)
![image](https://github.com/user-attachments/assets/e6f7502f-3e18-4b3a-9af1-4121e1ee43a6)
![image](https://github.com/user-attachments/assets/f4481145-7aff-4705-b201-b86dd9c674ad)
![image](https://github.com/user-attachments/assets/d900d416-a9f1-4e32-98ca-d3fa9b0ec29d)

Click on the route url ( upward arrow ), you need to add the url removing the http into the /etc/hosts file as an Administrator
![image](https://github.com/user-attachments/assets/d7e608c9-55fc-412e-a934-04346c9a200c)
![image](https://github.com/user-attachments/assets/974fe433-95cc-415d-997b-7fbdcee8a812)
![image](https://github.com/user-attachments/assets/33661a0c-3227-4eb0-ab47-f8800b2f037c)

## Info - BuildConfig
<pre>
- is a yaml file that takes GitHub url as an input
- it is a configuration file
- it takes the deployment strategy as parameter ( source, docker, etc., )
- it creates an output ( Image Stream )
  - the output can be a Container Image that will be pushed into Openshift's Internal Image Registry
  - the output can be a Container Image that will be pushed into JFrog Artifactory Private Image Registry
- BuildConfig.yaml or yml can be created either manually or Openshift can generate it for you
- In case, you wish to create a BuildConfig.yml, it gives complete flexibility 
</pre>

## Info - Build
<pre>
- When we start a build from the BuildConfig, it makes an instance of the BuildConfig called Build
- Each time, you start a build from a BuildConfig, it creates a Build with unique name
- Build Controller monitors Build resources,
  - Whenever someone creates a Build in any namespace
  - Updates a build in any namespace
  - Deletes a build in any namespace
  - will receives events from API Server if any of the above events occurs
- Build Controller reads the Build and then it creates Pod and starts the Build with the pod
  - the Build can be compiling and packaging an application binary
  - the Build can be building a Container Image
</pre>

## Info - Persistent Volume (PV)
<pre>
- is an external storage
- this could be shared network path, typically NFS shared path
- this could be a AWS EBS, AWS S3 bucket, or any storage solution
- we are not supposed to storing application data and logs in the temporary container/pod storage, hence we will be using an external storage which is permanent
- This is typically created by System Administrators or Openshift Administrators
- System Administrators create the persistent volume in the cluster scope, i.e any project can claim and use it
- But only application deployment will be able to use a PV at at time
- It takes following attributes
  - size of the storage
  - access mode
  - type of storage
  - storageclass ( optional )
</pre>

## Info - Persistent Volume Claim (PVC)
<pre>
- any application that runs within Kubernetes/Openshift can request for external storage using PVC  
- it takes the following attributes
  - size of the storage required
  - access mode
  - type of storage
  - storageclass ( optional )
</pre>

## Info - Peristent Volume StorageClass
<pre>
- Persistent Volumes can be manually provisioned by System Administrators or Openshift Administrators
- Persistent Voluems can also be dynamically provisioned using a storageclass
- we could create storageclass for NFS, AWS EBS, etc by defining a yaml file
- If a Storage for NFS is active in the cluster, when applications request for storage via PVC, the PV will automatically provisioned as per the PVC contstraints
</pre>  

## Info - Storage Controller
<pre>
- When a Pod/Deployment requests for storage by way of PVC, the Storage Controller scans the entire cluster looking for a matching PV
- If the Storage Controller is able to find a matching PV, it will let the PVC claim and use the storage
- In case the Storage Controller is not able to find a maching PV, the Pod that depends on it will be kept in Pending state until such a PV is provisioned either via Storage dynamically or manually by the Openshift Administrators
</pre>

## Lab - Clone the TekTutor Training Repository
```
cd ~
git clone https://github.com/tektutor/openshift-march-2025.git
cd openshift-march-2025
```

## Lab - Deploying a multi-pod application using declarative style that uses Persistent Volumes and Persistent Volume Claims
```
cd ~/openshift-march-2025
git pull
cd Day7/declarative-manifest-scripts
./deploy.sh
```

Expected output
![image](https://github.com/user-attachments/assets/1ef4f639-84dc-4694-bba7-3d260f65f1e9)
![image](https://github.com/user-attachments/assets/a1361da4-fd98-4269-afa9-60dbf09b9754)
![image](https://github.com/user-attachments/assets/e1f3afd1-bca3-46b6-9a9b-e526124cf4e6)
![image](https://github.com/user-attachments/assets/0df56d93-eedc-4781-abcc-6e7e976ee145)
![image](https://github.com/user-attachments/assets/747e08e1-9abc-4ccf-b35e-4247fcd2b5df)
![image](https://github.com/user-attachments/assets/f8b9fac8-62d7-4db9-8fb4-2dce4204b6b2)
![image](https://github.com/user-attachments/assets/5592bf2e-374b-4bb6-b901-1e3ce78414cf)
![image](https://github.com/user-attachments/assets/df24d6d4-81be-4a94-bf38-ef7fc10280c2)
![image](https://github.com/user-attachments/assets/0fc1ff19-e11f-4a15-98de-54b6a0badff5)
![image](https://github.com/user-attachments/assets/e1a90519-eced-4200-9cab-48a6c8cf857a)
![image](https://github.com/user-attachments/assets/5e29176f-bd87-4cbc-a866-738c7b29fefd)
![image](https://github.com/user-attachments/assets/ffd9170b-053f-4cea-9da7-a382cc5a2673)
![image](https://github.com/user-attachments/assets/ed0fe226-9ece-4e25-b2e6-d5f70979cc76)
![image](https://github.com/user-attachments/assets/62d29d03-07b6-4d64-a173-5eab340bdab7)
![image](https://github.com/user-attachments/assets/8774305e-7a22-421a-9a44-194f90dff7bc)
![image](https://github.com/user-attachments/assets/69a1d747-a76d-467b-a05d-dee898f42eb6)
![image](https://github.com/user-attachments/assets/6094f79e-83c0-4fc6-9f57-4784f8e581cb)

## Lab - Checking events pertaining to a pod
```
oc get po
oc events --for pod/mariadb-c97d89cc5-t8xdm
oc events --for pod/wordpress-5d9f8
```
![image](https://github.com/user-attachments/assets/86c723f2-7411-42ef-8997-1f7c980ce5ef)


## Lab - Using secret to store mysql login credentials and configmaps to store non-sensite key/values
```
cd ~/openshift-march-2025
git pull
cd Day7/declarative-manifest-scripts/after-refactoring
./deploy.sh
```

Expected output

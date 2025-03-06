![image](https://github.com/user-attachments/assets/6599da9d-048d-4505-abda-20e48b2abfc7)# Day 4

## Lab - Check the client version
```
kubectl version
oc version
```

Expected output
![image](https://github.com/user-attachments/assets/5775dd06-edb9-4978-9947-c82254077033)


## Lab - Listing Openshift cluster nodes
```
oc get nodes
```

Expected output
![image](https://github.com/user-attachments/assets/a8c6291f-c817-43b4-b006-8ac265fc709e)

## Lab - Finding more details about the node
```
oc describe node master01.ocp4.alchemy.com
```

Expected output
![image](https://github.com/user-attachments/assets/62618c30-a18c-4111-83bb-511290651bb2)
![image](https://github.com/user-attachments/assets/a91d32c0-019a-480d-8c8d-73b4bd245cc2)
![image](https://github.com/user-attachments/assets/a698b091-3edf-4941-9f0d-3761b2ac521d)

## Info - Openshift Pod Network
<pre>
- Openshift cluster wide (IP Range ) - Pod Network - 10.0.0.0/8  
- Openshift will break this range of IP addresses into for each node
  - Master 1 Node - 10.28.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Master 2 Node - 10.29.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Master 3 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Worker 1 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Worker 2 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
  - Worker 3 Node - 10.30.0.0/24 ( Total IP addresses in this subnet - 250 )
</pre>

## Lab - Getting the node definition as yaml or json
```
oc get node master01.ocp4.alchemy.com -o yaml
oc get node master01.ocp4.alchemy.com -o json
```
Expected output
![image](https://github.com/user-attachments/assets/94a3f964-9986-4ebd-a971-ded1cb611df5)

## Info - Openshift Hierarchy
<pre>
- Node ( Server )
  - Namespace 
     - Pod 1
       - Container 1
       - Container 2
</pre>  

## Info - Openshift Project
<pre>
- Openshift project is nothing but Kubernetes namespace with access restrictions  
- If we don't create a project before deploy our applications, it gets deployed onto default project
- Its always a best practice to create your own project before deploying applications
- one project can host many applications
</pre>

## Lab - Finding the IP address of openshift nodes
```
oc get nodes -o wide
```
Expected output
![image](https://github.com/user-attachments/assets/7d21175f-b950-422f-85d1-f143f3083e21)

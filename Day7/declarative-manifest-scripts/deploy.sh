echo "\nDeploying mariadb ..."
oc apply -f mariadb-pv.yml
oc apply -f mariadb-pvc.yml
oc apply -f mariadb-deploy.yml
oc apply -f mariadb-service.yml

echo "\nDeploying wordpress ..."
oc apply -f wordpress-pv.yml
oc apply -f wordpress-pvc.yml
oc apply -f wordpress-deploy.yml
oc apply -f wordpress-service.yml
oc apply -f wordpress-route.yml

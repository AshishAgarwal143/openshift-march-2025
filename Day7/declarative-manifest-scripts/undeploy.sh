echo "\nUndeploying wordpress ..."
oc delete -f wordpress-route.yml
oc delete -f wordpress-service.yml
oc delete -f wordpress-deploy.yml
oc delete -f wordpress-pvc.yml
oc delete -f wordpress-pv.yml

echo "\nUndeploying mariadb ..."
oc delete -f mariadb-service.yml
oc delete -f mariadb-deploy.yml
oc delete -f mariadb-pvc.yml
oc delete -f mariadb-pv.yml

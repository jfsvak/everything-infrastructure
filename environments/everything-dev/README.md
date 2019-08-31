## Steps to establish everything-dev backend services and database

#### Establish openshift project
1. `oc login -u developer`
1. `oc new-project everything-dev`
1. `oc project everything`

#### Create mysql database in a container
In repo: everything-infrastructure
1. `oc apply -f mysql-dev.yaml`

#### Prepare database with 2 schemas, one for app, and one for identity server
1. Find pod for mysql  
   `oc get pods`
2. Port forward to mysql container  
   `oc port-forward <podname> 33306:3306`

3. Connect to mysql  
   `mysql -u root -P 33306 -p`  
   Enter password from containers env var `MYSQL_ROOT_PASSWORD` in mysql-dev.yaml

5. Run script from (atm in everything-staging)  
   `setup-db-everything.sql`

#### Get dotnet image into openshift
1. `& minishift docker-env | Invoke-Expression`
1. `docker pull mcr.microsoft.com/dotnet/core/sdk`
1. `docker tag mcr.microsoft.com/dotnet/core/sdk 172.30.124.220:5000/openshift/dotnetsdk`
1. (Not really needed, but will trigger a rebuild and deploy) `docker push 172.30.124.220:5000/openshift/dotnetsdk`

#### Create everything-dev backend 
1. `oc apply -f everything-dev.yaml`
2. Trigger build with (repo: everything):  
   `oc start-build bc/everything-dev --from-repo=.`

### Steps to deploy everything-uiapp-dev UI app in container
1. Create objects for everything-uiapp (repo: everything-infrastructure):  
   `oc apply -f everything-uiapp-dev.yaml`  
   The BuildConfig points to ImageStreamTag nodejs:10 in openshift namespace, which is part of Openshift.  
   (Login `oc login -u system:admin` and run `oc get is --namespace=openshift` or `oc describe is/nodejs --namespace=openshift` to view the builder image info)
1. Create tar archive with source code only (repo: everything):  
   `create-uiapp-tar.bat`
2. Trigger build with tar-archive as input (repo: everything):  
   `oc start-build bc/everything-uiapp-dev --from-archive=everything-uiapp.tar`
   
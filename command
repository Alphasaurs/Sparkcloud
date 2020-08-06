gcloud auth list

gcloud config list project

gcloud beta interactive //best command

gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone us-central1-c //create vm instances using gcloud shell

gcloud compute ssh gcelab2 --zone us-central1-c //you can SSH into your instance

export PROJECT_ID=<your_project_ID> //Setting environment variables
export ZONE=<your_zone>             //Setting environment variables

gcloud -h //help

gcloud config list

gcloud components list

sudo apt-get install google-cloud-sdk //install beta components

***********************************KUBERNETES ENGINE CLUSTER**********************************
gcloud config set compute/zone us-central1-a //compute zone

gcloud container clusters create [CLUSTER-NAME] //create cluster

gcloud container clusters get-credentials [CLUSTER-NAME] //authenticate the cluster 
till now we created cluster ,now just deploy containerized application to it

kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0 //deploying

kubectl expose deployment hello-server --type=LoadBalancer --port 8080 //expsose to external

kubectl get service //you will get external ip

http://[EXTERNAL-IP]:8080 //run by checking

gcloud container clusters delete [CLUSTER-NAME] //delete cluster

***********************************/KUBERNETES ENGINE CLUSTER**********************************

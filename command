gcloud auth list

gcloud config list project

gcloud beta interactive //best command

gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone us-central1-c //create vm instances using gcloud shell

gcloud compute ssh gcelab2 --zone us-central1-c //you can SSH into your instance

export PROJECT_ID=<your_project_ID> //Setting environment variables
export ZONE=<your_zone>             //Setting environment variables

gcloud -h //help

gcloud config list

gcloud config set compute/zone us-central1-a //set zone

gcloud config set compute/zone us-central1-a  //set region

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


***********************************Create multiple web server instances**********************************
1.A startup script to be used by every virtual machine instance to setup Nginx server upon startup
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

2.An instance template to use the startup script
gcloud compute instance-templates create nginx-template \
--metadata-from-file startup-script=startup.sh

3.A target pool
gcloud compute target-pools create nginx-pool

4.A managed instance group using the instance template
gcloud compute instance-groups managed create nginx-group \
         --base-instance-name nginx \
         --size 2 \
         --template nginx-template \
         --target-pool nginx-pool
         
 5.you will see 2 instances 
 gcloud compute instances list
 
 6.configure a firewall
 gcloud compute firewall-rules create www-firewall --allow tcp:80

***********************************/Create multiple web server instances**********************************

***********************************Create a Network Load Balancer**********************************
1.Create an L3 network load balancer
gcloud compute forwarding-rules create nginx-lb \
         --region us-central1 \
         --ports=80 \
         --target-pool nginx-pool
         
2.list all compute engine forwarding rules 
gcloud compute forwarding-rules list
         
***********************************/Create a Network Load Balancer**********************************

***********************************L7 Create a HTTP(s) Load Balancer**********************************
1.create a health check
gcloud compute http-health-checks create http-basic-check

2.Define an HTTP service and map a port name to the relevant port for the instance group.
gcloud compute instance-groups managed \
       set-named-ports nginx-group \
       --named-ports http:80
3.Create a backend service:
gcloud compute backend-services create nginx-backend \
      --protocol HTTP --http-health-checks http-basic-check --global
      
4.Add the instance group into the backend servic
gcloud compute backend-services add-backend nginx-backend \
    --instance-group nginx-group \
    --instance-group-zone us-central1-a \
    --global
    
5.Create a default URL map that directs all incoming requests to all your instance
gcloud compute url-maps create web-map \
    --default-service nginx-backend
 
6.Create a target HTTP proxy to route requests to your URL map:
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map
7.Create a global forwarding rule to handle and route incoming requests.    
gcloud compute forwarding-rules create http-content-rule \
        --global \
        --target-http-proxy http-lb-proxy \
        --ports 80
   
9.list all
gcloud compute forwarding-rules list
***********************************/Create a HTTP(s) Load Balancer**********************************

# Assuming the acdnd-c4-project resource group is still available with you
# ACR name should not have upper case letter
az acr create --resource-group acdnd-c4-project --name acrjckuri --sku Basic
# Log in to the ACR
az acr login --name acrjckuri
# Get the ACR login server name
# To use the azure-vote-front container image with ACR, the image needs to be tagged with the login server address of your registry. 
# Find the login server address of your registry
az acr show --name acrjckuri --query loginServer --output table
# Associate a tag to the local image. You can use a different tag (say v2, v3, v4, ....) everytime you edit the underlying image. 
docker tag azure-vote-front:v1 acrjckuri.azurecr.io/azure-vote-front:v1
# Now you will see acrjckuri.azurecr.io/azure-vote-front:v1 if you run "docker images"
# Push the local registry to remote ACR
docker push acrjckuri.azurecr.io/azure-vote-front:v1
# Verify if your image is up in the cloud.
az acr repository list --name acrjckuri --output table
# Associate the AKS cluster with the ACR
az aks update -n udacity-cluster -g acdnd-c4-project --attach-acr acrjckuri





# Get the ACR login server name
az acr show --name acrjckuri --query loginServer --output table
# Make sure that the manifest file *azure-vote-all-in-one-redis.yaml*, has `acrjckuri.azurecr.io/azure-vote-front:v1` as the image path.  
# Deploy the application. Run the command below from the parent directory where the *azure-vote-all-in-one-redis.yaml* file is present. 
kubectl apply -f azure-vote-all-in-one-redis.yaml
# Test the application at the External IP
# It will take a few minutes to come alive. 
kubectl get service azure-vote-front --watch
# You can also verify that the service is running like this
kubectl get service
# Check the status of each node
kubectl get pods
# Push your local changes to the remote Github repo, preferably in the Deploy_to_AKS branch


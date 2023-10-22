# DevOps/SRE Technical Test

How To

### For Build Image, Push to Docker Hub Repository and Run Container : 
1. Clone Repository

2. Copy env-dist to .env

3. Setup variable from .env
- DOCKER_HUB_USERNAME	= Your Docker Hub Account
- DOCKER_HUB_PASSWORD	= Your Password Login To Docker Hub
- DOCKER_IMAGE_NAME	= Your Image Name
- TAG	                = Your Tag Image

4. Run file build-push-run.sh with command :
- ./build-push-run.sh

### For .gitlab-ci.yml
You can set up GitLab CI/CD environment variables for sensitive information like SSH private keys and known hosts in your project settings to keep them secure. This example assumes you have set up environment variables ${SSH_PRIVATE_KEY} and ${SSH_KNOWN_HOSTS}.

### For Deploy Image to Kubernetes Cluster
1. Open Directory kubernetes-manifest
2. Run file kubernetes Manifest Deployment.yaml With Command :
- kubectl apply -f deployment.yaml

### For Apply Ansible To Server For Tasks Pull Source Code From Your Github With Repo Name devops-mif_repo
1. Open Directory ansible
2. Run Ansible Command
- ansible-playbook -i hosts main.yml

### For Apply Terraform Script Create EC2 Instance
1. Open Directory terraform
2. Run Command :
- terraform init
- terraform plan
- terraform apply

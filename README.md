## End to End DevOps
### What is it?
End-to-End DevOps is a project that creates the automation processes from committing a code to a version control system to deploying it to the production environment. It includes creating infrastructure, environment and CI/CD pipelines.

### What tools were used?
- Application: Java Spring Boot Framework
- Source Control Management: Gitlab
- Build: Maven
- Continuous Integration: Jenkins
- Continuous Deployment: ArgoCD
- Repository: Nexus
- Test: Sonarqube
- Configuration Management: Ansible
- Infrastructre Provisioning: Terraform
- Container Runtime: Docker
- Container Orchestration: Kubernetes
- Compute: Google Cloud Provider
- Database: MySQL
- Operating System: CentOS 8
### 1- Creating Infrastructure - Terraform
First of all, we need to create infrastructure which includes servers, network and firewall rules. We will use Google Cloud Provider for this. You can get 300 $ free balance for 3 months. All you need is a new Google account. This is more than enough for this project. 
We will use Terraform to create servers, network and firewall rules. Since we need to create many servers and configure many things, Terraform script will simplify all these things. Let's start.
First we need to create 2 different images on Gcp. On default, CentOS 8 images don't allow to ssh themselves with using root password. We can use ssh keys, but this will simplify things. Second image is for Ansible. We will install Ansible and take image of that. So after we execute Terraform script. Ansible will be ready to go for configuration management.
We need to create a CentOS 8 image manually for one time and use these commands;
```shell
dnf update
```
```shell
sudo su root
cd
passwd root
```
Change to password of your will.
```shell
vi /etc/ssh/sshd_config
```
Change “PermitRootLogin” to “yes” and “PasswordAuthentication” to “yes”, then save and close.
```shell
service sshd restart
```
Take the image and execute these commands for install Ansible.
```shell
dnf epel-release
```
```shell
dnf ansible
```
Take the image and we are ready to go. 
Now we need to install Terraform. You can download Windows version of Terraform in [here](https://www.terraform.io/downloads.html "here"). We will install Terraform on our local computer and connect to GCP. After you extract Terraform, don't forget to configure environment parameters. We also need a credentials.json file that Terraform use for connecting to Gcp. I advise you to create a new service account for Terraform on Gcp and from it get the necessary keys for json file. Then open main.tf file on the repository with your favored code editor. You need to replace the "your-ip" lines in the main.tf file with your ip. These firewall rules allow only us to access interfaces like Jenkins. Also be careful for image names. You can change the lines with your image names. To execute Terraform script use these;
```shell
terraform init
```
```shell
terraform plan
```
```shell
terraform apply
```
Now check on Gcp. Instances, network and firewall rules should be created. 
### 2- Creating Environment - Ansible
Ssh into ansible-controller instance and upload IAC_role folder to the server. In IAC_role folder, execute this command;
```shell
ansible-playbook main.yaml -i inventory.txt
```
It will take a while. Ansible will create baremetal 1 Master 2 Slave Kubernetes cluster, Jenkins, Gitlab, Nexus and Sonarqube. All configurations will be done and ready to go. 
### 3- Gitlab
You can access Gitlab with http://gitlab-external-ip . After that, you should create a project that contains the application source code. To do this in your local computer enter folder which contains application and write these one by one in command window;
```shell
git init
git remote add origin your-repo-address
git add .
git commit -m "Initial commit"
git push -u origin master
```
You should be able to see your application code on Gitlab project that you created like this;

![resim](https://user-images.githubusercontent.com/60771816/120084540-c75b0780-c0d9-11eb-8442-4cf7b90658de.png)

Also we need to create a webhook to integrate Gitlab with Jenkins. Go to project that you created --> Settings --> Webhooks . Write URL area http://jenkins-external-ip:8080/generic-webhook-trigger/invoke . Write Secret token elveslibraryapp . Tick Push Events and add webhook.
### 4- Nexus
You can access Nexus with http://nexus-external-ip:8081 . After you login Nexus, click on settings symbol --> Repositories --> Create repository --> docker (hosted) . Configure like this;

![resim](https://user-images.githubusercontent.com/60771816/120084552-df328b80-c0d9-11eb-95e4-ecf72c56a29e.png)

### 5- Sonarqube
You can access Sonarqube with http://sonarqube-external-ip:9000 . After you login Sonarqube, click on A, right top corner --> My Account --> Security --> Generate Tokens . Save this generated token. We will use it for Jenkins. Then, go to Administration --> Configuration --> Webhooks --> Create . Write URL area http://jenkins-external-ip:8080/sonarqube-webhook/ . 
### 6- Jenkins
You can access Jenkins with http://jenkins-external-ip:8080 . After you login Jenkins interface, install suggested plugins. We need to configure a couple of things.
1. Go to Manage Jenkins --> Manage Plugins --> Available . Install these plugins;
     - Docker Pipeline
     - Pipeline Utility Steps
     - Sonarqube Scanner
     - Generic Webhook Trigger
2. We need to set credentials. Go to Manage Jenkins --> Manage Credentials --> Jenkins --> Global Credentials --> Add Credentials .
     - Gitlab Username with password
     - Nexus Username with password
     - Sonarqube secret text
3. Go to Manage Jenkins --> Configure System --> Sonarqube servers --> Add SonarQube . Configure like this;
4. 
![resim](https://user-images.githubusercontent.com/60771816/120084807-f07c9780-c0db-11eb-8971-d6cfb8b9d899.png)

 
4. Go to Manage Jenkins --> Global Tool Configration --> Sonarqube Scanner --> Add Sonarqube Scanner . Configure like this;

![resim](https://user-images.githubusercontent.com/60771816/120084793-d17e0580-c0db-11eb-8248-dc6232f11169.png)

 

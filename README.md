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
We need to create a CentOS 8 image manually for one time and use these commands.
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

Now we need to install Terraform. You can download Windows version of Terraform in [here](https://www.terraform.io/downloads.html "here"). We will install Terraform on our local computer and connect to GCP. After you extract Terraform, don't forget to configure environment parameters. We also need a credentials.json file that Terraform use for connecting to Gcp. I advise you to create a new service account for Terraform on Gcp and from it get the necessary keys for json file. Then open main.tf file on the repository with your favored code editor. You need to replace the "your-ip" lines in the main.tf file with your ip. These firewall rules allow only us to access interfaces like Jenkins.

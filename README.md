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
### Creating Infrastructure - Terraform
First of all, we need to create infrastructure which includes servers, network and firewall rules. We will use Google Cloud Provider for this. You can get 300 $ free balance for 3 months. All you need is a new Google account. This is more than enough for this project. 
We will use Terraform to create servers, network and firewall rules. Since we need to create many servers and configure many things, Terraform script will simplify all these things. Let's start.
First we need to install Terraform. You can download Windows version of Terraform in [here](https://www.terraform.io/downloads.html "here"). I will install Terraform on my local computer and connect to GCP. After you extract Terraform, you need to configure environment parameters like this;
![resim](https://user-images.githubusercontent.com/60771816/120073923-1b96c500-c0a3-11eb-8663-5c3987c07059.png)

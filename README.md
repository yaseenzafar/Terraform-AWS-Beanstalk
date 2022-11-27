# _**Brief Description**_:

This project uses Terraform which leverages AWS Cloudformation to deploy Highly available and scalable Wordpress Application. It consists of multiple files:
- provider.tf -> Defines the provider which in this case is AWS and region as well.
- main.tf -> creates AWS Beanstalk Environment which uses PHP 8.1 application on OS Amazon Linux 2. It also creates application load balancer, scaling triggers as well as redirection of traffic from port 80 to 443.
- rds.tf -> creates RDS instance and the engine used is mysql.
- sns.tf -> creates SNS topic and subscription.
- cloudwatch.tf -> creates cloudwatch alarm based upon CPUutilization metric and sends alert to SNS topic.

# _**Setup AWS CLI**_:

Windows:
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html

Linux:
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html


# _**Configure AWS CLI**_:

In Terminal or Command prompt:


```bash
 aws configure
 
 AWS Access Key ID: [****************9UIK]:
 
 AWS Secret Access Key: [****************SSxdr]:
 
 Default region name: "region" (example: eu-west-1)
 
 Default output format: "output" (example: json)
```


# _**Terraform Installation**_:

https://k21academy.com/terraform-iac/terraform-installation-overview/


# _**Infrastructure Deployment**_:

```bash
terraform init

#for checking if there is any configuration related issue
terraform plan 

#if getting error run this second time
terraform deploy -auto-approve 
```


# _**Manual Steps**_:

## Downloading WordPress:

Login to the server and enter following commands to download Wordpress:

```bash
  wget https://wordpress.org/latest.tar.gz
  tar -xzvf latest.tar.gz
```

1. Move the downloaded file/folder to the web server directory. 
2. Once this is done, you will grab the load balancer link and add A record in Route53 service. 
3. After propagation, use that the new link to browse to browser where you can configure Wordpress and if proper configuration is done. You will see a test page of hello-world.

## SNS subscription approval:

After SNS Service is created, manually subscribe SNS topic from email inbox. 



# _**Architecture**_:

![App Screenshot](https://raw.githubusercontent.com/yaseenzafar/Terraform-AWS-Beanstalk/main/Terraform%20and%20AWS%20Beanstalk%20architecture.png)




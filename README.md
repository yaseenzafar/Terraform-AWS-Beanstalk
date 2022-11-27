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

Login to the server and enter following commands to download Wordpress:

```bash
  wget https://wordpress.org/latest.tar.gz
  tar -xzvf latest.tar.gz
```

1. Move this to the web server directory. 
2. This is done, you will grab the load balancer link and add A record in Route53 service. 
3. After propagation, use that the new link to browse to browser where you can configure Wordpress and if proper configuration is done. You will see a test page of hello-world.

# _**Architecture**_:

![App Screenshot](https://raw.githubusercontent.com/yaseenzafar/Terraform-AWS-Beanstalk/main/Terraform%20and%20AWS%20Beanstalk%20architecture.png)

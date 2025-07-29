# Tomcat EC2 with EFS and Load Balancer

This project sets up an infrastructure on AWS using Terraform that includes EC2 instances running Tomcat, an EFS volume for shared storage, and a load balancer to distribute traffic among the EC2 instances.

## Project Structure

- `main.tf`: Main Terraform configuration file that defines the overall infrastructure.
- `variables.tf`: Input variables for customization of the infrastructure.
- `outputs.tf`: Outputs of the Terraform configuration.
- `modules/`: Contains submodules for EC2, EFS, and Load Balancer.
  - `ec2/`: Module for creating EC2 instances.
  - `efs/`: Module for creating the EFS volume.
  - `load-balancer/`: Module for creating the load balancer.
- `terraform.tfvars.example`: Example variable file for user customization.
- `versions.tf`: Specifies required provider and Terraform versions.

## Setup Instructions

1. **Install Terraform**: Ensure you have Terraform installed on your machine. You can download it from [terraform.io](https://www.terraform.io/downloads.html).

2. **Configure AWS Credentials**: Make sure your AWS credentials are configured. You can set them up using the AWS CLI or by creating a `~/.aws/credentials` file.

3. **Clone the Repository**: Clone this repository to your local machine.

4. **Customize Variables**: Copy `terraform.tfvars.example` to `terraform.tfvars` and customize the variables as needed.
```
   # Set AWS credentials as environment variables for Terraform
   export TF_VAR_aws_access_key="access"
   export TF_VAR_aws_secret_key="secret"
   export TF_VAR_aws_region="us-east-1"

   # Alternative: Set AWS credentials directly (Terraform will pick these up automatically)
   export AWS_ACCESS_KEY_ID="access"
   export AWS_SECRET_ACCESS_KEY="secret"
   export AWS_DEFAULT_REGION="us-east-1"

   # Additional Terraform variables for the project
   export TF_VAR_project_name="tomcat-efs-cluster"
   export TF_VAR_environment="dev"
   export TF_VAR_instance_type="t3.medium"
   export TF_VAR_key_pair_name="tcat"
```
5. **Initialize Terraform**: Navigate to the project directory and run:
   ```
   terraform init
   ```

6. **Plan the Infrastructure**: Run the following command to see what resources will be created:
   ```
   terraform plan
   ```

7. **Apply the Configuration**: To create the infrastructure, run:
   ```
   terraform apply
   ```

8. **Access Tomcat**: Once the infrastructure is up, you can access the Tomcat application using the DNS name of the load balancer.

## Outputs

After the infrastructure is created, the following outputs will be displayed:
- Load Balancer DNS Name
- EC2 Instance IDs
- EFS File System ID

## Cleanup

To destroy the infrastructure and remove all resources, run:
```
terraform destroy
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.
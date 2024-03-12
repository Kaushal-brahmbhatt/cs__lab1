# My CLoud Security Project

This project contains Terraform configuration files for managing infrastructure on AWS.

## Description
This project demonstrates the creation of an IAM role and associated policy using Terraform. It also showcases how to create AWS resources using the created IAM role and subsequently disassociate the policy from the role and remove the role itself.

## Tasks Completed
1. Created an IAM role named "cs_ec2_role" using Terraform.
2. Defined a granular policy named "cs_ec2_policy" allowing specific actions on AWS resources.
3. Associated the "cs_ec2_policy" with the "cs_ec2_role".
4. Utilized the "cs_ec2_role" to create AWS resources required for the infrastructure.
5. Disassociated the "cs_ec2_policy" from the "cs_ec2_role".
6. Removed the "cs_ec2_role".

## Running the Code
To run the Terraform code:
1. Make sure you have Terraform installed on your machine.
2. Clone this repository to your local machine.
3. Navigate to the project directory in your terminal.
4. Run `terraform init` to initialize the project.
5. Run `terraform apply` and follow the prompts to apply the changes.
6. After completing the tasks, you can verify the created resources in your AWS account.

## To Disassociate the policy from the role & To Remove the role. 
1. Get the IAM Role Name
-> role_name=$(terraform output -raw cs_ec2_role_name)

2. Get the Policy ARN
-> policy_arn=$(terraform output -raw cs_ec2_policy_arn)

3. Get the IAM Instance Profile Name
-> instance_profile_name=$(terraform output -raw cs_ec2_instance_profile_name)

4. Detach IAM Policy from Role
-> aws iam detach-role-policy --policy-arn $policy_arn --role-name $role_name

5. Remove IAM Role from Instance Profile
-> aws iam remove-role-from-instance-profile --role-name $role_name --instance-profile-name $instance_profile_name

6. Delete Instance Profile
-> aws iam delete-instance-profile --instance-profile-name $instance_profile_name

7. Delete IAM Role
-> aws iam delete-role --role-name $role_name

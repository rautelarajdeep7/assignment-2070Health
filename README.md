# assignment-2070Health

## Instruction to run terraform script locally
1. Install terraform in your system, Download aws cli tool.
2. Using "aws configure" command set you access key, secret key etc.
3. Go into the directory where all terraform files are present.
4. Start running below terraform commands in sequence:
  * terraform init
  * terraform validate
  * terraform plan
  * terraform apply

## Instructions to add AWS credentials to GitHub secrets
1. Go to the project repository
2. Click on Setting Tab of repository
3. From Left pane, Select Actions under the Secrets and Variables dropdown.
4. Now, click on Create New Repository secret
5. Add the Name of secret under Name and add the value to store under Secret.
* Do Step5 for AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_ECR_REPO . We are done setting AWS credentials to GitHub secrets

## GitHub Actions workflow build and push of Docker image to ECR.
1. Firstly it checks any push to main branch which triggers the workflow.cre
2. Job runs on ubuntu servers
3. Github Checkout to the repository
4. Setup our aws credentials using the secret keys provided and setting aws-region to us-east-1
5. Login to ecr registry is done.
6. commit hash and timestamp are used to be further used in random name generation for image.
7. docker build command it used to create image and docker push is used to push it to the repository in ECR registry with the generated name for image tag.

## Github actions workflow to provision EC2 instance using the terraform scripts.
1. Workflow triggers on push to maine branch OR on when the pull request is closed.
2. The whole task now runs on ubuntu server.
3. Firstly Github checkout the repository
4. Then AWS credentials are configured using the stored secret keys in Github.
5. Terraform setup is done in Github.
6. Bunch of commands are run, firstly directory changed to /terraform
7. Then terraform init runs and downloads the provider
8. terraform validate does all the validation required.
9. terraform plan generates the plan which tells what resources will be created/destroyed etc
10. terraform apply does the actual changes mentioned by terraform plan, resulting into infrastructure creation.


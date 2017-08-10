# aws-ecs-deploy-user

This project contains the necessary CloudFormation templates to create an AWS user with rights to:

- push docker images to ECR
- replace ECS task definitions

## How to Use

```sh
$ cd aws
$ ./provision.sh
Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - deploy-user
Deploy User Id: "deploy-user-user-..."
```

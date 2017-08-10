# aws-ecs-deploy-user

This project contains the necessary CloudFormation templates to create an AWS user with rights to deploy docker images to ECR and ECS.

## How to Use

Provisioning a new access key:
```sh
$ cd aws
$ ./provision.sh
Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - deploy-user
Getting access key info...
AccessKeyId: ...
SecretAccessKey: ...
```

If you need to rotate the key, you can add the `-rotate` or `-r` flags, i.e.
```sh
$ ./provision --rotate
```

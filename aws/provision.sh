#!/bin/sh

aws cloudformation deploy --template-file ./deploy-user.yaml --stack-name deploy-user --capabilities CAPABILITY_IAM

DEPLOY_USER_ID=`aws cloudformation describe-stacks --stack-name deploy-user --query "Stacks[0].Outputs[?OutputKey=='userId'].OutputValue | [0]"`

echo "Deploy User Id: $DEPLOY_USER_ID"

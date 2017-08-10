#!/bin/bash
serial='unset'

# ===============HELPER FUNCTIONS==================
help_menu () {
   echo "you can pass -rotate or -r to rotate the access key."
}

rotate_key () {
  echo "rotating key..."

  # get old serial
  serial=$(aws cloudformation describe-stacks \
    --stack-name deploy-user \
    --query "Stacks[0].Outputs[?OutputKey=='accessKeySerial'].OutputValue | [0]" \
    --output text)

  # increment
  serial=$((serial + 1))
}

deploy_stack () {
  # build deploy command
  cmd="aws cloudformation deploy \
    --template-file ./deploy-user.yaml \
    --stack-name deploy-user \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM"

  # if rotating, add parameter
  if [[ $serial != 'unset' ]]; then
    cmd="$cmd --parameter-overrides serial=$serial "
  fi

  $cmd
}

access_key_info () {
  echo "Getting access key info..."

  # get stack info
  info=$(aws cloudformation describe-stacks \
  --stack-name deploy-user \
  --query "Stacks[0].Outputs[?OutputKey=='accessKeyId' || OutputKey=='secretAccessKey']")

  # get and display access key id
  accessKeyId=$(echo $info | jq -r '.[] | select (.OutputKey=="accessKeyId").OutputValue')
  echo "AccessKeyId: $accessKeyId"

  # get and display secret access key
  secretAccessKey=$(echo $info | jq -r '.[] | select (.OutputKey=="secretAccessKey").OutputValue')
  echo "SecretAccessKey: $secretAccessKey"
}

# ===============MAIN LOGIC==================

while [ ! $# -eq 0 ]
do
  case "$1" in
    '--help' | '-h')
      help_menu
      exit
      ;;
    '--rotate' | '-r')
      rotate_key
      ;;
  esac
  shift
done

deploy_stack
access_key_info

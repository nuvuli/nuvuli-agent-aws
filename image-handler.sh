#!/bin/bash

set -x
set -e

MOD_DIR=$( dirname -- "$0"; )
ACCOUNT_ID=$1

aws ecr get-login-password --region us-east-1 \
    | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

curl https://app.nuvulicloud.com/downloads/nuvuli-agent-lambda.tar -o $MOD_DIR/nuvuli-agent-lambda.tar

docker load --input $MOD_DIR/nuvuli-agent-lambda.tar

docker tag public.ecr.aws/i5g1r9f3/agent \
    $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/nuvuli-agent:latest

docker push $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/nuvuli-agent:latest

docker rmi $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/nuvuli-agent

docker rmi public.ecr.aws/i5g1r9f3/agent

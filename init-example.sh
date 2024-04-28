#!/bin/bash

BRANCH=$1
ENV=$2

ENV=${ENV:-'dev'}
BRANCH=${BRANCH:-'main'}

DIRS=$(./terragrunt-dependency-resolver.sh $BRANCH)

TERRAGRUNT_INIT="cd $ENV && terragrunt run-all init --terragrunt-strict-include"

for DIR in ${DIRS[@]}; do
  TERRAGRUNT_INCLUDE_DIR=$(echo $DIR | grep ^$ENV | sed "s/^$ENV\/\?/.\//")

  if [[ ! -z $TERRAGRUNT_INCLUDE_DIR ]]; then
    TERRAGRUNT_INIT="$TERRAGRUNT_INIT --terragrunt-include-dir=$TERRAGRUNT_INCLUDE_DIR"
  fi
done

echo $TERRAGRUNT_INIT

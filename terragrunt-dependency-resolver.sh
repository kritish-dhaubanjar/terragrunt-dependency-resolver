#!/bin/bash

BRANCH=$1
BRANCH=${BRANCH:-"main"}

GIT_FILES=($(git diff origin/$BRANCH --name-only))

ENVIRONMENTS=('demo/' 'dev/' 'preprod/' 'preprod_drp/' 'prod/' 'qa/' 'staging/')

TARGETS=()
TARGET_DIRS=()

index=0

while true; do
  GIT_FILE="${GIT_FILES[$index]}"

  if [ -z $GIT_FILE ]; then
    break
  fi

  if [[ $(basename $GIT_FILE) == *.tf ]]; then
    GIT_FILE=$(dirname $GIT_FILE)
  fi

  GIT_FILE=$(sed -E 's#modules/##' <<< $GIT_FILE)

  DEPENDENCIES=($(grep --exclude-dir={.cache,.git,.github,.terragrunt-cache} -rl $GIT_FILE))

  for DEPENDENCY in "${DEPENDENCIES[@]}"; do
    GIT_FILES+=("$DEPENDENCY")
  done

  for environment in "${ENVIRONMENTS[@]}"; do
    if [[ $GIT_FILE == $environment* ]]; then
      TARGETS+=($GIT_FILE)
    fi
  done

  index=$(($index + 1))
done


for TARGET in "${TARGETS[@]}"; do
  dir=$(dirname $TARGET)

  EXISTS=false

  for TARGET_DIR in "${TARGET_DIRS[@]}"; do
    if [[ $dir == $TARGET_DIR ]]; then
      EXISTS=true
      break
    fi
  done

  if [[ $EXISTS == false ]]; then
    echo $dir
    TARGET_DIRS+=($dir)
  fi
done

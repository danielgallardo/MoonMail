#!/usr/bin/env sh

auto_deployable_services="events-router,"
if [[ $TRAVIS_PULL_REQUEST == "false" ]]; then
  for service in $changed_services
  do
    echo "-------------------Running packaging for $service---------------------"
    if [[ $auto_deployable_services = *"$service"* ]]; then
      cd $service && yarn install && yarn deploy:prod; cd ..
    fi
  done
fi

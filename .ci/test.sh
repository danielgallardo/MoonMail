echo "changed_services: $1"
for service in $1
#!/usr/bin/env sh

do
  echo "-------------------Running tests for $service---------------------"
  cd $service
  yarn install && yarn test
  if [[ $service == "lists-microservice" ]]; then
    wget ${ES_DOWNLOAD_URL}
    tar -xzf elasticsearch-${ES_VERSION}.tar.gz
    ./elasticsearch-${ES_VERSION}/bin/elasticsearch &
    wget -q --waitretry=3 --retry-connrefused -T 10 -O - http://127.0.0.1:9200
    yarn run test:integration
    #if [[ $TRAVIS_PULL_REQUEST == "false" ]]; then
      # yarn run test:system
    #fi
  fi
  cd ..
done

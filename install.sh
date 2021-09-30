#!/bin/sh

mkdir data
mkdir data/db

cd ..

read -p "Install erxes frontend (y/n): " efAnswer 

if [ "$efAnswer" != "n" ];
  then
    echo 'Installing erxes frontend'
    curl https://raw.githubusercontent.com/erxes/erxes/develop/ui/scripts/install.sh | sh
  else
    echo "Skipping erxes fronted"
fi

read -p "Install erxes api (y/n): " eapiAnswer 

if [ "$eapiAnswer" != "n" ];
  then
    echo 'Installing erxes api'
    curl https://raw.githubusercontent.com/erxes/erxes-api/develop/scripts/install.sh | sh
  else
    echo "Skipping erxes api"
fi

read -p "Install erxes widgets api (y/n): " ewapiAnswer 

if [ "$ewapiAnswer" != "n" ];
  then
    echo 'Installing erxes widgets api'
    curl https://raw.githubusercontent.com/erxes/erxes-widgets-api/develop/scripts/install.sh | sh
  else
    echo "Skipping erxes widgets api"
fi

read -p "Install erxes widgets (y/n): " ewAnswer 

if [ "$ewAnswer" != "n" ];
  then
    echo 'Installing erxes widgets'
    curl https://raw.githubusercontent.com/erxes/erxes-widgets/develop/scripts/install.sh | sh
  else
    echo "Skipping erxes widgets"
fi

echo "Replacing erxes-api .envs"
cd erxes-api
sed -i '' 's/REDIS_HOST=localhost/REDIS_HOST=redis/g' .env
sed -i '' 's/mongodb:\/\/localhost/mongodb:\/\/mongo/g' .env
cd ..

echo "Replacing erxes-widgets-api .envs"
cd erxes-widgets-api
sed -i '' 's/mongodb:\/\/localhost/mongodb:\/\/mongo/g' .env
sed -i '' 's/localhost:3300/erxes-api:3300/g' .env
cd ..

read -p "Run docker-compose up (y/n): " dcuAnswer 

if [ "$dcuAnswer" != "n" ];
  then
    cd dev-docker
    docker-compose up
  else
    echo "Skipping docker-compose up"
fi

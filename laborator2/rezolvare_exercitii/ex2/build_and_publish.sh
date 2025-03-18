docker images

docker build -t docker-swarm-exercises-io-service ./IOMicroservice
docker tag docker-swarm-exercises-io-service alexandraion226/io-service
docker push alexandraion226/io-service

docker build -t docker-swarm-exercises-gateway ./ApiGatewayMicroservice
docker tag docker-swarm-exercises-gateway alexandraion226/gateway
docker push alexandraion226/gateway

docker build -t docker-swarm-exercises-books-service ./BooksMicroservice
docker tag docker-swarm-exercises-books-service alexandraion226/books-service
docker push alexandraion226/books-service
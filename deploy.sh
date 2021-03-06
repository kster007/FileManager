VERSION=1.0.0
IMAGEN=kster/file_manager
NAME=file
mvn package
docker build -t $IMAGEN:$VERSION -f Dockerfile .
docker push $IMAGEN:$VERSION

ssh deploy@18.218.79.140 -o "StrictHostKeyChecking no" << EOF
docker pull $IMAGEN:$VERSION
docker service update \
  --image $IMAGEN:$VERSION \
    $NAME || true

docker service create \
        --name $NAME \
        --network appnet \
        --restart-condition any \
        --replicas=1  \
        --restart-delay 5s \
        --update-delay 10s \
        --update-parallelism 1 \
        $IMAGEN:$VERSION || true

EOF

#!/bin/bash

HOST_WORKSPACE="/home/bender/Development/Python/deep-image-prior" 
DOCKER_WORKSPACE="/home/project"

HOST_DATASETS="/home/bender/Partitions/ExternalHome/Projekte/DataSets"
DOCKER_DATASETS="/datasets"

docker run --rm --network host -it \
--gpus device=0 \
--env DISPLAY=$DISPLAY \
--env="QT_X11_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--mount source="$HOST_WORKSPACE",target=$DOCKER_WORKSPACE,type=bind,consistency=cached \
--mount source="$HOST_DATASETS",target=$DOCKER_DATASETS,type=bind,consistency=cached \
--workdir $DOCKER_WORKSPACE \
--env HOME=$DOCKER_WORKSPACE \
--env PYTHONPATH=$DOCKER_WORKSPACE \
dip:1.0


#--mount source=/home/fgvb5gl/Partitions/data/datasets,target=/mnt,type=bind \
#--security-opt=label=disable \
#--userns=keep-id

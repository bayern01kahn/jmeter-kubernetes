#!/bin/bash -e

docker build --tag="bayern01kahn/jmeter-base:0.1" -f kyma-Dockerfile-base .
docker build --tag="bayern01kahn/jmeter-master:0.1" -f kyma-Dockerfile-master .
docker build --tag="bayern01kahn/jmeter-slave:0.1" -f kyma-Dockerfile-slave .

docker push bayern01kahn/jmeter-base:0.1
docker push bayern01kahn/jmeter-master:0.1
docker push bayern01kahn/jmeter-slave:0.1

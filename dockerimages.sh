#!/bin/bash -e

docker build --tag="bayern01kahn/jmeter-base:latest" -f Dockerfile-base .
docker build --tag="bayern01kahn/jmeter-master:latest" -f Dockerfile-master .
docker build --tag="bayern01kahn/jmeter-slave:latest" -f Dockerfile-slave .
# docker build --tag="kubernautslabs/jmeter-reporter" -f Dockerfile-reporter .
